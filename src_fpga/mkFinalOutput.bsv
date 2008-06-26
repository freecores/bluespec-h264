//**********************************************************************
// final output implementation
//----------------------------------------------------------------------
//
//

package mkFinalOutput;

import H264Types::*;
import IFinalOutput::*;
import FIFO::*;

import Connectable::*;
import GetPut::*;

//-----------------------------------------------------------
// Final Output Module
//-----------------------------------------------------------

module mkFinalOutput( IFinalOutput );

   FIFO#(BufferControlOT)  infifo    <- mkFIFO;

   //-----------------------------------------------------------
   // Rules
   rule finalout (True);
      if(infifo.first() matches tagged YUV .xdata)
	 begin
	    $display("ccl5finalout %h", xdata[7:0]);
	    $display("ccl5finalout %h", xdata[15:8]);
	    $display("ccl5finalout %h", xdata[23:16]);
	    $display("ccl5finalout %h", xdata[31:24]);
	    infifo.deq();
	 end
      else
	 $finish(0);
   endrule


   interface Put ioin  = fifoToPut(infifo);

endmodule

endpackage