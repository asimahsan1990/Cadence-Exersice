// `timescale 1ps/1ps
timeunit 1ns;
timeprecision 100ps;

import typedefs::*;

module control (  // input opcode
    input opcode_t opcode,
    //input data
    input logic clk,
    input logic rst_,
    input logic zero,

    //output data
    output logic mem_rd,
    output logic load_ir,
    output logic halt,
    output logic inc_pc,
    output logic load_ac,
    output logic load_pc,
    output logic mem_wr
);

state_t state;
logic aluop;
logic skz_zero;
logic htl_check;
logic jmp_check;
logic sto_check;

always_ff @( posedge clk,negedge rst_ ) begin : fsm
    if(!rst_)
    state <= state.first();
    else
    state <= state.next();
end

always_comb begin : output_signals
    aluop = ((opcode == ADD) || (opcode == AND) || (opcode == XOR) || (opcode == LDA))?1:0;
    skz_zero = (zero && (opcode == SKZ))?1:0; 
    htl_check = (opcode == HLT)?1:0;
    jmp_check = (opcode == JMP)?1:0;
    sto_check = (opcode == STO)?1:0;

    case (state)
    INST_ADDR:  {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = 'b0;
    INST_FETCH: {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {1'b1,6'b0};
    INST_LOAD:  {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {2'b11, 5'b0};
    IDLE:       {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {2'b11, 5'b0};
    OP_ADDR:    {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {2'b0,htl_check,1'b1, 3'b0};
    OP_FETCH:   {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {aluop,6'b0};
    ALU_OP:     {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {aluop,2'b0,skz_zero,aluop,jmp_check,1'b0};
    STORE:      {mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr} = {aluop,2'b0,jmp_check,aluop,jmp_check,sto_check};
    endcase
    
end
    
endmodule