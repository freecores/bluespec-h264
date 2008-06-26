//**********************************************************************
// Memory for Entropy Decoder
//----------------------------------------------------------------------
//
//
//

package mkMemED;

import H264Types::*;
import IMemED::*;
import RegFile::*;
import GetPut::*;
import ClientServer::*;
import FIFO::*;


//----------------------------------------------------------------------
// Main module
//----------------------------------------------------------------------

module mkMemED(IMemED#(index_size,data_size))
   provisos (Bits#(MemReq#(index_size,data_size),mReqLen),
	     Bits#(MemResp#(data_size),mRespLen));

  //-----------------------------------------------------------
  // State

   RegFile#(Bit#(index_size),Bit#(data_size)) rfile <- mkRegFileFull();
   
   FIFO#(MemReq#(index_size,data_size)) reqQ  <- mkFIFO();
   FIFO#(MemResp#(data_size))  respQ <- mkFIFO();
   
   rule storing ( reqQ.first() matches tagged StoreReq { addr:.addrt,data:.datat} );
      rfile.upd(addrt,datat);
      reqQ.deq(); 
   endrule

   rule reading ( reqQ.first() matches tagged LoadReq .addrt );
      Bit#(data_size) data = rfile.sub(addrt);
      respQ.enq( tagged LoadResp data);
      reqQ.deq();
   endrule
   
   interface Server mem_server;
      interface Put request  = fifoToPut(reqQ);
      interface Get response = fifoToGet(respQ);
   endinterface


endmodule

endpackage
