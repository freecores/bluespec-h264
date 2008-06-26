//**********************************************************************
// Interface for Frame Buffer
//----------------------------------------------------------------------
//
//
//

package IFrameBuffer;

import H264Types::*;
import ClientServer::*;
import GetPut::*;

interface IFrameBuffer;

  // Interface from processor to cache
  interface Server#(FrameBufferLoadReq,FrameBufferLoadResp) server_load1;
  interface Server#(FrameBufferLoadReq,FrameBufferLoadResp) server_load2;
  interface Put#(FrameBufferStoreReq) server_store;

endinterface

endpackage
