//**********************************************************************
// Interface for interpolator
//----------------------------------------------------------------------
//
//
//

package IInterpolator;

import H264Types::*;
import GetPut::*;
import Vector::*;
import ClientServer::*;

interface Interpolator;
   method Action   setPicWidth( Bit#(PicWidthSz) newPicWidth );
   method Action   setPicHeight( Bit#(PicHeightSz) newPicHeight );
   method Action   request( InterpolatorIT inputdata );
   method Vector#(4,Bit#(8)) first();
   method Action   deq();
   method Action   endOfFrame();
   interface Client#(InterpolatorLoadReq,InterpolatorLoadResp) mem_client;
endinterface

endpackage

