// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmemory_block_tb.h for the primary calling header

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb_memory_block_if__M10.h"

VL_ATTR_COLD void Vmemory_block_tb_memory_block_if__M10___ctor_var_reset(Vmemory_block_tb_memory_block_if__M10* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vmemory_block_tb_memory_block_if__M10___ctor_var_reset\n"); );
    Vmemory_block_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->reset_memory_pulse_in = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5484284053180212026ull);
    vlSelf->__PVT__read_address_pulse = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10427350887030693496ull);
    vlSelf->__PVT__read_byte_at_address_pulse = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2570656854024066630ull);
}
