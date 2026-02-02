`timescale 1ns / 1ps


module md_flip_flop(
    input M,
    input D,
    input clk,
    output reg Q
);
    initial Q = 1'b1;

always @(posedge clk) begin
    if(M==0 && D==0) begin
        Q <=1'b0;
    end
    else if((M==0 && D==1)||(M==1 && D==0)) begin
        Q <= ~Q;
    end
    else if(M==1 && D==1)begin
        Q <=1'b1;
    end
end

endmodule


module ic4706(
    input A1,
    input A2,
    input A3,
    input clk,
    output S3,
    output S4,
    output Z
);

    wire degilA1, degilA2 ,degilA3;
    assign degilA1 = ~A1;
    assign degilA2 = ~A2;
    assign degilA3 = ~A3;
 
    wire S1, S2, S5, S6, Q1, Q2;
   
    assign S1=A1 ^ A2;
    assign S2=A2 & A3;

    md_flip_flop flip1(.M(S1),.D(degilA3),.clk(clk),.Q(Q1));
    md_flip_flop flip2(.M(Q1),.D(S2),.clk(clk),.Q(Q2));

    
    assign S3=Q1;
    assign S4=Q2;
    assign S5=S4 ^ degilA1;
    assign S6=S5 ~^degilA2;
    assign Z =~(S6 & degilA3);

endmodule
