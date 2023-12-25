module instruction_memory(clk, address, read_data);

input clk;
 input [14:0] address;
 output reg [31:0] read_data;

reg [7:0] memory[0:2047];
initial begin

		memory[0] = 8'h1b;    //addi x2 zero 0
		memory[1] = 8'h01;
		memory[2] = 8'h00;
		memory[3] = 8'h00;

		memory[4] = 8'h9b;    //addi x3 zero 0
		memory[5] = 8'h01;
		memory[6] = 8'h00;
		memory[7] = 8'h00;

		memory[8] = 8'h9b;    //addi x1 x1 52
		memory[9] = 8'h80;
		memory[10] = 8'h40;
		memory[11] = 8'h03;

		memory[12] = 8'h1b;    //addi x2 x2 21
		memory[13] = 8'h01;
		memory[14] = 8'h51;
		memory[15] = 8'h01;

		memory[16] = 8'h9b;    //addi x3 x3 33
		memory[17] = 8'h81;
		memory[18] = 8'h11;
		memory[19] = 8'h02;

		memory[20] = 8'h1b;    //addi x4 x4 2
		memory[21] = 8'h02;
		memory[22] = 8'h22;
		memory[23] = 8'h00;

		memory[24] = 8'h93;    //ori x5 x1 1
		memory[25] = 8'hf2;
		memory[26] = 8'h10;
		memory[27] = 8'h00;

		memory[28] = 8'h13;    //andi x6 x2 63
		memory[29] = 8'h63;
		memory[30] = 8'hf1;
		memory[31] = 8'h03;

		memory[32] = 8'hb3;    //add x7 x2 x2
		memory[33] = 8'h63;
		memory[34] = 8'h21;
		memory[35] = 8'h00;

		memory[36] = 8'h33;    //or x8 x2 x3
		memory[37] = 8'h34;
		memory[38] = 8'h31;
		memory[39] = 8'h00;

		memory[40] = 8'hb3;    //xor x9 x1 x2
		memory[41] = 8'hf4;
		memory[42] = 8'h20;
		memory[43] = 8'h00;

		memory[44] = 8'h33;    //slt x10 x2 x3
		memory[45] = 8'h45;
		memory[46] = 8'h31;
		memory[47] = 8'h00;

		memory[48] = 8'hb3;    //sll x11 x1 x4
		memory[49] = 8'ha5;
		memory[50] = 8'h40;
		memory[51] = 8'h00;

		memory[52] = 8'h33;    //srl x12 x1 x4
		memory[53] = 8'h86;
		memory[54] = 8'h40;
		memory[55] = 8'h00;

		memory[56] = 8'hb3;    //sub x13 x2 x1
		memory[57] = 8'h16;
		memory[58] = 8'h11;
		memory[59] = 8'h28;

		memory[60] = 8'h33;    //sub x14 x2 x1
		memory[61] = 8'h17;
		memory[62] = 8'h11;
		memory[63] = 8'h28;

		memory[64] = 8'hb8;    //lui x15 349525
		memory[65] = 8'h57;
		memory[66] = 8'h55;
		memory[67] = 8'h55;

end
wire [14:0] add0, add1, add2, add3;

assign add0 = (address & 15'h7ffc) + 15'd0;
assign add1 = (address & 15'h7ffc) + 15'd1;
assign add2 = (address & 15'h7ffc) + 15'd2;
assign add3 = (address & 15'h7ffc) + 15'd3;
always @(negedge clk) begin //reading done at negative edges
	read_data <= {memory[add3], memory[add2], memory[add1], memory[add0]};
end

endmodule // instruction_memory

