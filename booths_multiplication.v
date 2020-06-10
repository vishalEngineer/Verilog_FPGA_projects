module booth (mpr, mpd, prod, start, done, clk);
    input [310] mpr, mpd;
    input start, clk;
    output [630] prod;
    output done;

    reg [630] prod;
    reg done;
    reg [20] state;
    reg [40] count;
    reg [310] A, Q, M;
    reg Qm1; 
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

    always @( negedge clk)
        begin
            case (state)
            S0
                if (start) state = S1;
            S1
                begin
                    done = 0;
                    A = 0; 
                    Qm1 = 0;  
                    count = 32;
                    M = mpd;
                    state = S2;
                end 
            S2
                begin
                    Q = mpr;
                    case ({Q[0],Qm1})
                    2'b01 
                        state = S3;
                    2'b10 
                        state = S4;
                    2'b00,2'b11
                        state = S5;
                    endcase
                end 
            S3 
                begin
                    A = A + M;
                    state = S5;
                end
            S4 
                begin 
                    A = A - M;
                    state = S5;
                end
            S5 
                begin
                    {A,Q,Qm1} = {A[31],A,Q};
                    count = count - 1;
                    if (count == 0) 
                        state = S6; 
                    else
                        begin
                            case ({Q[0],Qm1})
                            2'b01 
                                state = S3;
                            2'b10 
                                state = S4;
                            endcase
                        end
                end
            S6
                done = 1;
            default state = S0;
            endcase
            prod = {A, Q};
        end
endmodule        