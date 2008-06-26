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

`define INPUT_SIZE 1480433 

module mkInputGen( IInputGen );

   RegFile#(Bit#(27), Bit#(8)) rfile <- mkRegFileLoad("akiyo224x176_1-300.hex", 0, `INPUT_SIZE);
   
   FIFO#(InputGenOT) outfifo <- mkFIFO;
   Reg#(Bit#(27))    index   <- mkReg(0);

   rule output_byte (index < `INPUT_SIZE);
      //$display( "ccl0inputbyte %x", rfile.sub(index) );
      outfifo.enq(DataByte (rfile.sub(index)));
      index <= index+1;
   endrule

   rule end_of_file (index == `INPUT_SIZE);
      //$finish(0);
      outfifo.enq(EndOfFile);
   endrule
   
   interface Get ioout = fifoToGet(outfifo);
   
endmodule


endpackage
