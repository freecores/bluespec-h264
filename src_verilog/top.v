module top;

  reg clk   = 0;
  reg reset = 0;
  
   always #5 clk <= ~clk; // this corresponds to 10ns duty cycle?

  mkTH th( .CLK(clk), .RST_N(reset) );
  
  initial
  begin
    // This turns on VCD (plus) output
    $vcdpluson(0);
     clk <= 0;    
     #600000;
     $finish;
  end
    
endmodule
