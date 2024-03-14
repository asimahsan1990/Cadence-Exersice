// `timescale 1ps/1ps
timeunit 1ns;
timeprecision 100ps;

import typedefs::*;

module alu #(
    parameter WIDTH = 8
)(  // input enable
    input opcode_t opcode,
    //input data
    input logic [WIDTH-1:0] accum,
    input logic [WIDTH-1:0] data,
    //output data
    output logic [WIDTH-1:0] out,
    output logic zero
);


always_comb begin : alu_zero
    zero = (|accum)?0:1;
end

always_comb begin : alu_out
    case (opcode)
        HLT,SKZ,STO,JMP : out = accum;
        ADD   : out = data + accum;
        AND   : out = data & accum;
        XOR   : out = data ^ accum;
        LDA   : out = data;
        default: out = 'b1;
    endcase
end

    
endmodule