//**********************************************************************
// Input Generator implementation
//----------------------------------------------------------------------
//
//

package mkInputGen;

import H264Types::*;
import IInputGen::*;
import RegFile::*;
import FIFO::*;

import Connectable::*;
import GetPut::*;

`define INPUT_SIZE 10000000 

module mkInputGen( IInputGen );
   RegFile#(Bit#(1), Bit#(32)) rfile2 <- mkRegFileFullLoad("input_size.hex");
   RegFile#(Bit#(27), Bit#(8)) rfile <- mkRegFileLoad("input.hex", 0, `INPUT_SIZE);
   
   FIFO#(InputGenOT) outfifo <- mkFIFO;
   Reg#(Bit#(27))    index   <- mkReg(0);
   Reg#(Bit#(27))    file_size <- mkReg(0);
   Reg#(Bool)        initialized <- mkReg(False);

   rule init (!initialized); 
      file_size <= truncate(rfile2.sub(0));
      $display("File Size: %h", rfile2.sub(0));
      initialized <= True;
   endrule

   rule output_byte ((index < file_size) && initialized);
      $display( "ccl0inputbyte %h", rfile.sub(index) );
      outfifo.enq(DataByte (rfile.sub(index)));
      index <= index+1;
   endrule

   rule end_of_file (index == file_size && initialized);
      //$finish(0);
      outfifo.enq(EndOfFile);
   endrule
   
   interface Get ioout = fifoToGet(outfifo);
   
endmodule


endpackage
