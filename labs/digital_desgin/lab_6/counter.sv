`timescale 1ps/1ps


module counter #(
    parameter WIDTH = 5
)(  // input enable
    input logic enable,
    // input load
    input logic load,
    //input clk
    input logic clk,
    //input reset
    input logic rst_,
    //input data
    input logic [WIDTH-1:0] data,
    //output data
    output logic [WIDTH-1:0] count
);



always_ff @( posedge clk,negedge rst_ ) begin : register_ff
    if(!rst_)
    count <='b0;
    else
        begin
            if(load)
                count <= data;
            else
            if(enable)
            count <= count + 'b1;
        end
end
    
endmodule