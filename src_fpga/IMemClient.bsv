
package IMemClient;
import MemControllerTypes::*;

interface IMemClient#(type idx_type, type data_type);

  method Action read_req(idx_type idx);

  method ActionValue#(data_type) read_resp();

  method Action	write(idx_type idx, data_type data);

  method Action set_priority(PRIORITY_LEVEL prio);  
endinterface

endpackage