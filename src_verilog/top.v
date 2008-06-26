module top;

  reg clk   = 0;
  reg reset = 0;
  
   always #5 clk = ~clk; // this corresponds to 10ns duty cycle?

  mkTH th( .CLK(clk), .RST_N(reset) );
  
  initial
  begin
    // This turns on VCD (plus) output
    $sdf_annotate("./top.sdf",th.h264);
    $dumpfile("dump.vcd");
    $dumpvars;
     $dumpoff;
  
     clk = 0;
     #30;
     reset = 1;
     #7200;
     $dumpon;
     #60000;
     $dumpoff;
     #1000;
     $finish; 
  end 
     
endmodule 
