// `timescale 1ps/1ps
  timeunit        1ns ;
  timeprecision 100ps ;

module scale_mux #(
    parameter WIDTH = 1
)(  // input enable
    input logic sel_a,
    //input data
    input logic [WIDTH-1:0] in_a,
    input logic [WIDTH-1:0] in_b,
    //output data
    output logic [WIDTH-1:0] out
);

// assign out = sel_a?in_b:in_a;

always_comb begin : mux
    unique case (sel_a)
        0 : out = in_b;
        1 : out = in_a;
        default: out='bx;
    endcase
end

    
endmodule