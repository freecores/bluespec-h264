import GetPut::*;
import H264Types::*;


module mkDeblockTee#(Get#(DeblockFilterOT) inputData, Put#(DeblockFilterOT) outputData, String prefix) ();

 Reg#(Bit#(32)) cycles <- mkReg(0);

 rule cycleup;
   cycles <= cycles + 1;
 endrule

 rule processData;
   let dataIn <- inputData.get();
   outputData.put(dataIn); 
   $write(prefix);
   case (dataIn) matches
     tagged DFBLuma .data: $display("DFBLuma(%d): hor: %d ver:%d data:%h\n", cycles,data.hor, data.ver, data.data);
     tagged DFBChroma .data: $display("DFBChroma(%d): flag: %d hor: %d ver:%d data:%h\n", cycles, data.uv, data.hor, data.ver, data.data);
     tagged EndOfFrame: $display("EndOfFrame(%d)", cycles);
     tagged EDOT .data: $display("EDOT");
   endcase
 endrule
endmodule

 
