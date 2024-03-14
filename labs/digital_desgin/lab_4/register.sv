`timescale 1ps/1ps


module register #(
    parameter WIDTH = 8
)(  // input enable
    input logic enable,
    //input clk
    input logic clk,
    input logic rst_,
    //input data
    input logic [WIDTH-1:0] data,
    //output data
    output logic [WIDTH-1:0] out
);



always_ff @( posedge clk,negedge rst_ ) begin : register_ff
    if(!rst_)
    out <='b0;
    else
    out <= enable?data:out;
end
    
endmodule