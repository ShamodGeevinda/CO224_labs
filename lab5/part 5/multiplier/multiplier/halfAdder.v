module half_adder(SUM,CARRY,INPUT1,INPUT2);

	input INPUT1,INPUT2;
	output SUM,CARRY;
	
	xor x1(SUM,INPUT1,INPUT2);
	and a1(CARRY,INPUT1,INPUT2);


endmodule