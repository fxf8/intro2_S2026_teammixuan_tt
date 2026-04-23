// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vmemory_block_tb.h for the primary calling header

#ifndef VERILATED_VMEMORY_BLOCK_TB_MEMORY_BLOCK_IF__M10_H_
#define VERILATED_VMEMORY_BLOCK_TB_MEMORY_BLOCK_IF__M10_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vmemory_block_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vmemory_block_tb_memory_block_if__M10 final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ reset_memory_pulse_in;
    CData/*0:0*/ __PVT__read_address_pulse;
    CData/*0:0*/ __PVT__read_byte_at_address_pulse;

    // INTERNAL VARIABLES
    Vmemory_block_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vmemory_block_tb_memory_block_if__M10(Vmemory_block_tb__Syms* symsp, const char* v__name);
    ~Vmemory_block_tb_memory_block_if__M10();
    VL_UNCOPYABLE(Vmemory_block_tb_memory_block_if__M10);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};

std::string VL_TO_STRING(const Vmemory_block_tb_memory_block_if__M10* obj);

#endif  // guard
