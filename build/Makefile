#=======================================================================
# 6.375 Makefile for bsc-compile
#-----------------------------------------------------------------------
# $Id: Makefile,v 1.11 2008-06-26 18:10:59 jamey.hicks Exp $
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
reldir = $(basedir)/release
lcpdir = $(basedir)/LumaChromaParallel
        $(srcdir)/MemoryTee.bsv \
        $(srcdir)/IDecoupledClient.bsv \
	$(srcdir)/IMemEDDecoupled.bsv \
	$(srcdir)/mkMemEDDecoupled.bsv \
	$(srcdir)/FIFOUtility.bsv \
#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

BSC_COMP = bsc
#BSC_OPTS = -u -show-module-use -verilog -keep-fires -aggressive-conditions \
#           -relax-method-earliness -relax-method-urgency -v

BSC_OPTS = -u -v -verilog -aggressive-conditions


mainline : 
	$(BSC_COMP) $(BSC_OPTS) -bdir ./ -p +:$(srcdir) -g $(toplevel_module) $(srcdir)/$(toplevel_module).bsv > out.log

release : 
	$(BSC_COMP) $(BSC_OPTS) -bdir ./ -p +:$(reldir)/ -g $(toplevel_module) $(reldir)/$(toplevel_module).bsv> out.log\

LCP : 
	$(BSC_COMP) $(BSC_OPTS) -bdir ./ -p +:$(lcpdir):$(reldir)/ -g $(toplevel_module) $(reldir)/$(toplevel_module).bsv> out.log\

#--------------------------------------------------------------------
# Default make target
#--------------------------------------------------------------------

all : mainline

#--------------------------------------------------------------------
# Clean up
#--------------------------------------------------------------------

clean :
	rm -rf $(junk) *~ \#* *.cxx *.ba *.o *.h *.bi *.bo *.bsv
 