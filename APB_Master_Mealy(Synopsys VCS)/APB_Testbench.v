module apb_ms_tb();
reg pCLK,pRESETn,pWRITE,pTRANSFER;
reg [31:0]pWDATA;
reg [31:0]pADDR;
reg [3:0]pSTROBE; 
wire pREADY;
wire [31:0]pRDATA;
APB_ms dut(pCLK,pRESETn,pWRITE,pTRANSFER,pWDATA,pADDR,pSTROBE,pREADY,pRDATA);
always #20 pCLK = ~pCLK;
initial
begin
	pCLK = 1'b0;
	pRESETn = 1'b0;
	#9;
	repeat(5)@(posedge pCLK);
	pRESETn = 1'b1;
	#9;
	repeat(5) @(posedge pCLK);
	write();
	repeat(5) @(posedge pCLK);
	read();
	#600;
	$finish();
end

task write();
	begin
	pTRANSFER = 1'b1;
	pWRITE = 1'b1;
	pSTROBE =4'b1111;	
	pADDR = 'd20;
	pWDATA = 32'd765432;
end
endtask
task read();
	begin
		pTRANSFER = 1'b1;
		pWRITE = 1'b0;
		pADDR = 'd20;
	end


endtask
initial
begin
	$fsdbDumpfile("RTL.fsdb");
	$fsdbDumpvars();

end
endmodule



