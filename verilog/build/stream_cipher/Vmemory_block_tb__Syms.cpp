// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vmemory_block_tb__pch.h"
#include "Vmemory_block_tb.h"
#include "Vmemory_block_tb___024root.h"
#include "Vmemory_block_tb_memory_block_if__M10.h"

// FUNCTIONS
Vmemory_block_tb__Syms::~Vmemory_block_tb__Syms()
{
#ifdef VM_TRACE
    if (__Vm_dumping) _traceDumpClose();
#endif  // VM_TRACE
}

void Vmemory_block_tb__Syms::_traceDump() {
    const VerilatedLockGuard lock{__Vm_dumperMutex};
    __Vm_dumperp->dump(VL_TIME_Q());
}

void Vmemory_block_tb__Syms::_traceDumpOpen() {
    const VerilatedLockGuard lock{__Vm_dumperMutex};
    if (VL_UNLIKELY(!__Vm_dumperp)) {
        __Vm_dumperp = new VerilatedVcdC();
        __Vm_modelp->trace(__Vm_dumperp, 0, 0);
        std::string dumpfile = _vm_contextp__->dumpfileCheck();
        __Vm_dumperp->open(dumpfile.c_str());
        __Vm_dumping = true;
    }
}

void Vmemory_block_tb__Syms::_traceDumpClose() {
    const VerilatedLockGuard lock{__Vm_dumperMutex};
    __Vm_dumping = false;
    VL_DO_CLEAR(delete __Vm_dumperp, __Vm_dumperp = nullptr);
}

Vmemory_block_tb__Syms::Vmemory_block_tb__Syms(VerilatedContext* contextp, const char* namep, Vmemory_block_tb* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
    , TOP__memory_block_tb__DOT__dut_bus{this, Verilated::catName(namep, "memory_block_tb.dut_bus")}
{
        // Check resources
        Verilated::stackCheck(98);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-9);
    _vm_contextp__->timeprecision(-11);
    // Setup each module's pointers to their submodules
    TOP.__PVT__memory_block_tb__DOT__dut_bus = &TOP__memory_block_tb__DOT__dut_bus;
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    TOP__memory_block_tb__DOT__dut_bus.__Vconfigure(true);
}
