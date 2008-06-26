//**********************************************************************
// Memory for Entropy Decoder
//----------------------------------------------------------------------
//
//
//

import H264Types::*;
import IMemEDDecoupled::*;
import RegFile::*;
import GetPut::*;
import ClientServer::*;
import FIFO::*;


//----------------------------------------------------------------------
// Main module
//----------------------------------------------------------------------

module mkMemEDDecoupled(IMemEDDecoupled#(index_size,data_size))
   provisos (Bits#(MemReq#(index_size,data_size),mReqLen),
	     Bits#(MemResp#(data_size),mRespLen));

  //-----------------------------------------------------------
  // State

   RegFile#(Bit#(index_size),Bit#(data_size)) rfile <- mkRegFileWCF(0,fromInteger(valueof(TSub#(TExp#(index_size),1))));
   
   FIFO#(MemReq#(index_size,data_size)) reqQStore  <- mkFIFO();
   FIFO#(MemReq#(index_size,data_size)) reqQLoad   <- mkFIFO();
   FIFO#(MemResp#(data_size))  respQ <- mkFIFO();
   
   rule storing ( reqQStore.first() matches tagged StoreReq { addr:.addrt,data:.datat} );
      rfile.upd(addrt,datat);
      reqQStore.deq(); 
   endrule

   rule reading ( reqQLoad.first() matches tagged LoadReq .addrt );
      respQ.enq( tagged LoadResp (rfile.sub(addrt)) );
      reqQLoad.deq();
   endrule
   
  
   interface Put request_store  = fifoToPut(reqQStore);
   interface Put request_load  = fifoToPut(reqQLoad);   
   interface Get response = fifoToGet(respQ);

endmodule

