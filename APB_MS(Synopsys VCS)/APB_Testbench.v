module apb_ms_tb();
reg pCLK,pRESETn,pWRITE,pTRANSFER;
reg [31:0]pWDATA;
reg [6:0]pADDR;
reg [3:0]pSTROBE; 
wire pREADY,pSLAVE_ERROR;
wire [31:0]pRDATA;
integer i,j;
APB_ms dut(pCLK,pRESETn,pWRITE,pTRANSFER,pWDATA,pADDR,pSTROBE,pREADY,pSLAVE_ERROR,pRDATA);
always #20 pCLK = ~pCLK;
initial
begin
pCLK = 1'b0;
pRESETn = 1'b0;
@(posedge pCLK);
pRESETn = 1'b1;
repeat(3)@(posedge pCLK);
write();

for(i = 0;i<=127;i = i+1)
begin
pSTROBE = 4'b1111;
pADDR = i;
pWDATA = $random();
repeat(3)@(posedge pCLK);
end
repeat(3)@(posedge pCLK);
read();
for(i = 0;i<=31;i=i+1)
begin
pADDR =i;
repeat(3)@(posedge pCLK);
end
#100;
$finish();
end
task write();
	begin
	pTRANSFER = 1'b1;
	pWRITE = 1'b1;
	end
endtask
task read();
	begin
		#5;
		pTRANSFER = 1'b1;
		pWRITE = 1'b0;
	end


endtask
initial
begin
	$fsdbDumpfile("RTL.fsdb");
	$fsdbDumpvars();

end
endmodule



