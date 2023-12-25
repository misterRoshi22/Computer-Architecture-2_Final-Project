module tb_hazard_detection_unit;

    // Inputs
    reg ID_EXE_MemRead;
    reg [4:0] IF_ID_rs1, IF_ID_rs2, ID_EXE_rd;

    // Outputs
    wire control_MUX_select, IF_ID_REG_Write, PC_Write;

    // Instantiate the hazard_detection_unit module
    hazard_detection_unit uut (
        .ID_EXE_MemRead(ID_EXE_MemRead),
        .IF_ID_rs1(IF_ID_rs1),
        .IF_ID_rs2(IF_ID_rs2),
        .ID_EXE_rd(ID_EXE_rd),
        .control_MUX_select(control_MUX_select),
        .IF_ID_REG_Write(IF_ID_REG_Write),
        .PC_Write(PC_Write)
    );

    // Test scenario
    initial begin
        // Cycle 1
        ID_EXE_MemRead = 0;
        IF_ID_rs1 = 5'd1;
        IF_ID_rs2 = 5'd0;
        ID_EXE_rd = 5'd0;
		  #10;

        // Cycle 2
        ID_EXE_MemRead = 1;
        IF_ID_rs1 = 5'd2;
        IF_ID_rs2 = 5'd5;
        ID_EXE_rd = 5'd2;
        #10; 
        
        // Cycle 3
        ID_EXE_MemRead = 0;
        IF_ID_rs1 = 5'd2;
        IF_ID_rs2 = 5'd6;
        ID_EXE_rd = 5'd4;
        #10; 
		  
        // Cycle 4
        ID_EXE_MemRead = 0;
        IF_ID_rs1 = 5'd4;
        IF_ID_rs2 = 5'd2;
        ID_EXE_rd = 5'd8;
        #10;
		 
			// Cycle 5
        ID_EXE_MemRead = 0;
        IF_ID_rs1 = 5'd0;
        IF_ID_rs2 = 5'd0;
        ID_EXE_rd = 5'd9;
        #10;  
        
        // Finish simulation
        $finish;
    end

endmodule // tb_hazard_detection_unit
