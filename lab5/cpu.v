`include "reg.v"
`include "alu.v"

    // opcodes
    // loadi= "00000000";
	// mov 	= "00000001";
	// add 	= "00000010";
	// sub 	= "00000011";
	// and 	= "00000100";
	// or 	= "00000101";

module cpu (PC, INSTRUCTION, CLK, RESET );
    input CLK, RESET;
    input [31:0] INSTRUCTION;
    output reg [31:0] PC = 0;
    reg[2:0] ALUOP;
    reg subs, imm, written, mov;
    wire [7:0] REGOUT1, REGOUT2, RESULT,twosout,muxout, aluout, mux2out;
    //wire [7:0] WRITEDATA;
    
    
    reg_file myregfile(aluout, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8],INSTRUCTION[2:0], written, CLK, RESET);
    twos_comp for_sub(twosout, REGOUT2);
    mux select2s(muxout, REGOUT2, twosout, imm);
    mux immediate_or_reg(mux2out, INSTRUCTION[7:0], muxout, mov);
    Alu alu(aluout, REGOUT1, REGOUT2, ALUOP);
    // pc update

    always @(INSTRUCTION) begin
        // assign opcode = INSTRUCTION[31:24]; // opcode
        // assign rd = INSTRUCTION[23:16];     // destination
        // assign rt = INSTRUCTION[15:8];      // operand 1
        // assign rs = INSTRUCTION[7:0];       // operand 2 or immediate
        #1
        case (INSTRUCTION[31:24])
            
            0: begin // loadi
                assign imm = 1; // select for immediate value for loadi 
                assign ALUOP = 0;
            end 
            1: begin  // mov
                assign written = 1; // written enables
                assign ALUOP = 0;
                assign mov = 1;
            end
            2: begin // add
                 // select for immediate value for loadi 
                assign ALUOP = 1;
            end
                
            3: begin // sub
                assign subs = 1; // to select 2s complement
                assign ALUOP = 1;
            end
            4: begin // and
                
                assign ALUOP = 2;
            end
            4: begin // or
                
                assign ALUOP = 3;
            end

            
            default: begin
                assign ALUOP = 4;
                assign imm = 0;
                assign subs = 0; 
                assign written = 0;
                assign mov =0;
            end
            

                
        endcase


       // reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8],INSTRUCTION[2:0], written, CLK, RESET);

    end
    

    




    
endmodule

module mux (OUTPUT, INPUT1, INPUT2, SELECT);
    input SELECT;
    input[7:0] INPUT1, INPUT2;
    output reg [7:0] OUTPUT;
    always @(SELECT) begin
        if (SELECT==0) OUTPUT = INPUT1;
        else OUTPUT = INPUT2;
    end
    
endmodule


module twos_comp (OUTPUT, INPUT);
    input[7:0] INPUT;
    output[7:0] OUTPUT;
    assign  #1 OUTPUT[7:0] = -INPUT[7:0];
    
    
endmodule