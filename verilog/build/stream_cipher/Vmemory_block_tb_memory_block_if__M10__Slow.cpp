// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmemory_block_tb.h for the primary calling header

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb__Syms.h"
#include "Vmemory_block_tb_memory_block_if__M10.h"

void Vmemory_block_tb_memory_block_if__M10___ctor_var_reset(Vmemory_block_tb_memory_block_if__M10* vlSelf);

Vmemory_block_tb_memory_block_if__M10::Vmemory_block_tb_memory_block_if__M10(Vmemory_block_tb__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vmemory_block_tb_memory_block_if__M10___ctor_var_reset(this);
}

void Vmemory_block_tb_memory_block_if__M10::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vmemory_block_tb_memory_block_if__M10::~Vmemory_block_tb_memory_block_if__M10() {
}
