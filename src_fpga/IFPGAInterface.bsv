//**********************************************************************
// Interface for FPGA
//----------------------------------------------------------------------
//
//
//

import IEDKBRAM::*;
import IVgaController::*;
import ISRAMWires::*;

interface IFPGAInterface;
  interface IVgaController vga_controller;
  interface IEDKBRAM       bram_controller;
  interface ISRAMWires     sram_controller;
  interface ISRAMWires     sram_controller2;  
  method Bit#(8) error_status();
endinterface