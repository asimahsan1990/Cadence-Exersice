module tri_driver #(
    parameter WIDTH = 8
)(  // input enable
    input logic data_en,
    //input data
    input logic [WIDTH-1:0] data_in,
    //output data
    output logic [WIDTH-1:0] data_out
);

assign data_out = data_en?data_in:'bz;

    
endmodule