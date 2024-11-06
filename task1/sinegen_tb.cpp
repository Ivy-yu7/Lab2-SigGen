#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"
#include "Vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen* top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    // init Vbuddy
    if (vbdOpen()!= 1) return(-1);
    vbdHeader("Lab 1: Counter");

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 0;
    top->incr = 1;

    // run simulation for many clock cycles
    for (i=0; i<1000000; i++) {

        // dump variables into VCD file and toggle clock
        for (clk=0; clk<2; clk++) {
            tfp->dump (2*i+clk);  // unit is in ps!!!
            top->clk = !top->clk;
            top->eval  ();
        }
    
        top->incr = vbdValue();
        vbdPlot(int (top->dout), 0, 255);
        vbdCycle(i);

        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) exit(0);
    }

    vbdClose();    // ++++
    tfp->close();
    exit(0);
}