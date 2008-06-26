#=======================================================================
# 6.375 Makefile for bsc-compile
#-----------------------------------------------------------------------
# $Id: Makefile,v 1.9 2008-06-26 18:04:51 jamey.hicks Exp $
#

default : all

basedir  = ../

#--------------------------------------------------------------------
# Sources
#--------------------------------------------------------------------

# Library components

bsvclibdir = $(MIT6375_HOME)/install/bsvclib
bsvclibsrcs = \

# Bluespec sources

toplevel_module = mkTH

srcdir = $(basedir)/src
bsvsrcs = \
	$(srcdir)/BRAM.bsv \
	$(srcdir)/H264Types.bsv \
	$(srcdir)/ExpGolomb.bsv \
	$(srcdir)/CAVLC.bsv \
	$(srcdir)/IH264.bsv \
	$(srcdir)/IInputGen.bsv \
	$(srcdir)/INalUnwrap.bsv \
	$(srcdir)/IEntropyDec.bsv \
	$(srcdir)/ICalc_nC.bsv \
	$(srcdir)/IMemED.bsv \
	$(srcdir)/IInverseTrans.bsv \
	$(srcdir)/IPrediction.bsv \
	$(srcdir)/IInterpolator.bsv \
	$(srcdir)/IDeblockFilter.bsv \
	$(srcdir)/IBufferControl.bsv \
	$(srcdir)/IFrameBuffer.bsv \
	$(srcdir)/IFinalOutput.bsv \
	$(srcdir)/mkH264.bsv \
	$(srcdir)/mkInputGen.bsv \
	$(srcdir)/mkNalUnwrap.bsv \
	$(srcdir)/mkEntropyDec.bsv \
	$(srcdir)/mkCalc_nC.bsv \
	$(srcdir)/mkMemED.bsv \
	$(srcdir)/mkInverseTrans.bsv \
	$(srcdir)/mkPrediction.bsv \
	$(srcdir)/mkInterpolator.bsv \
	$(srcdir)/mkDeblockFilter.bsv \
	$(srcdir)/mkBufferControl.bsv \
	$(srcdir)/mkFrameBuffer.bsv \
	$(srcdir)/mkFinalOutput.bsv \
	$(srcdir)/mkTH.bsv \
        $(srcdir)/EntropyTee.bsv \
        $(srcdir)/DeblockTee.bsv \
        $(srcdir)/MemoryTee.bsv \
        $(srcdir)/IDecoupledClient.bsv \
	$(srcdir)/IMemEDDecoupled.bsv \
	$(srcdir)/mkMemEDDecoupled.bsv \
	$(srcdir)/FIFOUtility.bsv \
        $(srcdir)/Print.bsv \
#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

BSC_COMP = bsc
#BSC_OPTS = -u -show-module-use -verilog -keep-fires -aggressive-conditions \
#           -relax-method-earliness -relax-method-urgency -v

BSC_OPTS = -u -v -sim -aggressive-conditions

# Copy over the bluespec source

$(notdir $(bsvsrcs)) : % : $(srcdir)/%
	cp $< .

$(notdir $(bsvclibsrcs)) : % : $(bsvclibdir)/%
	cp $< .

# Run the bluespec compiler

bsv_TH_vsrc = $(toplevel_module).v
$(bsv_TH_vsrc) $(bsv_lib_use) : $(notdir $(bsvsrcs) $(bsvclibsrcs))
	$(BSC_COMP) $(BSC_OPTS) +RTS -K2000M -RTS -g $(toplevel_module) $(toplevel_module).bsv > out.log

compile : $(toplevel_module).v

# Create a schedule file

schedule_rpt = schedule.rpt
$(schedule_rpt) : $(notdir $(bsvsrcs) $(bsvclibsrcs))
	rm -rf *.v
	$(BSC_COMP) $(BSC_OPTS) -show-schedule -show-rule-rel \* \* -g $(toplevel_module) \
                $(toplevel_module).bsv >& $(schedule_rpt)

junk += $(notdir $(bsvsrcs)) $(notdir $(bsvclibsrcs)) \
	    $(schedule_rpt) *.use *.bi *.bo *.v bsc.log

#--------------------------------------------------------------------
# Default make target
#--------------------------------------------------------------------

all : compile

#--------------------------------------------------------------------
# Clean up
#--------------------------------------------------------------------

clean :
	rm -rf $(junk) *~ \#* 
