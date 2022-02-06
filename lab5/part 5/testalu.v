`include "alu.v"

module testbench ;
    reg [7:0] DATA1, DATA2 ;
    reg [2:0] SELECT;
    wire [7:0] RESULT;
    wire zero;


Alu alu(zero, RESULT, DATA1, DATA2, SELECT);
initial begin 
    $dumpfile("wavedata.vcd");
    $dumpvars(0, testbench);

    DATA1=  65;
    DATA2 = 2;


SELECT = 0;
#5       $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);

SELECT = 4;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);

SELECT = 5;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);

SELECT = 6;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);
SELECT = 7;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);


$finish;
end
   
endmodule