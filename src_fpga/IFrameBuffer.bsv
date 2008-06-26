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
import ISRAMWires::*;

interface IFrameBuffer;

  // Interface from processor to cache
  interface Server#(FrameBufferLoadReq,FrameBufferLoadResp) server_load;
  interface Put#(FrameBufferStoreReq) server_store;
  interface ISRAMWires sram_controller;
endinterface

endpackage
