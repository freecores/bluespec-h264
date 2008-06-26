//**********************************************************************
// Interface for Vga Controller
//----------------------------------------------------------------------
//
//
//


interface IVgaController;
  method Bit#(8) red();
  method Bit#(8) blue();
  method Bit#(8) green();
  method Bit#(1) sync_on_green();
  method Bit#(1) hsync();
  method Bit#(1) vsync();
  method Bit#(1) blank();
  method Action  switch_buffer(Bit#(1) buffer);
endinterface
