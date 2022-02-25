`timescale 1ns / 1ps
module lfsr_tb();
    reg clock;
    reg reset;
    reg [3:0] seed;
    reg load;
    wire q;
    lfsr DUT(q, clk, rst,
            seed, load);
        // initialization
    // drive clock
    always
        #50 clock = ~ clock;
    // program lfsr
    initial begin
        #100 seed = 4'b0001;
        load = 1;
        #100 load = 0;
end

endmodule


