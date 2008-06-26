import GetPut::*; 

interface IDecoupledClient#(type req, type resp);
  interface Get#(req) request_store;
  interface Get#(req) request_load;
  interface Put#(resp) response; 
endinterface
