module vga_disp	
(
	input					clk25M,
	input				   reset_n,
	input     [ 5:0]	rgb,
	
	output		 	   VGA_HSYNC,
	output 		 	   VGA_VSYNC,
	output	 [14:0]	addr,
	
	output reg[11:0]  VGA_D
);		

reg				hs;
reg				vs;
reg	[9:0]		hcnt;
reg   [9:0] 	vcnt;	
	
wire [10:0] 	x;
wire [10:0] 	y;
wire 				dis_en;

	
assign VGA_VSYNC = vs;
assign VGA_HSYNC = hs;
assign addr = {y[6:0],x[7:0]};
assign x = hcnt-(640-256)/2;
assign y = vcnt-(480-128)/2;
assign dis_en = (x<256 && y<128);
			
always @(posedge clk25M or negedge reset_n) begin			//水平扫描计数器
	if(!reset_n)
		hcnt <= 0;
	else begin
		if (hcnt < 800)
				hcnt <= hcnt + 1'b1;
		else
				hcnt <= 0;
	end
end
			
always @(posedge clk25M or negedge reset_n) begin			//垂直扫描计数器
	if(!reset_n)
		vcnt <= 0;
	else begin
		if (hcnt == 640 + 8) begin
			if (vcnt < 525)
				vcnt <= vcnt + 1'b1;
			else
				vcnt <= 0;
		end
	end
end
			
always @(posedge clk25M or negedge reset_n) begin			//场同步信号发生
	if(!reset_n)
		hs	<=	1;
	else begin
		if((hcnt >=640+8+8) & (hcnt < 640+8+8+96))
			hs <= 1'b0;
		else
			hs <= 1'b1;
	end
end
			
always @(vcnt or reset_n) begin							//行同步信号发生
	if(!reset_n)
		vs	<=	1;
	else begin
		if((vcnt >= 480+8+2) &&(vcnt < 480+8+2+2))
			vs	<=	1'b0;
		else
			vs	<=	1'b1;
	end
end
			
always @(posedge clk25M or negedge reset_n) begin
	if(!reset_n)
		VGA_D <= 0;
	else begin
		if (hcnt < 640 && vcnt < 480 && dis_en)	begin	//扫描终止
			VGA_D[11:8] <= {rgb[1],rgb[1],rgb[0],rgb[0]};
			VGA_D[7:4]  <= {rgb[3],rgb[3],rgb[2],rgb[2]};
			VGA_D[3:0]  <= {rgb[5],rgb[5],rgb[4],rgb[4]};
		end
		else if((hcnt>=0 && hcnt<2) || (vcnt>=0 && vcnt<2) || (hcnt<=639 && hcnt>637) || (vcnt>477 && vcnt<=479))
			VGA_D <= 12'hf00;
		else
			VGA_D <= 0;

	end
end
				
endmodule 
