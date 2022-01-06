module Alu (RESULT, DATA1, DATA2, SELECT);
input [7:0] DATA1, DATA2;
input [2:0] SELECT;
output reg [7:0] RESULT;
wire [7:0] ADD_OUT, FORWARD_OUT, AND_OUT, OR_OUT;

Forward fwd1(FORWARD_OUT, DATA2 );
Add add1(ADD_OUT, DATA1, DATA2 );
And and1(AND_OUT, DATA1, DATA2 );
Or or1(OR_OUT, DATA1, DATA2 );

always @(SELECT, DATA1, DATA2) begin //always @(*) begin
    

    case (SELECT)
        0:
            #1 RESULT = FORWARD_OUT;
        1:
            #2 RESULT = ADD_OUT; 
        2:
            #1 RESULT = AND_OUT; 
        3:
            #1 RESULT = OR_OUT; 
        default:
            RESULT = 0;

    endcase
end

endmodule

module Forward (FORWARD_OUT, DATA2);
    input [7:0]  DATA2;
    output [7:0] FORWARD_OUT;
    assign FORWARD_OUT =  DATA2; 
    
endmodule

module Add (ADD_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] ADD_OUT;
    assign ADD_OUT =  DATA1+DATA2; 
    
endmodule

module And (AND_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] AND_OUT;
    assign AND_OUT =  DATA1 & DATA2; 
    
endmodule

module Or (OR_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] OR_OUT;
    assign OR_OUT =  DATA1 | DATA2; 
    
endmodule