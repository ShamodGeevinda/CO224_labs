`include "multiplier.v"

module multi (MUL_OUT, DATA1, DATA2);
input  [7:0] DATA1 ,DATA2; 
output reg[7:0] MUL_OUT;
wire MSB;
wire[6:0] data1, data2, comp;
wire[7:0] val, NEWD1, NEWD2;

xor x1(MSB, DATA1[7], DATA2[7]);

twos_comp tc1(data1, DATA1[6:0]);
twos_comp tc2(data2, DATA2[6:0]);
ctrl ct(NEWD1, NEWD2, DATA1, DATA2, MSB, data1, data2);

multiplier m1(val, NEWD1, NEWD2);

twos_comp tc4(comp, val[6:0]);




initial begin
  #2
  if (DATA1 == 0 || DATA2 == 0) begin
     MUL_OUT = 8'b0;
        
  end
  else begin
   if (!MSB) begin
      
        MUL_OUT = {1'b0, {val[6:0]}};
   end
        
       
   
   else begin
       
         MUL_OUT = {1'b1, comp};
       
   end
   
end
end

    
endmodule


// 2s complement generator
module twos_comp (OUTPUT, INPUT);
    input[6:0] INPUT;
    output[6:0] OUTPUT;
    assign   OUTPUT = ~INPUT+1;
       
endmodule

// module myxor (OUT, IN1, IN2);
//   input IN1, IN2;
//   output OUT;
//   assign OUT = IN1 ^ IN2;
// endmodule

module ctrl (ND1, ND2, DATA1, DATA2, MSB, data1, data2);
input  [7:0] DATA1 ,DATA2;
input MSB; 
input [6:0] data1, data2;
output reg  [7:0] ND1, ND2;

// output reg [7:0] O1, O2;

initial begin
  #1
  
   if (!MSB) begin
     if (DATA1[7]) begin
       
         ND1 = {1'b0,data1};
         ND2 = {1'b0, data2};
     end
     else begin 
          ND1 = {1'b0,DATA1[6:0]};
         ND2 = {1'b0, DATA2[6:0]};
     end
        
       
   end
   
   else begin
       if (DATA1[7]) begin
         ND1 = {1'b0,data1};
         ND2 = DATA2;

       end
       else begin
         ND1 = DATA1;
         ND2 = {1'b0, data2};
       end
   end
  
end

endmodule
