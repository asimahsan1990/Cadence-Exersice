module multidriver #(
    parameter WIDTH = 4
) ( //input enable
    input logic data_en1,
    input logic data_en2,
    //input data
    input logic [WIDTH-1:0] data_in1,
    input logic [WIDTH-1:0] data_in2,
    //output data
    output wire [WIDTH-1:0] data_out

);
    
    tri_driver   #(
    .WIDTH ( WIDTH )
   ) U1 (
    .data_en(data_en1),
    .data_in(data_in1),
    .data_out(data_out)
   );

    tri_driver   #(
    .WIDTH ( WIDTH )
   ) U2 (
    .data_en(data_en2),
    .data_in(data_in2),
    .data_out(data_out)
   );

endmodule