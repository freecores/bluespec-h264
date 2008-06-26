//**********************************************************************
// final output implementation
//----------------------------------------------------------------------
//
//

package mkFinalOutput;

import H264Types::*;
import IFinalOutput::*;
import FIFO::*;
import RegFile::*;

import Connectable::*;
import GetPut::*;

//-----------------------------------------------------------
// Final Output Module
//-----------------------------------------------------------

module mkFinalOutput( IFinalOutput );

   FIFO#(BufferControlOT)  infifo    <- mkFIFO; 
   Reg#(Bit#(27))    index   <- mkReg(0);

   Reg#(Bit#(32)) tick_counter <- mkReg(0);
   Reg#(Bit#(32)) data_seen_counter <- mkReg(0); 
   Reg#(Bit#(32)) last_f_count <- mkReg(0);
   Reg#(Bit#(32)) f_count <- mkReg(0);

   rule tick;
     tick_counter <= tick_counter + 1;
     if(tick_counter%2000000 == 0)
       begin
         if(last_f_count == f_count)
           begin
             $display("mkFinalOutput: Warning: no new frames, stuck at %d", last_f_count); 
           end
         else
           begin
             $display("mkFinalOutput: Feelin' fine current frames: %d", last_f_count); 
           end
         last_f_count <= f_count;
       end
   endrule

   //-----------------------------------------------------------
   // Rules
   rule finalout (True); 
    //  Bit#(32) data_constant = pack(fromInteger(horizontal_pixels * vertical_pixels))*3/2;
      //if(data_seen_counter + 4 > data_constant)
       // begin
       //   f_count <= f_count + 1;
       //   data_seen_counter <= 0; 
       // end 
      //else
      //  begin
      //    data_seen_counter <= data_seen_counter+4;
      //  end

      index <= index + 4;
      if(infifo.first() matches tagged YUV .xdata)
	 begin
            $display("OUT %h", xdata[7:0]);
            $display("OUT %h", xdata[15:8]);
            $display("OUT %h", xdata[23:16]);
            $display("OUT %h", xdata[31:24]);
	    infifo.deq();
	 end
      else
	 $finish(0);
   endrule


   interface Put ioin  = fifoToPut(infifo);

endmodule

endpackage