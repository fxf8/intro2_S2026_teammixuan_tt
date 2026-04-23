// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vmemory_block_tb__Syms.h"


VL_ATTR_COLD void Vmemory_block_tb___024root__trace_init_sub__TOP__memory_block_tb__DOT__dut_bus__0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_init_sub__TOP__0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_init_sub__TOP__0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushPrefix("memory_block_tb", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+16,0,"CLK_PERIOD",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+17,0,"MEMORY_WIDTH_BYTES",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBit(c+18,0,"AUTO_INCREMENT_ADDRESS",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+19,0,"AddressWidth",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBit(c+14,0,"tb_clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"tb_nrst",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+2,0,"tb_store_byte_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"tb_store_byte_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+4,0,"tb_set_address_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+5,0,"tb_set_address_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declArray(c+8,0,"tb_memory_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 127,0);
    tracep->declBus(c+12,0,"tb_memory_at_address_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"tb_received_byte_pulse_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+5,0,"tb_received_address_pulse_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+13,0,"tb_address_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+6,0,"tb_test_num",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INTEGER, false,-1, 31,0);
    tracep->declBus(c+7,0,"tb_passed",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INTEGER, false,-1, 31,0);
    tracep->pushPrefix("dut_bus", VerilatedTracePrefixType::SCOPE_INTERFACE);
    Vmemory_block_tb___024root__trace_init_sub__TOP__memory_block_tb__DOT__dut_bus__0(vlSelf, tracep);
    tracep->popPrefix();
    tracep->pushPrefix("dut", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+17,0,"MEMORY_WIDTH_BYTES",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBit(c+18,0,"AUTO_INCREMENT_ADDRESS",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+19,0,"AddressWidth",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBit(c+18,0,"MemoryWidthIsPowerOfTwo",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+14,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"nrst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("memory_block_port", VerilatedTracePrefixType::SCOPE_INTERFACE);
    Vmemory_block_tb___024root__trace_init_sub__TOP__memory_block_tb__DOT__dut_bus__0(vlSelf, tracep);
    tracep->popPrefix();
    tracep->declBus(c+2,0,"store_byte_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"store_byte_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+4,0,"set_address_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+5,0,"set_address_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+20,0,"reset_memory_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declArray(c+8,0,"memory_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 127,0);
    tracep->declBus(c+12,0,"memory_at_address_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"received_byte_pulse_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+5,0,"received_address_pulse_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+13,0,"address_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declArray(c+8,0,"memory",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 127,0);
    tracep->declBus(c+13,0,"address",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+15,0,"next_address",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_init_sub__TOP__memory_block_tb__DOT__dut_bus__0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_init_sub__TOP__memory_block_tb__DOT__dut_bus__0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+17,0,"MEMORY_WIDTH_BYTES",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+19,0,"AddressWidth",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+2,0,"store_byte_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"store_byte_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+4,0,"set_address_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+5,0,"set_address_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+20,0,"reset_memory_pulse_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declArray(c+8,0,"memory_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 127,0);
    tracep->declBus(c+12,0,"memory_at_address_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"received_byte_pulse_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+5,0,"received_address_pulse_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+13,0,"address_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+21,0,"read_address_pulse",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+22,0,"read_byte_at_address_pulse",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_init_top(Vmemory_block_tb___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_init_top\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vmemory_block_tb___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vmemory_block_tb___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vmemory_block_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vmemory_block_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_register(Vmemory_block_tb___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_register\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vmemory_block_tb___024root__trace_const_0, 0U, vlSelf);
    tracep->addFullCb(&Vmemory_block_tb___024root__trace_full_0, 0U, vlSelf);
    tracep->addChgCb(&Vmemory_block_tb___024root__trace_chg_0, 0U, vlSelf);
    tracep->addCleanupCb(&Vmemory_block_tb___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_const_0_sub_0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_const_0\n"); );
    // Init
    Vmemory_block_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vmemory_block_tb___024root*>(voidSelf);
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vmemory_block_tb___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_const_0_sub_0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_const_0_sub_0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+16,(0xaU),32);
    bufp->fullIData(oldp+17,(0x10U),32);
    bufp->fullBit(oldp+18,(1U));
    bufp->fullIData(oldp+19,(4U),32);
    bufp->fullBit(oldp+20,(vlSymsp->TOP__memory_block_tb__DOT__dut_bus.reset_memory_pulse_in));
    bufp->fullBit(oldp+21,(vlSymsp->TOP__memory_block_tb__DOT__dut_bus.__PVT__read_address_pulse));
    bufp->fullBit(oldp+22,(vlSymsp->TOP__memory_block_tb__DOT__dut_bus.__PVT__read_byte_at_address_pulse));
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_full_0_sub_0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_full_0\n"); );
    // Init
    Vmemory_block_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vmemory_block_tb___024root*>(voidSelf);
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vmemory_block_tb___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vmemory_block_tb___024root__trace_full_0_sub_0(Vmemory_block_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmemory_block_tb___024root__trace_full_0_sub_0\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+1,(vlSelfRef.memory_block_tb__DOT__tb_nrst));
    bufp->fullCData(oldp+2,(vlSelfRef.memory_block_tb__DOT__tb_store_byte_in),8);
    bufp->fullBit(oldp+3,(vlSelfRef.memory_block_tb__DOT__tb_store_byte_pulse_in));
    bufp->fullCData(oldp+4,(vlSelfRef.memory_block_tb__DOT__tb_set_address_in),4);
    bufp->fullBit(oldp+5,(vlSelfRef.memory_block_tb__DOT__tb_set_address_pulse_in));
    bufp->fullIData(oldp+6,(vlSelfRef.memory_block_tb__DOT__tb_test_num),32);
    bufp->fullIData(oldp+7,(vlSelfRef.memory_block_tb__DOT__tb_passed),32);
    bufp->fullWData(oldp+8,(vlSelfRef.memory_block_tb__DOT__dut__DOT__memory),128);
    bufp->fullCData(oldp+12,((0xffU & (((0U == (0x1fU 
                                                & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))
                                         ? 0U : (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                                 (((IData)(7U) 
                                                   + 
                                                   (0x7fU 
                                                    & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))) 
                                                  >> 5U)] 
                                                 << 
                                                 ((IData)(0x20U) 
                                                  - 
                                                  (0x1fU 
                                                   & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U))))) 
                                       | (vlSelfRef.memory_block_tb__DOT__dut__DOT__memory[
                                          (3U & (VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U) 
                                                 >> 5U))] 
                                          >> (0x1fU 
                                              & VL_SHIFTL_III(7,7,32, (IData)(vlSelfRef.memory_block_tb__DOT__dut__DOT__address), 3U)))))),8);
    bufp->fullCData(oldp+13,(vlSelfRef.memory_block_tb__DOT__dut__DOT__address),4);
    bufp->fullBit(oldp+14,(vlSelfRef.memory_block_tb__DOT__tb_clk));
    bufp->fullCData(oldp+15,(vlSelfRef.memory_block_tb__DOT__dut__DOT__next_address),4);
}
