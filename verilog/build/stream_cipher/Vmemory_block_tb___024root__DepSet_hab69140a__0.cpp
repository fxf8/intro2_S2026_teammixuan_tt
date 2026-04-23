// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmemory_block_tb.h for the primary calling header

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb__Syms.h"
#include "Vmemory_block_tb___024root.h"

VL_INLINE_OPT VlCoroutine Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__1(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(0x1f4ULL, 
                                             nullptr, 
                                             "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                             242);
        vlSelfRef.memory_block_tb__DOT__tb_clk = (1U 
                                                  & (~ (IData)(vlSelfRef.memory_block_tb__DOT__tb_clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__act(Vmemory_block_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vmemory_block_tb___024root___eval_triggers__act(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_triggers__act\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.setBit(0U, ((IData)(vlSelfRef.memory_block_tb__DOT__tb_clk) 
                                          & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_clk__0))));
    vlSelfRef.__VactTriggered.setBit(1U, ((~ (IData)(vlSelfRef.memory_block_tb__DOT__tb_nrst)) 
                                          & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_nrst__0)));
    vlSelfRef.__VactTriggered.setBit(2U, ((~ (IData)(vlSelfRef.memory_block_tb__DOT__tb_clk)) 
                                          & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_clk__0)));
    vlSelfRef.__VactTriggered.setBit(3U, vlSelfRef.__VdlySched.awaitingCurrentTime());
    vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_clk__0 
        = vlSelfRef.memory_block_tb__DOT__tb_clk;
    vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_nrst__0 
        = vlSelfRef.memory_block_tb__DOT__tb_nrst;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vmemory_block_tb___024root___dump_triggers__act(vlSelf);
    }
#endif
}

VL_INLINE_OPT void Vmemory_block_tb___024root___nba_sequent__TOP__0(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___nba_sequent__TOP__0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.memory_block_tb__DOT__tb_nrst) {
        if (vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in) {
            VL_ASSIGNSEL_WI(128, 8, (0x7fU & VL_SHIFTL_III(7,32,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)), vlSelfRef.memory_block_tb__DOT__dut__DOT__memory, vlSelfRef.memory_block_tb__DOT__tb_store_byte_in);
        }
        if (vlSymsp->TOP__memory_block_tb__DOT__dut_bus.reset_memory_pulse_in) {
            vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[0U] = 0U;
            vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[1U] = 0U;
            vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[2U] = 0U;
            vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[3U] = 0U;
        }
        vlSelfRef.memory_block_tb__DOT__dut__DOT__address 
            = vlSelfRef.memory_block_tb__DOT__dut__DOT__next_address;
    } else {
        vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[0U] = 0U;
        vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[1U] = 0U;
        vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[2U] = 0U;
        vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[3U] = 0U;
        vlSelfRef.memory_block_tb__DOT__dut__DOT__address = 0U;
    }
}
