import GetPut::*;
import H264Types::*;


module mkDeblockTee#(Get#(DeblockFilterOT) inputData, Put#(DeblockFilterOT) outputData, String prefix) ();

 rule processData;
   let dataIn <- inputData.get();
   outputData.put(dataIn); 
   $write(prefix);
   case (dataIn) matches
     tagged DFBLuma .data: $display("DFBLuma: hor: %d ver:%d data:%h", data.hor, data.ver, data.data);
     tagged DFBChroma .data: $display("DFBChroma: flag: %d hor: %d ver:%d data:%h", data.uv, data.hor, data.ver, data.data);
     tagged EndOfFrame: $display("EndOfFrame");
     tagged EDOT .data: $display("EDOT");
   endcase
 endrule
endmodule

 
