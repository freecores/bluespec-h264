
package IMemScheduler;


import MemControllerTypes::*;
import Vector::*;

interface IMemScheduler#(type number_clients, type address_type);  
  method ActionValue#(Maybe#(Bit#(TAdd#(1, TLog#(number_clients))))) choose_client(Vector#(number_clients, MemReqType#(address_type)) req_vec);
endinterface

endpackage