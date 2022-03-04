// instruction cache module

module icache(
    input               clock,
    input               reset,
    input[9:0]          pc,
    input               read,
    input               mem_busywait,
    input[127:0]        mem_readdata,
    output[31:0]        instruction,
    output reg          busywait,
    output reg          mem_read,
    output reg [5:0]    mem_address
);