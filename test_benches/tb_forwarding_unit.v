module tb_forwarding_unit;

    // Inputs
    reg [4:0] EXE_MEM_rd, MEM_WB_rd;
    reg [4:0] ID_EXE_rs1, ID_EXE_rs2;
    reg EXE_MEM_RegWrite, MEM_WB_RegWrite;

    // Outputs
    wire [1:0] ForwardA, ForwardB;

    // Instantiate the forwarding_unit module
    forwarding_unit uut (
        .EXE_MEM_rd(EXE_MEM_rd),
        .MEM_WB_rd(MEM_WB_rd),
        .ID_EXE_rs1(ID_EXE_rs1),
        .ID_EXE_rs2(ID_EXE_rs2),
        .EXE_MEM_RegWrite(EXE_MEM_RegWrite),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    // Test scenario
    initial begin
	 
			//sub	x2 x1 x3
			//add	x12 x2 x3
			//or x13 x6 x2
			//add x14 x2 x2
			//sd x15 100(x2)
			
			
			//add x1 x1 x2
			//add x1 x1 x3
			//add x1 x1 x4
	 
		  // Cycle 1
        EXE_MEM_rd = 5'b0;
        MEM_WB_rd = 5'b0;
        ID_EXE_rs1 = 5'b0;
        ID_EXE_rs2 = 5'b0;
        EXE_MEM_RegWrite = 1'b0;
        MEM_WB_RegWrite = 1'b0;
		  #10;
	 
	 
	 
        // Cycle 2
        EXE_MEM_rd = 5'b0;
        MEM_WB_rd = 5'b0;
        ID_EXE_rs1 = 5'b1;
        ID_EXE_rs2 = 5'd3;
        EXE_MEM_RegWrite = 1'b0;
        MEM_WB_RegWrite = 1'b0;
		  #10;


		  // Cycle 3
        EXE_MEM_rd = 5'd2;
        MEM_WB_rd = 5'd0;
        ID_EXE_rs1 = 5'd2;
        ID_EXE_rs2 = 5'd5;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b0;
        #10;
        
		  // Cycle 4
        EXE_MEM_rd = 5'd12;
        MEM_WB_rd = 5'd2;
        ID_EXE_rs1 = 5'd6;
        ID_EXE_rs2 = 5'd2;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b1;
        #10;
		  
		  
		  // Cycle 5
		  EXE_MEM_rd = 5'd13;
        MEM_WB_rd = 5'd12;
        ID_EXE_rs1 = 5'd2;
        ID_EXE_rs2 = 5'd2;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b1;
        #10;
		  
		  // Cycle 6
		  EXE_MEM_rd = 5'd14;
        MEM_WB_rd = 5'd13;
        ID_EXE_rs1 = 5'd2;
        ID_EXE_rs2 = 5'd0;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b1;
        #10;
		  
		  // Cycle 7
		  EXE_MEM_rd = 5'd15;
        MEM_WB_rd = 5'd14;
        ID_EXE_rs1 = 5'd2;
        ID_EXE_rs2 = 5'd5;
        EXE_MEM_RegWrite = 1'b0;
        MEM_WB_RegWrite = 1'b1;		  
		  #40;
		  
		  //TEST FOR DOUBLE DATA HAZARDS
		  
		  // Cycle 1
		  EXE_MEM_rd = 5'd0;
        MEM_WB_rd = 5'd0;
        ID_EXE_rs1 = 5'd1;
        ID_EXE_rs2 = 5'd2;
        EXE_MEM_RegWrite = 1'b0;
        MEM_WB_RegWrite = 1'b0;
        #10;
		  
		  // Cycle 2
		  EXE_MEM_rd = 5'd1;
        MEM_WB_rd = 5'd0;
        ID_EXE_rs1 = 5'd1;
        ID_EXE_rs2 = 5'd3;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b0;
        #10;
		  
		  
		  // Cycle 3
		  EXE_MEM_rd = 5'd1;
        MEM_WB_rd = 5'd1;
        ID_EXE_rs1 = 5'd1;
        ID_EXE_rs2 = 5'd4;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b1;
        #10;
		  
		  
		  // Cycle 3
		  EXE_MEM_rd = 5'd1;
        MEM_WB_rd = 5'd0;
        ID_EXE_rs1 = 5'd0;
        ID_EXE_rs2 = 5'd0;
        EXE_MEM_RegWrite = 1'b1;
        MEM_WB_RegWrite = 1'b0;
        #10;
		  
		  
        // Finish simulation
        $finish;
    end

endmodule // tb_forwarding_unit
