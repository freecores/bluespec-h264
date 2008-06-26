
package MemControllerTypes;

typedef Bit#(3) PRIORITY_LEVEL;

typedef union tagged
{
  struct {addr_type addr; data_type data;} StoreReq;  
  struct {addr_type addr; } LoadReq; 
}
MemReq#(type addr_type, type data_type)
deriving(Eq,Bits);

typedef struct {

  PRIORITY_LEVEL prio;
  union tagged
  {
    addr_type StoreReq;  
    addr_type LoadReq;
    void      Nop; 
  } req;
}
MemReqType#(type addr_type)
deriving(Eq,Bits);

endpackage