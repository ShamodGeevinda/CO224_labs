/*
 *
 *	Part 3
 *	CONTROL UNIT
 *
 *
 */


module control_unit(BUSYWAIT, READ, WRITE, MUX_WRITEDATA, ALUOP,MUX_2SCMPL,MUX_IMMD,WRITEENABLE,BEQ_ENABLE, JUMP_ENABLE, BNE_ENABLE, SHIFT_ENABLE, SHIFTOP, OP);

	input [7:0] OP;						// opcode

	output reg MUX_2SCMPL, MUX_IMMD, WRITEENABLE, BEQ_ENABLE, JUMP_ENABLE, BNE_ENABLE, SHIFT_ENABLE,BUSYWAIT, READ, WRITE, MUX_WRITEDATA;		// 1 bit outputs from control unit
	output reg [1:0] SHIFTOP;				// shift type
	output reg [2:0] ALUOP;					// 3-bits ALU opcode

	
	always @(*)
	begin 	
		
		#1

		case(OP)
			// case for load immediate value
			8'b00000000: begin
			
				ALUOP = 3'b000;		// alu operation code 
				MUX_2SCMPL = 1'b0;	// 2s complement select pin
				MUX_IMMD = 1'b1;	// immediadte value select pin
				WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;	// branch equal enable pin
				JUMP_ENABLE = 1'b0;	// jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
				
			end
			
			// case for move register value
			8'b00000001: begin

				ALUOP = 3'b000;		// alu operation code
				MUX_2SCMPL = 1'b0;	// 2s complement select pin
				MUX_IMMD = 1'b0;	// immediadte value select pin
				WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                JUMP_ENABLE = 'b0;      // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
			end

			// case for add operation
			8'b00000010: begin
				
				ALUOP = 3'b001;		// alu operation code
                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                MUX_IMMD = 1'b0;	// immediadte value select pin
                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
			end

			// case for sub operation
			8'b00000011: begin

				ALUOP = 3'b001;		// alu operation code
                MUX_2SCMPL = 1'b1;	// 2s complement select pin
                MUX_IMMD = 1'b0;	// immediadte value select pin
                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
			end	


			// case for and operation
			8'b00000100: begin
				
				ALUOP = 3'b010;		// alu operation code
                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                MUX_IMMD = 1'b0;	// immediadte value select pin
                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
                        
			end

			// case for or operation
			8'b00000101: begin
				
				ALUOP = 3'b011;		// alu operation code
                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                MUX_IMMD = 1'b0;	// immediadte value select pin
                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
                        
			end

			// case for beq
			8'b00000111: begin

				ALUOP = 3'b001;         // alu operation code
				MUX_2SCMPL = 1'b1;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b0;     // register write enable pin
				BEQ_ENABLE = 1'b1;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory

			end	

			// case for jump
			8'b00000110: begin

				ALUOP = 3'b111;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b0;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b1;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory

			end
			
			
			
			// case for multiplication 
			8'b00001100: begin
				
				ALUOP = 3'b100;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory

			end
			
			// case for left logical shift
			8'b00001101: begin
				
				ALUOP = 3'b101;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b11;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
			
			end
			
			// case for right logical shift
			8'b00001110: begin
			
				ALUOP = 3'b101;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b00;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory

			end
			
			// case for right arithmetic shift
			8'b00001111: begin
				
				ALUOP = 3'b110;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b01;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
			
			end
			
			// case for rotate right 
			8'b00010000: begin
				
				ALUOP = 3'b110;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b10;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory
			
			end
			
			
			
			//case for bne
			8'b00010001: begin
				
				ALUOP = 3'b111;         // alu operation code
				MUX_2SCMPL = 1'b1;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b0;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b1;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				BUSYWAIT = 1'b0;    // BUSYWAIT signal for stall cpu
				READ = 1'b0;		// memory read
				WRITE = 1'b0;		// memory write
				MUX_WRITEDATA = 1'b0; // selecting data from memory

			end
			// char *op_lwd 	= "00001000";
			// char *op_lwi 	= "00001001";
			// char *op_swd 	= "00001010";
			// char *op_swi 	= "00001011";
			
		endcase
	end

endmodule
					
	

