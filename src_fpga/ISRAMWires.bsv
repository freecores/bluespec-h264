  interface ISRAMWires;
    method Bit#(18) address_out();
    method Bit#(32) data_O();
    method Action data_I(Bit#(32) data);
    method Bit#(1) data_T();
    method Bit#(4) we_bytes_out();
    method Bit#(1) we_out();
    method Bit#(1) ce_out();
    method Bit#(1) oe_out();
    method Bit#(1) cen_out();
    method Bit#(1) adv_ld_out();
  endinterface