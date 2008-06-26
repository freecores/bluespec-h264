//**********************************************************************
// Interface for EDK BRAM
//----------------------------------------------------------------------
//
//
//

package IEDKBRAM;

interface IEDKBRAM;
  method Action   data_input(Bit#(32) data);
  method Bit#(4)  wen_output();
  method Bit#(32) addr_output();
  method Bit#(32) data_output();
endinterface

endpackage