// `timescale 1ps/1ps
timeunit 1ns;
timeprecision 100ps;

module alu #(
    parameter WIDTH = 8
)(  // input enable
    input logic [2:0] opcode,
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
        0,1,6,7 : out = accum;
        2   : out = data + accum;
        3   : out = data & accum;
        4   : out = data ^ accum;
        5   : out = data;
        default: out = 'b1;
    endcase
end

    
endmodule