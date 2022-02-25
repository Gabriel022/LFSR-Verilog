`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AKen Institute of Advanced Learning
// Engineer: Gabriel Facco Bettinelli




//As the wikipedia article on LFSRs explains, there are two forms of expressing LFSRs. The first is a Galois form, the second is known as the Fibonacci form.
//Both will yield the same sequences, although their initial parameters, INITIAL_FILL, and their TAPS values will be difference from one form to the other.


//LFSRs can never have the value of zero, since every shift of a zeroed LFSR will leave it as zero. 
//he LFSR must be initialized, i.e., seeded, to a nonzero value. When the LFSR holds 1 and is shifted once, its value will always be the value of the polynomial mask.
// When the register is all zeros except the most significant bit, then the next several shifts will show the high bit shift to the low bit with zero fill.




module flipflop(q, clock, reset, i);
//inputs
    input reset;
    input clock;
    input i;
    //outputs
    output q;
    reg q;

    always @(posedge clock or posedge reset)
    begin
        if (reset)
        q = 0;
        else
        q = i;
    end
endmodule


//module for mux
module mux(q, control, a, b);
    output q;
    reg q;
    input control, a, b;

    wire negatecontrol;
    always @(control or
        negatecontrol or
        a or b)
    q = (control & a) |
    (negatecontrol & b);
    not (negatecontrol, control);
endmodule



//module for LFSR
module lfsr(q, clock, reset, seed, load);
    output q;
 

    input clock;
    input [3:0] seed;
    input load;
    input reset;
    wire [3:0] state_out;
    wire [3:0] state_in;
  
    flipflop F[3:0] (state_out,  clock, reset, state_in); // Call flipflop function, return value in state_out
    mux M1[3:0] (state_in, load, seed, {state_out[2],  // Call Mux calling  state_in for return value.
                    state_out[1],
                    state_out[0],
                    nextbit});    // Here is the LFSR bit.
    xor G1(nextbit, state_out[2], state_out[3]);
assign q = nextbit;  // lfsr will return value to nextbit. Assign value to q output.

//end
endmodule


//In pseudocode notation, an LFSR just applies the linear operator to the current sreg value over and over again.


