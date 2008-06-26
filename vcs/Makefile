#=======================================================================
# 6.375 Makefile for vcs-sim-rtl
#-----------------------------------------------------------------------
# $Id: Makefile,v 1.1 2008-06-26 18:00:05 jamey.hicks Exp $
#
# This makefile will build a rtl simulator and run various tests to
# verify proper functionality.
#

default : all

basedir  = ../..

#--------------------------------------------------------------------
# Sources
#--------------------------------------------------------------------

# Verilog sources
vsrcdir = $(basedir)/src
bsrcdir = $(basedir)/build/bsc-compile

vsrcs = \
	$(bsrcdir)/mkCoreTH.v \
	$(bsrcdir)/mkCore.v \
	$(bsrcdir)/mkDataCacheBlocking.v \
	$(bsrcdir)/mkInstCacheBlocking.v \
	$(bsrcdir)/mkMainMem_latency1.v \
	$(bsrcdir)/mkMemArb.v \
	$(bsrcdir)/mkProc.v \
	$(vsrcdir)/mkCoreTH_wrapper.v \

# Globally installed assembly tests

global_tstdir = $(MIT6375_HOME)/install/smips-tests
global_asm_tests = \
	smipsv1_simple.S \
	smipsv1_addiu.S \
	smipsv1_bne.S \
	smipsv1_lw.S \
	smipsv1_sw.S \
	smipsv2_addiu.S \
	smipsv2_addu.S \
	smipsv2_andi.S \
	smipsv2_and.S \
	smipsv2_beq.S \
	smipsv2_bgez.S \
	smipsv2_bgtz.S \
	smipsv2_blez.S \
	smipsv2_bltz.S \
	smipsv2_bne.S \
	smipsv2_jalr.S \
	smipsv2_jal.S \
	smipsv2_jr.S \
	smipsv2_j.S \
	smipsv2_lui.S \
	smipsv2_lw.S \
	smipsv2_nor.S \
	smipsv2_ori.S \
	smipsv2_or.S \
	smipsv2_simple.S \
	smipsv2_sll.S \
	smipsv2_sllv.S \
	smipsv2_slti.S \
	smipsv2_sltiu.S \
	smipsv2_slt.S \
	smipsv2_sltu.S \
	smipsv2_sra.S \
	smipsv2_srav.S \
	smipsv2_srl.S \
	smipsv2_srlv.S \
	smipsv2_subu.S \
	smipsv2_sw.S \
	smipsv2_xori.S \
	smipsv2_xor.S \

# Local assembly tests

local_tstdir = $(basedir)/tests
local_asm_tests = \
#	hazard.S\

# Globally installed benchmarks

global_bmarkdir = $(MIT6375_HOME)/install/smips-bmarks
global_bmarks = \
	median \
	qsort \
	towers \
	vvadd \

# Locally installed benchmarks

local_bmarkdir = $(basedir)/bmarks
local_bmarks = \
	multiply \


#Myron told me to add you
vclibdir  = $(MIT6375_HOME)/install/bsvclib
vclibsrcs = \
        $(vclibdir)/mkEHRReg4.v \
        $(vclibdir)/mkResetRegFileFull_h.v \

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

HOST_OPTS = -DPREALLOCATE=0 -DHOST_DEBUG=1 
HOST_COMP = gcc $(HOST_OPTS)

VCS      = vcs
VCS_OPTS = -notice -PP -line +lint=all +v2k -timescale=1ns/10ps 

SMIPS_TESTBUILD = smips-testbuild -smips -opti O2
SMIPS_OBJDUMP = smips-objdump --disassemble-all --disassemble-zeroes
SMIPS_OBJDUMP_TO_VMH = objdump2vmh.pl 

SMIPS_GCC      = smips-gcc
SMIPS_GCC_OPTS = -O2 -G 0 -nostdlib -nostartfiles

bmarks = $(global_bmarks) $(local_bmarks)

VPATH += $(addprefix $(global_bmarkdir)/, $(global_bmarks)) \
         $(addprefix $(local_bmarkdir)/, $(local_bmarks))

incs  += -I. $(addprefix -I$(global_bmarkdir)/, $(global_bmarks)) \
             $(addprefix -I$(local_bmarkdir)/, $(local_bmarks))
objs  :=

smips_gcc_dir    = $(MIT6375_HOME)/tools/smips-gcc/current
smips_gcc_libdir = $(smips_gcc_dir)/lib
smips_gcc_incdir = $(Smips_gcc_inc)/inc

SMIPS_LINK = smips-ld $(smips_gcc_libdir)/crt1.o \
                      -T$(smips_gcc_libdir)/testraw.ld \
                      -L. -L$(smips_gcc_libdir)

ifneq ($(strip $(global_bmarks)),)
include $(patsubst %, $(global_bmarkdir)/%/bmark.mk, $(global_bmarks))
endif

ifneq ($(strip $(local_bmarks)),)
include $(patsubst %, $(local_bmarkdir)/%/bmark.mk, $(local_bmarks))
endif

#------------------------------------------------------------
# Build the processor simulator

vcs_sim = simv
$(vcs_sim) : $(vsrcs)
	$(VCS) $(VCS_OPTS) +incdir+$(srcdir) -o $(vcs_sim) \
		   +libext+.v -y $(BLUESPECDIR)/Verilog \
	       +incdir+$(vclibdir) $(addprefix -v ,$(vclibsrcs)) $(vsrcs)

sim-rtl : $(vcs_sim)

junk += simv* csrc *.vpd vcs.key

#------------------------------------------------------------
# Build and run assembly tests

asm_tests = $(global_asm_tests) $(local_asm_tests)

global_asm_tests_bin = $(addsuffix .smips.bin, $(patsubst %.S, %, $(global_asm_tests)))
local_asm_tests_bin  = $(addsuffix .smips.bin, $(patsubst %.S, %, $(local_asm_tests)))

asm_tests_vmh  = $(addsuffix .smips.vmh,  $(patsubst %.S, %,$(asm_tests)))
asm_tests_dump = $(addsuffix .smips.dump, $(patsubst %.S, %,$(asm_tests)))
asm_tests_out  = $(addsuffix .smips.out,  $(patsubst %.S, %,$(asm_tests)))

$(global_asm_tests_bin): %.smips.bin : $(global_tstdir)/%.S
	$(SMIPS_TESTBUILD) $< -o $@

$(local_asm_tests_bin): %.smips.bin : $(local_tstdir)/%.S
	$(SMIPS_TESTBUILD) $< -o $@

$(asm_tests_dump) : %.smips.dump : %.smips.bin
	$(SMIPS_OBJDUMP) $< > $@

$(asm_tests_vmh) : %.smips.vmh : %.smips.dump
	$(SMIPS_OBJDUMP_TO_VMH) $< $@

$(asm_tests_out) : %.smips.out : %.smips.vmh $(vcs_sim) 
	./$(vcs_sim) +exe=$< > $@

run-asm-tests : $(asm_tests_out)
	@echo; perl -ne 'print "  [$$1] $$ARGV \t$$2\n" if /\*{3}(.{8})\*{3}(.*)/' \
	       $(asm_tests_out); echo;

junk += $(global_asm_tests_bin) $(local_asm_tests_bin) \
        $(asm_tests_vmh) $(asm_tests_out) $(asm_tests_dump)

#------------------------------------------------------------
# Build and run benchmarks on smips simulator

bmarks_smips_bin  = $(addsuffix .smips.bin,  $(bmarks))
bmarks_smips_dump = $(addsuffix .smips.dump, $(bmarks))
bmarks_smips_vmh  = $(addsuffix .smips.vmh,  $(bmarks))
bmarks_smips_out  = $(addsuffix .smips.out,  $(bmarks))

bmarks_defs   = -DPREALLOCATE=1 -DHOST_DEBUG=0
bmarks_cycles = 800000

%.o : %.c
	$(SMIPS_GCC) $(SMIPS_GCC_OPTS) $(bmarks_defs) \
	             -c -I$(smips_gcc_incdir) $(incs) $< -o $@

%.o : %.S
	$(SMIPS_GCC) $(SMIPS_GCC_OPTS) $(bmarks_defs) \
	             -c -I$(smips_gcc_incdir) $(incs) $< -o $@

$(bmarks_smips_dump) : %.smips.dump : %.smips.bin
	$(SMIPS_OBJDUMP) $< > $@

$(bmarks_smips_vmh) : %.smips.vmh : %.smips.dump
	$(SMIPS_OBJDUMP_TO_VMH) $< $@

$(bmarks_smips_out) : %.smips.out : %.smips.vmh $(vcs_sim) 
	./$(vcs_sim) +max-cycles=$(bmarks_cycles) +exe=$< > $@

run-bmarks-smips : $(bmarks_smips_out)
	echo; perl -ne 'print "  [$$1] $$ARGV \t$$2\n" if /\*{3}(.{8})\*{3}(.*)/' \
	       $(bmarks_smips_out); echo;

junk += $(bmarks_smips_bin) $(bmarks_smips_vmh) \
        $(bmarks_smips_out) $(bmarks_smips_dump)

#------------------------------------------------------------
# Build and run benchmarks on host machine

bmarks_host_bin = $(addsuffix .host.bin, $(bmarks))
bmarks_host_out = $(addsuffix .host.out, $(bmarks))

$(bmarks_host_out) : %.host.out : %.host.bin
	./$< > $@

run-bmarks-host : $(bmarks_host_out)
	echo; perl -ne 'print "  [$$1] $$ARGV \t$$2\n" if /\*{3}(.{8})\*{3}(.*)/' \
	       $(bmarks_host_out); echo;

junk += $(bmarks_host_bin) $(bmarks_host_out)

#--------------------------------------------------------------------
# Default make target
#--------------------------------------------------------------------

all : $(vcs_sim)

#--------------------------------------------------------------------
# Clean up
#--------------------------------------------------------------------

clean :
	rm -rf $(objs) $(junk) *~ \#* *.log *.cmd *.daidir
