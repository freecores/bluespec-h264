//**********************************************************************
// Interface for Buffer Controller
//----------------------------------------------------------------------
//
//
//

package IBufferControl;

import H264Types::*;
import GetPut::*;
import ClientServer::*;

interface IBufferControl;

   // Interface for inter-module io
   interface Put#(DeblockFilterOT) ioin;

   // Interface for module to frame buffer
   interface Client#(FrameBufferLoadReq,FrameBufferLoadResp) buffer_client_load;
   interface Get#(FrameBufferStoreReq) buffer_client_store;

   // Interface for module to interpolation
   interface Server#(InterpolatorLoadReq,InterpolatorLoadResp) inter_server;	 

endinterface

endpackage

