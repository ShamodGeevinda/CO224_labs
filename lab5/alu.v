module Alu (RESULT, DATA1, DATA2, SELECT);
input [7:0] DATA1, DATA2;
input [2:0] SELECT;
output reg [7:0] RESULT;
wire [7:0] ADD_OUT, FORWARD_OUT, AND_OUT, OR_OUT;

Add add(ADD_OUT, DATA1, DATA2 );

always @(*) begin
    

    case (SELECT)
        0:
            #1 RESULT = 5;
        1:
            #1 RESULT = ADD_OUT; 
        default:
            RESULT = 0;

    endcase
end

endmodule

module Add (ADD_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] ADD_OUT;
    //initial begin
        assign ADD_OUT =  DATA1+DATA2;
    //end 
    
endmodule