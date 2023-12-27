module pc_register(clk, reset_n, write_enable, IN, OUT);
    parameter n = 15;                       
    input clk, reset_n, write_enable;
    input [n-1:0] IN;
    output reg [n-1:0] OUT;

    always @ (posedge clk) begin
        if (reset_n == 1)  OUT <= 0;        		//Reset is active high
        else if (write_enable) OUT <= IN;       //If write_enable is high then write IN onto register
    end
endmodule // PC_register
