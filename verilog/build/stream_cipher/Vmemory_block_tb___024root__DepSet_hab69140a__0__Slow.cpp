// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmemory_block_tb.h for the primary calling header

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb__Syms.h"
#include "Vmemory_block_tb___024root.h"

extern const VlWide<11>/*351:0*/ Vmemory_block_tb__ConstPool__CONST_h9251a11e_0;

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_initial__TOP(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_initial__TOP\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(11, Vmemory_block_tb__ConstPool__CONST_h9251a11e_0));
    vlSymsp->_traceDumpOpen();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__stl(Vmemory_block_tb___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_triggers__stl(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_triggers__stl\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered.setBit(0U, (IData)(vlSelfRef.__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vmemory_block_tb___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
