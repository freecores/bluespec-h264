//**********************************************************************
// Interface for Memory for Entropy Decoding
//----------------------------------------------------------------------
//
//
//


import H264Types::*;
import ClientServer::*;
import GetPut::*;

interface IMemEDDecoupled#(numeric type index_size, numeric type data_size);

  interface Put#(MemReq#(index_size,data_size)) request_store;
  interface Put#(MemReq#(index_size,data_size)) request_load;
  interface Get#(MemResp#(data_size)) response; 

endinterface

