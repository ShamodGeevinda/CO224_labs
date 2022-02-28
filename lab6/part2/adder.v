/*
 *
 *	Part 3
 *	Adder
 * 
 *
 */
`timescale 1ns/100ps

module adder(RESULT, INPUT1, INPUT2);
	
	// port declaration
	input [31:0] INPUT1, INPUT2;
	output [31:0] RESULT;
	
	assign #1 RESULT = INPUT1 + INPUT2;

endmodule

