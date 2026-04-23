// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vmemory_block_tb.h for the primary calling header

#ifndef VERILATED_VMEMORY_BLOCK_TB___024ROOT_H_
#define VERILATED_VMEMORY_BLOCK_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"
class Vmemory_block_tb_memory_block_if__M10;


class Vmemory_block_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vmemory_block_tb___024root final : public VerilatedModule {
  public:
    // CELLS
    Vmemory_block_tb_memory_block_if__M10* __PVT__memory_block_tb__DOT__dut_bus;

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ memory_block_tb__DOT__tb_clk;
    CData/*0:0*/ memory_block_tb__DOT__tb_nrst;
    CData/*7:0*/ memory_block_tb__DOT__tb_store_byte_in;
    CData/*0:0*/ memory_block_tb__DOT__tb_store_byte_pulse_in;
    CData/*3:0*/ memory_block_tb__DOT__tb_set_address_in;
    CData/*0:0*/ memory_block_tb__DOT__tb_set_address_pulse_in;
    CData/*3:0*/ memory_block_tb__DOT__dut__DOT__address;
    CData/*3:0*/ memory_block_tb__DOT__dut__DOT__next_address;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_nrst__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ memory_block_tb__DOT__tb_test_num;
    IData/*31:0*/ memory_block_tb__DOT__tb_passed;
    VlWide<4>/*127:0*/ memory_block_tb__DOT__dut__DOT__memory;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*0:0*/, 4> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hbf07b2ee__0;
    VlTriggerScheduler __VtrigSched_hbf07b2af__0;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<4> __VactTriggered;
    VlTriggerVec<4> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vmemory_block_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vmemory_block_tb___024root(Vmemory_block_tb__Syms* symsp, const char* v__name);
    ~Vmemory_block_tb___024root();
    VL_UNCOPYABLE(Vmemory_block_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
