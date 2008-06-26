import RegFile::*;
import ISRAMWires::*;

interface ISRAMEmulator;

endinterface


module mkSRAMEmulator#(ISRAMWires wires) (ISRAMEmulator);
  RegFile#(Bit#(18), Bit#(32))  arr <- mkRegFileFull();
  Reg#(Bit#(18)) addr_p <- mkReg(0);
  Reg#(Bit#(18)) addr_pp <- mkReg(0);
  Reg#(Bit#(1))  we_p <- mkReg(0);
  Reg#(Bit#(1))  we_pp <- mkReg(0);
 
  rule tick;
    Bit#(18) addr_pt = wires.address_out();
    Bit#(32) data_Ot = wires.data_O();
    wires.data_I(arr.sub(addr_pp)); 
    addr_p <= addr_pt;
    addr_pp <= addr_p;
    we_p <= wires.we_out();
    we_pp <= we_p;
      
    if(we_pp == 1)
      begin
        //$display("MemClient SRAM Emulator: index %h reading %h", addr_pp, arr.sub(addr_pp));   
      end   
    else
      begin
        //$display("MemClient SRAM Emulator: index %h writing %h", addr_pp, data_Ot);
        arr.upd(addr_pp, data_Ot);
      end
  endrule

endmodule

