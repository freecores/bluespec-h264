#=========================================================================
# Constraints file
#-------------------------------------------------------------------------
# $Id: par.sdc,v 1.1 2008-06-26 17:58:43 jamey.hicks Exp $
#
# This file contains various constraints for your chip including the
# target clock period, the capacitive load of output pins, and any
# input/output delay constraints.
#

# This constraint sets the target clock period for the chip in
# nanoseconds. Note that the first parameter is the name of the clock 
# signal in your verlog design. If you called it something different than 
# clk you will need to change this. You should set this constraint 
# carefully. If the period is unrealistically small then the tools will
# spend forever trying to meet timing and ultimately fail. If the period
# is too large the tools will have no trouble but you will get a very
# conservative implementation. 

create_clock CLK -name ideal_clock1 -period 8.0

# This constrainst sets the load capacitance in picofarads of the
# output pins of your design. 4fF is reasonable if your design is
# driving another block of on-chip logic.

set_load -pin_load 0.004 [all_outputs]

# Encounter doesn't seem to have its own way to specify dont_touch
# so we must do it in the SDC file


