import H264Types::*;
import GetPut::*;
import ClientServer::*;


module mkMemoryTee#(Client#(req_type,resp_type) client, Server#(req_type,resp_type) server, String prefix) () 
  provisos(
            Bits#(req_type, req_type_sz),
            Bits#(resp_type, resp_type_sz))  ;

  rule clientToServer;
    let clientReq <- client.request.get();
    server.request.put(clientReq);
    $write(prefix);
    $write(" REQ ");
    $display("%h", clientReq);
  endrule

  rule serverToClient;
    let clientResp <- server.response.get();
    client.response.put(clientResp);
    $write(prefix);
    $write(" RESP ");
    $display("%h", clientResp);
  endrule 

endmodule