// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmemory_block_tb.h for the primary calling header

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb___024root.h"

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_static(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_static\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_clk__0 
        = vlSelfRef.memory_block_tb__DOT__tb_clk;
    vlSelfRef.__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_nrst__0 
        = vlSelfRef.memory_block_tb__DOT__tb_nrst;
}

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_final(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_final\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__stl(Vmemory_block_tb___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vmemory_block_tb___024root___eval_phase__stl(Vmemory_block_tb___024root* vlSelf);

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_settle(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_settle\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY(((0x64U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vmemory_block_tb___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("verilog/dv/stream_cipher/memory_block_tb.sv", 9, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vmemory_block_tb___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelfRef.__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__stl(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___dump_triggers__stl\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VstlTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

void Vmemory_block_tb___024root___act_comb__TOP__0(Vmemory_block_tb___024root* vlSelf);

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_stl(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_stl\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        Vmemory_block_tb___024root___act_comb__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_triggers__stl(Vmemory_block_tb___024root* vlSelf);

VL_ATTR_COLD bool Vmemory_block_tb___024root___eval_phase__stl(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_phase__stl\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vmemory_block_tb___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelfRef.__VstlTriggered.any();
    if (__VstlExecute) {
        Vmemory_block_tb___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__act(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___dump_triggers__act\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge memory_block_tb.tb_clk)\n");
    }
    if ((2ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(negedge memory_block_tb.tb_nrst)\n");
    }
    if ((4ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @(negedge memory_block_tb.tb_clk)\n");
    }
    if ((8ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 3 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__nba(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___dump_triggers__nba\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge memory_block_tb.tb_clk)\n");
    }
    if ((2ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(negedge memory_block_tb.tb_nrst)\n");
    }
    if ((4ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @(negedge memory_block_tb.tb_clk)\n");
    }
    if ((8ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 3 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vmemory_block_tb___024root___ctor_var_reset(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___ctor_var_reset\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->memory_block_tb__DOT__tb_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13160614806072887991ull);
    vlSelf->memory_block_tb__DOT__tb_nrst = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4172112268610403766ull);
    vlSelf->memory_block_tb__DOT__tb_store_byte_in = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15788318921963642241ull);
    vlSelf->memory_block_tb__DOT__tb_store_byte_pulse_in = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4481645829081454109ull);
    vlSelf->memory_block_tb__DOT__tb_set_address_in = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 10441192144755824452ull);
    vlSelf->memory_block_tb__DOT__tb_set_address_pulse_in = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8515148344396107441ull);
    vlSelf->memory_block_tb__DOT__tb_test_num = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16242530406878914063ull);
    vlSelf->memory_block_tb__DOT__tb_passed = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 12444602368489448478ull);
    VL_SCOPED_RAND_RESET_W(128, vlSelf->memory_block_tb__DOT__dut__DOT__memory, __VscopeHash, 10305918622815273688ull);
    vlSelf->memory_block_tb__DOT__dut__DOT__address = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 14086350245463037070ull);
    vlSelf->memory_block_tb__DOT__dut__DOT__next_address = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 4035446464918690030ull);
    vlSelf->__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5555439870816127038ull);
    vlSelf->__Vtrigprevexpr___TOP__memory_block_tb__DOT__tb_nrst__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5721381782829094503ull);
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
