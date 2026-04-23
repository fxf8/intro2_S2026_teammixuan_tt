# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Make include file with class lists
#
# This file lists generated Verilated files, for including in higher level makefiles.
# See Vmemory_block_tb.mk for the caller.

### Switches...
# C11 constructs required?  0/1 (always on now)
VM_C11 = 1
# Timing enabled?  0/1
VM_TIMING = 1
# Coverage output mode?  0/1 (from --coverage)
VM_COVERAGE = 0
# Parallel builds?  0/1 (from --output-split)
VM_PARALLEL_BUILDS = 0
# Tracing output mode?  0/1 (from --trace-fst/--trace-saif/--trace-vcd)
VM_TRACE = 1
# Tracing output mode in FST format?  0/1 (from --trace-fst)
VM_TRACE_FST = 0
# Tracing output mode in SAIF format?  0/1 (from --trace-saif)
VM_TRACE_SAIF = 0
# Tracing output mode in VCD format?  0/1 (from --trace-vcd)
VM_TRACE_VCD = 1

### Object file lists...
# Generated module classes, fast-path, compile with highest optimization
VM_CLASSES_FAST += \
  Vmemory_block_tb \
  Vmemory_block_tb___024root__DepSet_hab69140a__0 \
  Vmemory_block_tb___024root__DepSet_hd7015296__0 \
  Vmemory_block_tb_memory_block_if__M10__DepSet_ha8ed1591__0 \
  Vmemory_block_tb__main \

# Generated module classes, non-fast-path, compile with low/medium optimization
VM_CLASSES_SLOW += \
  Vmemory_block_tb__ConstPool_0 \
  Vmemory_block_tb___024root__Slow \
  Vmemory_block_tb___024root__DepSet_hab69140a__0__Slow \
  Vmemory_block_tb___024root__DepSet_hd7015296__0__Slow \
  Vmemory_block_tb_memory_block_if__M10__Slow \
  Vmemory_block_tb_memory_block_if__M10__DepSet_ha8ed1591__0__Slow \

# Generated support classes, fast-path, compile with highest optimization
VM_SUPPORT_FAST += \
  Vmemory_block_tb__Trace__0 \

# Generated support classes, non-fast-path, compile with low/medium optimization
VM_SUPPORT_SLOW += \
  Vmemory_block_tb__Syms \
  Vmemory_block_tb__Trace__0__Slow \
  Vmemory_block_tb__TraceDecls__0__Slow \

# Global classes, need linked once per executable, fast-path, compile with highest optimization
VM_GLOBAL_FAST += \
  verilated \
  verilated_vcd_c \
  verilated_timing \
  verilated_threads \

# Global classes, need linked once per executable, non-fast-path, compile with low/medium optimization
VM_GLOBAL_SLOW += \

# Verilated -*- Makefile -*-
