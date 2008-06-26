package mkSatCounter;

interface SatCounter#(numeric type bits);
  method Action up();
  method Action down();
  method Bit#(bits) value(); 
endinterface


module mkSatCounter#(Bit#(bits) init) (SatCounter#(bits));
  Reg#(Bit#(bits)) counter <- mkReg(init);
  RWire#(Bit#(0)) up_called <- mkRWire();
  RWire#(Bit#(0)) down_called <- mkRWire();  

  rule update;
    if(up_called.wget matches tagged Valid .x)
      begin
        if(down_called.wget matches tagged Invalid)
          if(counter != ~0)
            counter <= counter + 1;
      end   
    else
        if(down_called.wget matches tagged Valid .x)
            if(counter != 0)
               counter <= counter - 1;
  endrule

  method Action up();
    up_called.wset(0);
  endmethod

  method Action down();
    down_called.wset(0);
  endmethod

  method Bit#(bits) value();
    return counter;
  endmethod 


endmodule

endpackage 