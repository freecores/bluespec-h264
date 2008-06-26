// The MIT License

// Copyright (c) 2006-2007 Massachusetts Institute of Technology

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
import GetPut::*;
import H264Types::*;



module mkEntropyTee#(Get#(EntropyDecOT) inputData, Put#(EntropyDecOT) outputDataLuma,  Put#(EntropyDecOT) outputDataChroma, String prefix) ();

 rule processDisplay;
   let dataIn <- inputData.get(); 
   outputData.put(dataIn);
   $write(prefix);
   $write("BIN ");
   $display("%h", pack(dataIn));

   $write(prefix);
   case (dataIn) matches
     tagged  NewUnit .nu: begin $display("NewUnit: %d", nu);outputData.put(dataIn);  
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSseq_parameter_set_id .data: begin $display("SPSseq_parameter_set_id: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSlog2_max_frame_num .data: begin $display("SPSlog2_max_frame_num: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSpic_order_cnt_type .data: begin $display("SPSpic_order_cnt_type: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSlog2_max_pic_order_cnt_lsb .data: begin $display("SPSlog2_max_pic_order_cnt_lsb: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSdelta_pic_order_always_zero_flag .data: begin $display("SPSdelta_pic_order_always_zero_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSoffset_for_non_ref_pic .data: begin $display("SPSoffset_for_non_ref_pic: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSoffset_for_top_to_bottom_field .data: begin $display("SPSoffset_for_top_to_bottom_field: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSnum_ref_frames_in_pic_order_cnt_cycle .data: begin $display("SPSnum_ref_frames_in_pic_order_cnt_cycle: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSoffset_for_ref_frame .data: begin $display("SPSoffset_for_ref_frame: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSnum_ref_frames .data: begin $display("SPSnum_ref_frames: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSgaps_in_frame_num_allowed_flag .data: begin $display("SPSgaps_in_frame_num_allowed_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSpic_width_in_mbs .data: begin $display("SPSpic_width_in_mbs: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSpic_height_in_map_units .data: begin $display("SPSpic_height_in_map_units: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSdirect_8x8_inference_flag .data: begin $display("SPSdirect_8x8_inference_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSframe_cropping_flag .data: begin $display("SPSframe_cropping_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSframe_crop_left_offset .data: begin $display("SPSframe_crop_left_offset: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSframe_crop_right_offset .data: begin $display("SPSframe_crop_right_offset: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSframe_crop_top_offset .data: begin $display("SPSframe_crop_top_offset: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SPSframe_crop_bottom_offset .data: begin $display("SPSframe_crop_bottom_offset: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSpic_parameter_set_id .data: begin $display("PPSpic_parameter_set_id: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSseq_parameter_set_id .data: begin $display("PPSseq_parameter_set_id: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSpic_order_present_flag .data: begin $display("PPSpic_order_present_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSnum_ref_idx_l0_active .data: begin $display("PPSnum_ref_idx_l0_active: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSnum_ref_idx_l1_active .data: begin $display("PPSnum_ref_idx_l1_active: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSdeblocking_filter_control_present_flag .data: begin $display("PPSdeblocking_filter_control_present_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PPSconstrained_intra_pred_flag .data: begin $display("PPSconstrained_intra_pred_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHfirst_mb_in_slice .data: begin $display("SHfirst_mb_in_slice: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHslice_type .data: begin $display("SHslice_type: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHpic_parameter_set_id .data: begin $display("SHpic_parameter_set_id: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHframe_num .data: begin $display("SHframe_num: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHidr_pic_id .data: begin $display("SHidr_pic_id: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHpic_order_cnt_lsb .data: begin $display("SHpic_order_cnt_lsb: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHdelta_pic_order_cnt_bottom .data: begin $display("SHdelta_pic_order_cnt_bottom: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHdelta_pic_order_cnt0 .data: begin $display("SHdelta_pic_order_cnt0: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHdelta_pic_order_cnt1 .data: begin $display("SHdelta_pic_order_cnt1: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHnum_ref_idx_active_override_flag .data: begin $display("SHnum_ref_idx_active_override_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHnum_ref_idx_l0_active .data: begin $display("SHnum_ref_idx_l0_active: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHRref_pic_list_reordering_flag_l0 .data: begin $display("HRref_pic_list_reordering_flag_l0: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHRreordering_of_pic_nums_idc .data: begin $display("SHRreordering_of_pic_nums_idc: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHRabs_diff_pic_num .data: begin $display("SHRabs_diff_pic_num: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHRlong_term_pic_num .data: begin $display("SHRlong_term_pic_num: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDno_output_of_prior_pics_flag .data: begin $display("SHDno_output_of_prior_pics_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDlong_term_reference_flag .data: begin $display("SHDlong_term_reference_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDadaptive_ref_pic_marking_mode_flag .data: begin $display("SHDadaptive_ref_pic_marking_mode_flag: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDmemory_management_control_operation .data: begin $display("SHDmemory_management_control_operation: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDdifference_of_pic_nums .data: begin $display("SHDdifference_of_pic_nums: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDlong_term_pic_num .data: begin $display("SHDlong_term_pic_num: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDlong_term_frame_idx .data: begin $display("SHDlong_term_frame_idx: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHDmax_long_term_frame_idx_plus1 .data: begin $display("SHDmax_long_term_frame_idx_plus1: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHdisable_deblocking_filter_idc .data: begin $display("SHdisable_deblocking_filter_idc: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHslice_alpha_c0_offset .data: begin $display("SHslice_alpha_c0_offset: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SHslice_beta_offset .data: begin $display("SHslice_beta_offset: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDmb_skip_run .data: begin $display("SDmb_skip_run: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMmbtype .data: begin $display("SDMmbtype: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMpcm_sample_luma .data: begin $display("SDMpcm_sample_luma: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMpcm_sample_chroma .data: begin $display("SDMpcm_sample_chroma: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMMrem_intra4x4_pred_mode .data: begin $display("SDMMrem_intra4x4_pred_mode: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMMintra_chroma_pred_mode .data: begin $display("SDMMintra_chroma_pred_mode: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMMref_idx_l0 .data: begin $display("SDMMref_idx_l0: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMMmvd_l0 .data: begin $display("SDMMmvd_l0: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMSsub_mb_type .data: begin $display("SDMSsub_mb_type: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMSref_idx_l0 .data: begin $display("SDMSref_idx_l0: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  SDMSmvd_l0 .data: begin $display("SDMSmvd_l0: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  IBTmb_qp .qps: begin $display("IBTmb_qp: qpy: begin %d qpc: %d", qps.qpy, qps.qpc); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PBbS .pbs: begin $display("PBbS: bSHor: begin %d bSVer: %d", pbs.bShor, pbs.bSver); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  PBoutput .xdata: begin 
                                match {.chromaFlag, .vec} = .xdata
                                $display("PBoutput: %h %h %h %h", vec[0],vec[1],vec[2],vec[3]); 
                                if(chromaFlag == Luma)
                                  begin 
                                    outputDataLuma.put(dataIn);
                                  end
                                else 
                                  begin  
                                    outputDataChroma.put(dataIn);
				  end
                          end
     tagged  AUDPrimaryPicType .data: begin $display("AUDPrimaryPicType: %d",data); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  EndOfSequence: begin $display("EndOfSequence"); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  EndOfStream: begin $display("EndOfStream"); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
     tagged  EndOfFile:   begin $display("EndOfFile"); 
                                outputDataLuma.put(dataIn);  
                                outputDataChroma.put(dataIn); 
                          end
   endcase  
 endrule   
endmodule
