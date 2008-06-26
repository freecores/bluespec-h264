//**********************************************************************
// Frame Buffer
//----------------------------------------------------------------------
//
//
//

package mkFrameBuffer;

import H264Types::*;
import IFrameBuffer::*;
import RegFile::*;
import GetPut::*;
import ClientServer::*;
import FIFO::*;


//-----------------------------------------------------------
// Register file module
//-----------------------------------------------------------

interface FBRFile2;
   method Action store( Bit#(FrameBufferSz) addr, Bit#(32) data );
   method Bit#(32) load1( Bit#(FrameBufferSz) addr );
   method Bit#(32) load2( Bit#(FrameBufferSz) addr );
endinterface

module mkFBRFile2( FBRFile2 );

   RegFile#(Bit#(FrameBufferSz),Bit#(32)) rfile <- mkRegFile(0,frameBufferSize);
   
   method Action store( Bit#(FrameBufferSz) addr, Bit#(32) data );
      rfile.upd( addr, data );
   endmethod
   
   method Bit#(32) load1( Bit#(FrameBufferSz) addr );  
      return rfile.sub(addr);
   endmethod
   
   method Bit#(32) load2( Bit#(FrameBufferSz) addr );
      return rfile.sub(addr);
   endmethod
   
endmodule


//----------------------------------------------------------------------
// Main module
//----------------------------------------------------------------------

module mkFrameBuffer( IFrameBuffer );

  //-----------------------------------------------------------
  // State

   FBRFile2 rfile2 <- mkFBRFile2;
   
   FIFO#(FrameBufferLoadReq)  loadReqQ1  <- mkFIFO();
   FIFO#(FrameBufferLoadResp) loadRespQ1 <- mkFIFO();
   FIFO#(FrameBufferLoadReq)  loadReqQ2  <- mkFIFO();
   FIFO#(FrameBufferLoadResp) loadRespQ2 <- mkFIFO();
   FIFO#(FrameBufferStoreReq) storeReqQ  <- mkFIFO();

   rule loading1 ( loadReqQ1.first() matches tagged FBLoadReq .addrt );
      if(addrt<frameBufferSize)
	 begin
	    loadRespQ1.enq( FBLoadResp rfile2.load1(addrt) );
	    loadReqQ1.deq();
	 end
      else
	 $display( "ERROR FrameBuffer: loading1 outside range" );
   endrule
   
   rule loading2 ( loadReqQ2.first() matches tagged FBLoadReq .addrt );
      if(addrt<frameBufferSize)
	 begin
	    loadRespQ2.enq( FBLoadResp rfile2.load2(addrt) );
	    loadReqQ2.deq();
	 end
      else
	 $display( "ERROR FrameBuffer: loading2 outside range" );
   endrule

   rule storing ( storeReqQ.first() matches tagged FBStoreReq { addr:.addrt,data:.datat} );
      if(addrt<frameBufferSize)
	 begin
	    rfile2.store(addrt,datat);
	    storeReqQ.deq();
	 end
      else
	 $display( "ERROR FrameBuffer: storing outside range" );
   endrule
   
   rule syncing ( loadReqQ1.first() matches tagged FBEndFrameSync &&& loadReqQ2.first() matches tagged FBEndFrameSync &&& storeReqQ.first() matches tagged FBEndFrameSync);
      loadReqQ1.deq();
      loadReqQ2.deq();
      storeReqQ.deq();
   endrule

   
   interface Server server_load1;
      interface Put request   = fifoToPut(loadReqQ1);
      interface Get response  = fifoToGet(loadRespQ1);
   endinterface
   interface Server server_load2;
      interface Put request   = fifoToPut(loadReqQ2);
      interface Get response  = fifoToGet(loadRespQ2);
   endinterface
   interface Put server_store = fifoToPut(storeReqQ);

endmodule

endpackage
