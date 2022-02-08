`include "DADDA_Multiplier.v"

module multi (MUL_OUT, DATA1, DATA2);
input [7:0] DATA1 ,DATA2;
output reg[7:0] MUL_OUT;
wire MSB;
wire[7:0] data1, data2;
wire[15:0] dada_out1, dada_out2, dada_out3;


xor x1(MSB, DATA1[7], DATA2[7]);
twos_comp tc1(data1, DATA1);
twos_comp tc2(data2, DATA2);
DADDA_Multiplier d1(DATA1, DATA2, dada_out1);
DADDA_Multiplier d2(data1, DATA2, dada_out2);
DADDA_Multiplier d3(DATA1, data2, dada_out3);



initial begin
   if (!MSB) begin
        MUL_OUT = {MSB, dada_out1[7:0]};
       
   end
   else begin
       if (DATA1[7]) begin
         MUL_OUT = {MSB, dada_out2[7:0]};


       end
       else begin
         MUL_OUT = {MSB, dada_out3[7:0]};
       end
   end
   
end
//assign #1 d1[0] = DATA1[0];
    
endmodule


// 2s complement generator
module twos_comp (OUTPUT, INPUT);
    input[7:0] INPUT;
    output[7:0] OUTPUT;
    assign   OUTPUT = ~INPUT+1;
       
endmodule