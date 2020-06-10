module ALU (Res, A, B, func);
  input [7:0] A, B;
  input [2:0] func;
  output [7:0] Res;
  reg Res;
  
  always@(func)
    begin
   case(func)
    0 : Res=A;
    1 : Res=A+1;
    2 : Res=A-1;
    3 : Res=A+B;
    4 : Res=A-B;
    5 : Res=A<<1;
    6 : Res=A>>1;
    7 : Res=A^B;
    default : Res=8'bxxxxxxx;
   endcase
    end
endmodule