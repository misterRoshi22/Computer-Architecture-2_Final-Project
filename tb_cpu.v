module tb_cpu;

	reg Clock; 
	reg Reset_n;
	
	wire [14:0] sepc;
	wire [31:0] scause;
	
	cpu uut(Clock, Reset_n, sepc, scause);
	
	
	initial begin
		Clock = 1;
		Reset_n = 1;
		
		#10 Reset_n = 0;
		
		#1000;
		
		$finish;
	end
		
	
	always begin 
		#5 Clock = ~Clock;
	end
	
endmodule //tb_cpu
		