
package IMemClientBackend;


import MemControllerTypes::*;
import IMemClient::*;
import FIFOF::*;

interface IMemClientBackend#(type addr_type, type data_type);
  interface IMemClient#(addr_type, data_type) client_interface;
  interface FIFOF#(MemReq#(addr_type, data_type)) request_fifo; // Probably should change this... 
  method PRIORITY_LEVEL get_priority();
  method Action enqueue_response(data_type data_in);  
endinterface

endpackage