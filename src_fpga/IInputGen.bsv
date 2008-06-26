//**********************************************************************
// Interface for input generator
//----------------------------------------------------------------------
//
//
//

package IInputGen;

import H264Types::*;
import GetPut::*;
import IEDKBRAM::*;

interface IInputGen;

  // Interface for inter-module io
  interface Get#(InputGenOT) ioout;
  interface IEDKBRAM bram_interface;

endinterface

endpackage

