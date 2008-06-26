import FIFO::*;
import RegFile::*;
import GetPut::*;

interface BlueBRAM#(type idx_type, type data_type);

  method Action read_req(idx_type idx);

  method ActionValue#(data_type) read_resp();

  method Action	write(idx_type idx, data_type data);
  
endinterface


interface BlueBRAM_GetPut#(type idx_type, type data_type);
 
  interface Put#(idx_type) read_req;
  interface Get#(data_type) read_resp;
  interface Put#(Tuple2#(idx_type, data_type)) write;

endinterface

module mkBlueBRAM_GetPut (BlueBRAM_GetPut#(idx_type, data_type))
  provisos
          (Bits#(idx_type, idx), 
	   Bits#(data_type, data),
	   Literal#(idx_type),
           Bounded#(idx_type));
  BlueBRAM#(idx_type,data_type) bram <- mkBlueBRAM_Full();

  interface Put read_req;
    method put = bram.read_req;
  endinterface

  interface Get read_resp;
    method get = bram.read_resp;
  endinterface


  interface Put write;
    method Action put(Tuple2#(idx_type, data_type) indata);
      bram.write(tpl_1(indata), tpl_2(indata));
    endmethod
  endinterface

endmodule



module mkBlueBRAM#(Integer low, Integer high) 
  //interface:
              (BlueBRAM#(idx_type, data_type)) 
  provisos
          (Bits#(idx_type, idx), 
	   Bits#(data_type, data),
	   Literal#(idx_type),
           Bounded#(idx_type));
	   
  BlueBRAM#(idx_type, data_type) m <- (valueof(data) == 0) ? 
                                  mkBlueBRAM_Zero() :
				  mkBlueBRAM_NonZero(low, high);

  return m;
endmodule

module mkBlueBRAM_NonZero#(Integer low, Integer high) 
  //interface:
              (BlueBRAM#(idx_type, data_type)) 
  provisos
          (Bits#(idx_type, idx), 
	   Bits#(data_type, data),
	   Literal#(idx_type),
           Bounded#(idx_type));
  RegFile#(idx_type, data_type) arr <- mkRegFileFull();
  FIFO#(data_type) outfifo <- mkSizedFIFO(8);

  method Action read_req(idx_type idx);
    outfifo.enq(arr.sub(idx));
  endmethod

  method ActionValue#(data_type) read_resp();
    outfifo.deq();
    return outfifo.first();
  endmethod 

  method Action	write(idx_type idx, data_type data);  
    arr.upd(idx, data);
  endmethod
endmodule

module mkBlueBRAM_Zero
  //interface:
              (BlueBRAM#(idx_type, data_type)) 
  provisos
          (Bits#(idx_type, idx), 
	   Bits#(data_type, data),
	   Literal#(idx_type));
  
  FIFO#(data_type) q <- mkSizedFIFO(8);

  method Action read_req(idx_type i);
     q.enq(?);
  endmethod

  method Action write(idx_type i, data_type d);
    noAction;
  endmethod

  method ActionValue#(data_type) read_resp();
    q.deq();
    return q.first();
  endmethod

endmodule

module mkBlueBRAM_Full 
  //interface:
              (BlueBRAM#(idx_type, data_type)) 
  provisos
          (Bits#(idx_type, idx), 
	   Bits#(data_type, data),
	   Literal#(idx_type),
           Bounded#(idx_type));


  BlueBRAM#(idx_type, data_type) br <- mkBlueBRAM(0, valueof(TExp#(idx)) - 1);

  return br;

endmodule