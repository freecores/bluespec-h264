//**********************************************************************
// Memory for Entropy Decoder
//----------------------------------------------------------------------
//
//
//

package mkMemED;

import H264Types::*;
import IMemED::*;
import GetPut::*;
import ClientServer::*;
import FIFO::*;
import BRAM::*;
import BlueBRAM::*;

//----------------------------------------------------------------------
// Main module
//----------------------------------------------------------------------

module mkMemED(IMemED#(index_size,data_size))
   provisos (Bits#(MemReq#(index_size,data_size),mReqLen),
	     Bits#(MemResp#(data_size),mRespLen));

  //-----------------------------------------------------------
  // State

   BlueBRAM#(Bit#(index_size),Bit#(data_size)) bramfile <- mkBlueBRAM_Full();
   
   FIFO#(MemReq#(index_size,data_size)) reqQ  <- mkFIFO();
   FIFO#(MemResp#(data_size))  respQ <- mkFIFO();
   
   rule storing ( reqQ.first() matches tagged StoreReq { addr:.addrt,data:.datat} );
      bramfile.write(addrt,datat);
      reqQ.deq(); 
   endrule

   rule reading ( reqQ.first() matches tagged LoadReq .addrt );
      bramfile.read_req(addrt);
      reqQ.deq();
   endrule

   rule readresp ( True );
      let temp <- bramfile.read_resp;
      respQ.enq( LoadResp (temp) );
   endrule
   
   interface Server mem_server;
      interface Put request  = fifoToPut(reqQ);
      interface Get response = fifoToGet(respQ);
   endinterface


endmodule

endpackage
