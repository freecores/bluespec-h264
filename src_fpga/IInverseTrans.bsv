//**********************************************************************
// Interface for Inverse Quantizer and Inverse Transformer
//----------------------------------------------------------------------
//
//
//

package IInverseTrans;

import H264Types::*;
import GetPut::*;
import ClientServer::*;

interface IInverseTrans;

  // Interface for inter-module io
  interface Put#(EntropyDecOT_InverseTrans) ioin;
  interface Get#(InverseTransOT) ioout;

endinterface

endpackage

