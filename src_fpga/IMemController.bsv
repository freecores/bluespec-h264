package IMemController;
import MemControllerTypes::*;
import IMemClient::*;
import Vector::*;

interface IMemController#(type client_number, type address_type, type data_type);

  interface Vector#(client_number, IMemClient#(address_type, data_type)) client_interfaces;
  
endinterface

endpackage