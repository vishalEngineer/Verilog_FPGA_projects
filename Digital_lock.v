module seq(d_in,d_out,door_open,clk,reset);
	input d_in,clk,reset;
	output d_out, door_open;
	parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6;
	reg [2:0]state,ns;
	reg d_out;
//	reg door_open;
    assign door_open=d_out;
	always@(posedge clk)
	begin
	if(reset==0) state<=s0;
	else state<=ns;
    end

    always@(d_in,state)
    begin
    	case(state)
    		s0: begin
    			if(d_in==1) begin ns<=s1; end 
    			else begin ns<=s0; end	
    			end 
    		s1: begin
    			if(d_in==0) begin ns<=s2; end 
    			else begin ns<=s1; end	
    			end
    		s2: begin
    			if(d_in==1) begin ns<=s3; end 
    			else begin ns<=s2; end	
    			end 	
    		s3: begin
    			if(d_in==0) begin ns<=s4; end 
    			else begin ns<=s2; end	
    			end 
    		s4: begin
    			if(d_in==1) begin ns<=s5; end 
    			else begin ns<=s3; end	
    			end 	
    		s5: begin
    			if(d_in==0) begin ns<=s6; end 
    			else begin ns<=s4; end	
    			end
    		s6: begin
    			if(d_in==1) begin ns<=s5; end 
    			else begin ns<=s0; end	
    			end 
    		default: ns<=s0;
    	endcase // state
    end

    always@(state)
    begin
    	case(state)
    		s0: d_out=0;
    		s1: d_out=0;
    		s3: d_out=0;
    		s4: d_out=0;
    		s5: d_out=0;
    		s6: d_out=1;
    		default: d_out=0;
    	endcase // state
    end

endmodule    		




