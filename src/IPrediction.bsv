//**********************************************************************
// Interface for Prediction
//----------------------------------------------------------------------
//
//
//

package IPrediction;

import H264Types::*;
import GetPut::*;
import ClientServer::*;

interface IPrediction;

  // Interface for inter-module io
  interface Put#(EntropyDecOT) ioin;
  interface Put#(InverseTransOT) ioin_InverseTrans;
  interface Get#(EntropyDecOT) ioout;

  // Interface for module to memory
  interface Client#(MemReq#(TAdd#(PicWidthSz,2),68),MemResp#(68)) mem_client_intra;
  interface Client#(MemReq#(TAdd#(PicWidthSz,2),32),MemResp#(32)) mem_client_inter;
  interface Client#(InterpolatorLoadReq,InterpolatorLoadResp) mem_client_buffer;

endinterface

endpackage

