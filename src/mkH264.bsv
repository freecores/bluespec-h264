//**********************************************************************
// H264 Main Module
//----------------------------------------------------------------------
//
//

package mkH264;

import H264Types::*;
import IH264::*;
import INalUnwrap::*;
import IEntropyDec::*;
import IInverseTrans::*;
import IPrediction::*;
import IDeblockFilter::*;
import IBufferControl::*;
import mkNalUnwrap::*;
import mkEntropyDec::*;
import mkInverseTrans::*;
import mkPrediction::*;
import mkDeblockFilter::*;
import mkBufferControl::*;
import EntropyTee::*;
import DeblockTee::*;
 
import Connectable::*;
import GetPut::*;
import ClientServer::*;

(* synthesize *)
module mkH264( IH264 );

   // Instantiate the modules

   INalUnwrap     nalunwrap     <- mkNalUnwrap();
   IEntropyDec    entropydec    <- mkEntropyDec();
   IInverseTrans  inversetrans  <- mkInverseTrans();
   IPrediction    prediction    <- mkPrediction();
   IDeblockFilter deblockfilter <- mkDeblockFilter();
   IBufferControl buffercontrol <- mkBufferControl();

   // Internal connections
   mkConnection( prediction.mem_client_buffer, buffercontrol.inter_server );

   mkConnection( nalunwrap.ioout, entropydec.ioin );
   mkConnection( entropydec.ioout_InverseTrans, inversetrans.ioin );
   mkConnection( entropydec.ioout, prediction.ioin );
   mkConnection( inversetrans.ioout, prediction.ioin_InverseTrans );
   Empty predictionDeblockConnection <- mkEntropyTee(prediction.ioout, deblockfilter.ioin,"PREDEB: ");
   Empty deblockBuffercontrolConnection <- mkDeblockTee( deblockfilter.ioout, buffercontrol.ioin, "DEBBUF: " );

   // Interface to input generator
   interface ioin = nalunwrap.ioin;
   
   // Memory interfaces
   interface mem_clientED          = entropydec.mem_client; 
   interface mem_clientP_intra     = prediction.mem_client_intra;
   interface mem_clientP_inter     = prediction.mem_client_inter;
   interface mem_clientD_data      = deblockfilter.mem_client_data;
   interface mem_clientD_parameter = deblockfilter.mem_client_parameter;
   interface buffer_client_load1   = buffercontrol.buffer_client_load1;
   interface buffer_client_load2   = buffercontrol.buffer_client_load2;
   interface buffer_client_store   = buffercontrol.buffer_client_store;

   // Interface for output 
   interface ioout = buffercontrol.ioout;
      
endmodule

endpackage
