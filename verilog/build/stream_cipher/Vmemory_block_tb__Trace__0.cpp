// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vmemory_block_tb__Syms.h"


void Vmemory_block_tb___024root__trace_chg_0_sub_0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vmemory_block_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_chg_0\n"); );
    // Init
    Vmemory_block_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vmemory_block_tb___024root*>(voidSelf);
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vmemory_block_tb___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vmemory_block_tb___024root__trace_chg_0_sub_0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_chg_0_sub_0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[1U] 
                      | vlSelfRef.__Vm_traceActivity
                      [2U])))) {
        bufp->chgBit(oldp+0,(vlSelfRef.memory_block_tb__DOT__tb_nrst));
        bufp->chgCData(oldp+1,(vlSelfRef.memory_block_tb__DOT__tb_store_byte_in),8);
        bufp->chgBit(oldp+2,(vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in));
        bufp->chgCData(oldp+3,(vlSelfRef.memory_block_tb__DOT__tb_set_address_in),4);
        bufp->chgBit(oldp+4,(vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in));
        bufp->chgIData(oldp+5,(vlSelfRef.memory_block_tb__DOT__tb_test_num),32);
        bufp->chgIData(oldp+6,(vlSelfRef.memory_block_tb__DOT__tb_passed),32);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[3U]))) {
        bufp->chgWData(oldp+7,(vlSelfRef.memory_block_tb__DOT__dut__DOT__memory),128);
        bufp->chgCData(oldp+11,((0xffU & (((0U == (0x1fU 
                                                   & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                            ? 0U : 
                                           (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                            (((IData)(7U) 
                                              + (0x7fU 
                                                 & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                             >> 5U)] 
                                            << ((IData)(0x20U) 
                                                - (0x1fU 
                                                   & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                                          | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                             (3U & 
                                              (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                               >> 5U))] 
                                             >> (0x1fU 
                                                 & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))))),8);
        bufp->chgCData(oldp+12,(vlSelfRef.memory_block_tb__DOT__dut__DOT__address),4);
    }
    bufp->chgBit(oldp+13,(vlSelfRef.memory_block_tb__DOT__tb_clk));
    bufp->chgCData(oldp+14,(vlSelfRef.memory_block_tb__DOT__dut__DOT__next_address),4);
}

void Vmemory_block_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_cleanup\n"); );
    // Init
    Vmemory_block_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vmemory_block_tb___024root*>(voidSelf);
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
}
