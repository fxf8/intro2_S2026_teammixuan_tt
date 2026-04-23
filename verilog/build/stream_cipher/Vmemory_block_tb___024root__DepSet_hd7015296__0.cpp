// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmemory_block_tb.h for the primary calling header

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb___024root.h"

VL_ATTR_COLD void Vmemory_block_tb___024root___eval_initial__TOP(Vmemory_block_tb___024root* vlSelf);
VlCoroutine Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__0(Vmemory_block_tb___024root* vlSelf);
VlCoroutine Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__1(Vmemory_block_tb___024root* vlSelf);

void Vmemory_block_tb___024root___eval_initial(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_initial\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vmemory_block_tb___024root___eval_initial__TOP(vlSelf);
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VL_INLINE_OPT VlCoroutine Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__0(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    std::string memory_block_tb__DOT__tb_test_case;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__4__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__4__byte_val = 0;
    CData/*3:0*/ __Vtask_memory_block_tb__DOT__set_address_task__5__addr;
    __Vtask_memory_block_tb__DOT__set_address_task__5__addr = 0;
    VlWide<4>/*127:0*/ __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory;
    VL_ZERO_W(128, __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory);
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__9__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__9__byte_val = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__10__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__10__byte_val = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__11__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__11__byte_val = 0;
    VlWide<4>/*127:0*/ __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory;
    VL_ZERO_W(128, __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory);
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__15__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__15__byte_val = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__16__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__16__byte_val = 0;
    CData/*3:0*/ __Vtask_memory_block_tb__DOT__set_address_task__17__addr;
    __Vtask_memory_block_tb__DOT__set_address_task__17__addr = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__18__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__18__byte_val = 0;
    VlWide<4>/*127:0*/ __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory;
    VL_ZERO_W(128, __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory);
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__22__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__22__byte_val = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__23__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__23__byte_val = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__24__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__24__byte_val = 0;
    CData/*3:0*/ __Vtask_memory_block_tb__DOT__set_address_task__25__addr;
    __Vtask_memory_block_tb__DOT__set_address_task__25__addr = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__check_memory_at_address__26__expected_byte;
    __Vtask_memory_block_tb__DOT__check_memory_at_address__26__expected_byte = 0;
    CData/*3:0*/ __Vtask_memory_block_tb__DOT__set_address_task__27__addr;
    __Vtask_memory_block_tb__DOT__set_address_task__27__addr = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__check_memory_at_address__28__expected_byte;
    __Vtask_memory_block_tb__DOT__check_memory_at_address__28__expected_byte = 0;
    IData/*31:0*/ __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__store_byte_task__32__byte_val;
    __Vtask_memory_block_tb__DOT__store_byte_task__32__byte_val = 0;
    CData/*3:0*/ __Vtask_memory_block_tb__DOT__set_address_task__33__addr;
    __Vtask_memory_block_tb__DOT__set_address_task__33__addr = 0;
    CData/*7:0*/ __Vtask_memory_block_tb__DOT__check_memory_at_address__34__expected_byte;
    __Vtask_memory_block_tb__DOT__check_memory_at_address__34__expected_byte = 0;
    // Body
    vlSelfRef.memory_block_tb__DOT__tb_clk = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_in = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_passed = 0U;
    memory_block_tb__DOT__tb_test_case = std::string{"Power on Reset"};
    vlSelfRef.memory_block_tb__DOT__tb_test_num = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         45);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         46);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         50);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         51);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         110);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    if (((0U == (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address)) 
         & (0U == (((vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[0U] 
                     | vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[1U]) 
                    | vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[2U]) 
                   | vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[3U])))) {
        VL_WRITEF_NX("  [PASS] %@: Initial address and memory are zero.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Initial address or memory not zero. Address: %x, Memory: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     4,(IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address),
                     128,vlSelfRef.memory_block_tb__DOT__dut__DOT__memory.data());
    }
    memory_block_tb__DOT__tb_test_case = std::string{"Store Single Byte"};
    vlSelfRef.memory_block_tb__DOT__tb_test_num = ((IData)(1U) 
                                                   + vlSelfRef.memory_block_tb__DOT__tb_test_num);
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         45);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         46);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         50);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         51);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__4__byte_val = 0xaaU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__4__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__set_address_task__5__addr = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_in 
        = __Vtask_memory_block_tb__DOT__set_address_task__5__addr;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         60);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         62);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         130);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    if (((0U == (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address)) 
         & (0xaaU == (0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                 ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                         (((IData)(7U) 
                                           + (0x7fU 
                                              & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                          >> 5U)] << 
                                         ((IData)(0x20U) 
                                          - (0x1fU 
                                             & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                               | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                  (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                         >> 5U))] >> 
                                  (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))))))) {
        VL_WRITEF_NX("  [PASS] %@: Stored byte and address incremented.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Failed to store byte or increment address. Address: %x, Byte: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     4,(IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address),
                     8,(0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                   ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                           (((IData)(7U) 
                                             + (0x7fU 
                                                & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                            >> 5U)] 
                                           << ((IData)(0x20U) 
                                               - (0x1fU 
                                                  & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                    (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                           >> 5U))] 
                                    >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))));
    }
    __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[0U] = 0xaaU;
    __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[1U] = 0U;
    __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[2U] = 0U;
    __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[3U] = 0U;
    if ((0U == ((((vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[0U] 
                   ^ __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[0U]) 
                  | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[1U] 
                     ^ __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[1U])) 
                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[2U] 
                    ^ __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[2U])) 
                | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[3U] 
                   ^ __Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory[3U])))) {
        VL_WRITEF_NX("  [PASS] %@: Memory content matches expected.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Memory content mismatch. Expected: %x, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     128,__Vtask_memory_block_tb__DOT__check_memory_content__6__expected_memory.data(),
                     128,vlSelfRef.memory_block_tb__DOT__dut__DOT__memory.data());
    }
    memory_block_tb__DOT__tb_test_case = std::string{"Store Multiple Bytes (Auto-Increment)"};
    vlSelfRef.memory_block_tb__DOT__tb_test_num = ((IData)(1U) 
                                                   + vlSelfRef.memory_block_tb__DOT__tb_test_num);
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         45);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         46);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         50);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         51);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__9__byte_val = 0x11U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__9__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__10__byte_val = 0x22U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__10__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__11__byte_val = 0x33U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__11__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         151);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    if ((3U == (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address))) {
        VL_WRITEF_NX("  [PASS] %@: Address auto-incremented correctly.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Address auto-increment failed. Expected: 3, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     4,(IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address));
    }
    __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[0U] = 0x332211U;
    __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[1U] = 0U;
    __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[2U] = 0U;
    __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[3U] = 0U;
    if ((0U == ((((vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[0U] 
                   ^ __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[0U]) 
                  | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[1U] 
                     ^ __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[1U])) 
                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[2U] 
                    ^ __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[2U])) 
                | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[3U] 
                   ^ __Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory[3U])))) {
        VL_WRITEF_NX("  [PASS] %@: Memory content matches expected.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Memory content mismatch. Expected: %x, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     128,__Vtask_memory_block_tb__DOT__check_memory_content__12__expected_memory.data(),
                     128,vlSelfRef.memory_block_tb__DOT__dut__DOT__memory.data());
    }
    memory_block_tb__DOT__tb_test_case = std::string{"Set Address and Store"};
    vlSelfRef.memory_block_tb__DOT__tb_test_num = ((IData)(1U) 
                                                   + vlSelfRef.memory_block_tb__DOT__tb_test_num);
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         45);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         46);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         50);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         51);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__15__byte_val = 0x11U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__15__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__16__byte_val = 0x22U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__16__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__set_address_task__17__addr = 5U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_in 
        = __Vtask_memory_block_tb__DOT__set_address_task__17__addr;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         60);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         62);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__18__byte_val = 0xffU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__18__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         173);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    if ((6U == (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address))) {
        VL_WRITEF_NX("  [PASS] %@: Address set and byte stored correctly.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Address set and store failed. Expected address: 6, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     4,(IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address));
    }
    __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[0U] = 0x2211U;
    __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[1U] = 0xff00U;
    __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[2U] = 0U;
    __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[3U] = 0U;
    if ((0U == ((((vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[0U] 
                   ^ __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[0U]) 
                  | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[1U] 
                     ^ __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[1U])) 
                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[2U] 
                    ^ __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[2U])) 
                | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[3U] 
                   ^ __Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory[3U])))) {
        VL_WRITEF_NX("  [PASS] %@: Memory content matches expected.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Memory content mismatch. Expected: %x, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     128,__Vtask_memory_block_tb__DOT__check_memory_content__19__expected_memory.data(),
                     128,vlSelfRef.memory_block_tb__DOT__dut__DOT__memory.data());
    }
    memory_block_tb__DOT__tb_test_case = std::string{"Read at Address"};
    vlSelfRef.memory_block_tb__DOT__tb_test_num = ((IData)(1U) 
                                                   + vlSelfRef.memory_block_tb__DOT__tb_test_num);
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         45);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         46);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         50);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         51);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__22__byte_val = 0x11U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__22__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__23__byte_val = 0x22U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__23__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__24__byte_val = 0x33U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__24__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__set_address_task__25__addr = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_in 
        = __Vtask_memory_block_tb__DOT__set_address_task__25__addr;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         60);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         62);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         197);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__check_memory_at_address__26__expected_byte = 0x22U;
    if (((0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                     ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                             (((IData)(7U) + (0x7fU 
                                              & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                              >> 5U)] << ((IData)(0x20U) 
                                          - (0x1fU 
                                             & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                   | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                      (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                             >> 5U))] >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
         == (IData)(__Vtask_memory_block_tb__DOT__check_memory_at_address__26__expected_byte))) {
        VL_WRITEF_NX("  [PASS] %@: Byte at current address matches expected.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Byte at current address mismatch. Expected: %x, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     8,(IData)(__Vtask_memory_block_tb__DOT__check_memory_at_address__26__expected_byte),
                     8,(0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                   ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                           (((IData)(7U) 
                                             + (0x7fU 
                                                & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                            >> 5U)] 
                                           << ((IData)(0x20U) 
                                               - (0x1fU 
                                                  & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                    (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                           >> 5U))] 
                                    >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))));
    }
    __Vtask_memory_block_tb__DOT__set_address_task__27__addr = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_in 
        = __Vtask_memory_block_tb__DOT__set_address_task__27__addr;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         60);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         62);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         200);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__check_memory_at_address__28__expected_byte = 0x11U;
    if (((0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                     ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                             (((IData)(7U) + (0x7fU 
                                              & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                              >> 5U)] << ((IData)(0x20U) 
                                          - (0x1fU 
                                             & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                   | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                      (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                             >> 5U))] >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
         == (IData)(__Vtask_memory_block_tb__DOT__check_memory_at_address__28__expected_byte))) {
        VL_WRITEF_NX("  [PASS] %@: Byte at current address matches expected.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Byte at current address mismatch. Expected: %x, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     8,(IData)(__Vtask_memory_block_tb__DOT__check_memory_at_address__28__expected_byte),
                     8,(0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                   ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                           (((IData)(7U) 
                                             + (0x7fU 
                                                & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                            >> 5U)] 
                                           << ((IData)(0x20U) 
                                               - (0x1fU 
                                                  & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                    (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                           >> 5U))] 
                                    >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))));
    }
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0;
    memory_block_tb__DOT__tb_test_case = std::string{"Memory Rollover"};
    vlSelfRef.memory_block_tb__DOT__tb_test_num = ((IData)(1U) 
                                                   + vlSelfRef.memory_block_tb__DOT__tb_test_num);
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         45);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2ee__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(posedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         46);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_nrst = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         50);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         51);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 1U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 2U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 2U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 3U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 3U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 4U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 4U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 5U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 5U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 6U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 6U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 7U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 7U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 8U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 8U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 9U;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 9U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0xaU;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0xaU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0xbU;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0xbU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0xcU;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0xcU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0xdU;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0xdU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0xeU;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0xeU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0xfU;
    __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val = 0xfU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__31__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__test_memory_rollover__29__unnamedblk1__DOT__i = 0x10U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         215);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    if ((0U == (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address))) {
        VL_WRITEF_NX("  [PASS] %@: Address rolled over to 0.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Address rollover failed. Expected: 0, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     4,(IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address));
    }
    __Vtask_memory_block_tb__DOT__store_byte_task__32__byte_val = 0xffU;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_in 
        = __Vtask_memory_block_tb__DOT__store_byte_task__32__byte_val;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         73);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         225);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    if ((1U == (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address))) {
        VL_WRITEF_NX("  [PASS] %@: Stored byte at rolled over address 0.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Failed to store byte at rolled over address 0. Address: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     4,(IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address));
    }
    __Vtask_memory_block_tb__DOT__set_address_task__33__addr = 0U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_in 
        = __Vtask_memory_block_tb__DOT__set_address_task__33__addr;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         60);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in = 0U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         62);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    co_await vlSelfRef.__VtrigSched_hbf07b2af__0.trigger(0U, 
                                                         nullptr, 
                                                         "@(negedge memory_block_tb.tb_clk)", 
                                                         "verilog/dv/stream_cipher/memory_block_tb.sv", 
                                                         234);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    __Vtask_memory_block_tb__DOT__check_memory_at_address__34__expected_byte = 0xffU;
    if (((0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                     ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                             (((IData)(7U) + (0x7fU 
                                              & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                              >> 5U)] << ((IData)(0x20U) 
                                          - (0x1fU 
                                             & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                   | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                      (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                             >> 5U))] >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
         == (IData)(__Vtask_memory_block_tb__DOT__check_memory_at_address__34__expected_byte))) {
        VL_WRITEF_NX("  [PASS] %@: Byte at current address matches expected.\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case));
        vlSelfRef.memory_block_tb__DOT__tb_passed = 
            ((IData)(1U) + vlSelfRef.memory_block_tb__DOT__tb_passed);
    } else {
        VL_WRITEF_NX("  [FAIL] %@: Byte at current address mismatch. Expected: %x, Got: %x\n",0,
                     -1,&(memory_block_tb__DOT__tb_test_case),
                     8,(IData)(__Vtask_memory_block_tb__DOT__check_memory_at_address__34__expected_byte),
                     8,(0xffU & (((0U == (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                   ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                           (((IData)(7U) 
                                             + (0x7fU 
                                                & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                            >> 5U)] 
                                           << ((IData)(0x20U) 
                                               - (0x1fU 
                                                  & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                                 | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                    (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                           >> 5U))] 
                                    >> (0x1fU & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))));
    }
    VL_WRITEF_NX("\nTotal Test Cases: %1d, Total Checks Passed: %1d\n\n",0,
                 32,vlSelfRef.memory_block_tb__DOT__tb_test_num,
                 32,vlSelfRef.memory_block_tb__DOT__tb_passed);
    VL_FINISH_MT("verilog/dv/stream_cipher/memory_block_tb.sv", 306, "");
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
}

void Vmemory_block_tb___024root___act_comb__TOP__0(Vmemory_block_tb___024root* vlSelf);

void Vmemory_block_tb___024root___eval_act(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_act\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((5ULL & vlSelfRef.__VactTriggered.word(0U))) {
        Vmemory_block_tb___024root___act_comb__TOP__0(vlSelf);
    }
}

VL_INLINE_OPT void Vmemory_block_tb___024root___act_comb__TOP__0(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___act_comb__TOP__0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.memory_block_tb__DOT__dut__DOT__next_address 
        = vlSelfRef.memory_block_tb__DOT__dut__DOT__address;
    if (vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in) {
        vlSelfRef.memory_block_tb__DOT__dut__DOT__next_address 
            = vlSelfRef.memory_block_tb__DOT__tb_set_address_in;
    } else if (vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in) {
        vlSelfRef.memory_block_tb__DOT__dut__DOT__next_address 
            = (0xfU & ((IData)(1U) + (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address)));
    }
}

void Vmemory_block_tb___024root___nba_sequent__TOP__0(Vmemory_block_tb___024root* vlSelf);

void Vmemory_block_tb___024root___eval_nba(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_nba\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vmemory_block_tb___024root___nba_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[3U] = 1U;
    }
    if ((7ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vmemory_block_tb___024root___act_comb__TOP__0(vlSelf);
    }
}

void Vmemory_block_tb___024root___timing_resume(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___timing_resume\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VtrigSched_hbf07b2ee__0.resume(
                                                   "@(posedge memory_block_tb.tb_clk)");
    }
    if ((4ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VtrigSched_hbf07b2af__0.resume(
                                                   "@(negedge memory_block_tb.tb_clk)");
    }
    if ((8ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vmemory_block_tb___024root___timing_commit(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___timing_commit\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((! (1ULL & vlSelfRef.__VactTriggered.word(0U)))) {
        vlSelfRef.__VtrigSched_hbf07b2ee__0.commit(
                                                   "@(posedge memory_block_tb.tb_clk)");
    }
    if ((! (4ULL & vlSelfRef.__VactTriggered.word(0U)))) {
        vlSelfRef.__VtrigSched_hbf07b2af__0.commit(
                                                   "@(negedge memory_block_tb.tb_clk)");
    }
}

void Vmemory_block_tb___024root___eval_triggers__act(Vmemory_block_tb___024root* vlSelf);

bool Vmemory_block_tb___024root___eval_phase__act(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_phase__act\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<4> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vmemory_block_tb___024root___eval_triggers__act(vlSelf);
    Vmemory_block_tb___024root___timing_commit(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vmemory_block_tb___024root___timing_resume(vlSelf);
        Vmemory_block_tb___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vmemory_block_tb___024root___eval_phase__nba(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_phase__nba\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vmemory_block_tb___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__nba(Vmemory_block_tb___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vmemory_block_tb___024root___dump_triggers__act(Vmemory_block_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vmemory_block_tb___024root___eval(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY(((0x64U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vmemory_block_tb___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("verilog/dv/stream_cipher/memory_block_tb.sv", 9, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY(((0x64U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vmemory_block_tb___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("verilog/dv/stream_cipher/memory_block_tb.sv", 9, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vmemory_block_tb___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vmemory_block_tb___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vmemory_block_tb___024root___eval_debug_assertions(Vmemory_block_tb___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root___eval_debug_assertions\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
