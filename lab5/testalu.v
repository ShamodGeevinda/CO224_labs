`include "alu.v"

module testbench ;
    reg [7:0] DATA1, DATA2 ;
    reg [2:0] SELECT;
    wire [7:0] RESULT;


Alu alu(RESULT, DATA1, DATA2, SELECT);
initial begin 
    DATA1 = 'b00000010;
    DATA2 = 'b00001010; 
    DATA1=  10;
    DATA1 = 12;

//SELECT = 'b00000001;
SELECT = 0;
#5 $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);
  end  
endmodule