module apb_ms_tb();
reg pCLK,pRESETn,pWRITE,pTRANSFER;
reg [31:0]pWDATA;
reg [6:0]pADDR;
reg [3:0]pSTROBE; 
wire pREADY;
wire [31:0]pRDATA;
integer i,j;
APB_ms dut(pCLK,pRESETn,pWRITE,pTRANSFER,pWDATA,pADDR,pSTROBE,pREADY,pRDATA,pSLAVE_ERROR);
always #20 pCLK = ~pCLK;
initial
begin
	pCLK = 1'b0;
	pRESETn = 1'b0;
	pTRANSFER = 1'b0;
	#39;
	repeat(5)@(posedge pCLK);
	pRESETn = 1'b1;
	#9;
	pRESETn = 1'b0;
	pTRANSFER = 1'b0;
	#9;
	pRESETn = 1'b1;

	repeat(5) @(posedge pCLK);
	#1;
	write();
	repeat(5) @(posedge pCLK);
for(i =0;i<=127;i= i+1)
begin
	for(j= 0;j<=15;j = j+1)
		begin
			pADDR = i;
			pSTROBE = j;
			pWDATA = $random();
			@(posedge pCLK);
		end
end 

repeat(4)@(posedge pCLK)

	for(i =0;i<=127;i= i+1)
		begin
			pADDR = i;
			pSTROBE = 4'b1111;
			pWDATA = $random();
			@(posedge pCLK);
		end

repeat(4)@(posedge pCLK)

	for(i = 0;i<=127;i=i+1)
		begin
			pADDR = i;
			read();
			@(posedge pCLK); 
		end

	read();

repeat(4)@(posedge pCLK);
	pTRANSFER = 1'b0;
repeat(4)@(posedge pCLK);
pTRANSFER = 1'b1;
pWRITE = 1'b1;
pADDR = 7'd21;
pSTROBE = 4'b1111;
pWDATA = 32'b11111111_11111111_11111111_11111111;
repeat(4)@(posedge pCLK);
pTRANSFER = 1'b1;
pWRITE = 1'b1;
pADDR = 7'd20;
pSTROBE = 4'b1111;
pWDATA = 32'b00000000_00000000_00000000_00000000;
repeat(2)@(posedge pCLK);
pWRITE = 1'b0;
pADDR = 7'd21;

repeat(2)@(posedge pCLK);
pWRITE = 1'b0;
pADDR = 7'd20;


repeat(4)@(posedge pCLK);
pTRANSFER = 1'b1;
pWRITE = 1'b1;
pADDR = 7'd21;
pSTROBE = 4'b1111;
pWDATA = 32'b11111111_11111111_11111111_11111111;


repeat(2)@(posedge pCLK);
pWRITE = 1'b0;
pADDR = 7'd21;

repeat(2)@(posedge pCLK);
pWRITE = 1'b0;
pADDR = 7'd20;

repeat(2)@(posedge pCLK);
pTRANSFER = 1'b1;
pWRITE = 1'b1;
pADDR = 7'd4;
pSTROBE = 4'b1111;
pWDATA = 32'b11111111_11111111_11111111_11111111;
repeat(2)@(posedge pCLK);
pWRITE = 1'b0;
pADDR = 7'd4;
repeat(4)@(posedge pCLK);
pTRANSFER = 1'b1;
pWRITE = 1'b1;
pADDR = 7'd8;
pSTROBE = 4'b1111;
pWDATA = 32'b00000000_00000000_00000000_00000000;
repeat(2)@(posedge pCLK);
pWRITE = 1'b0;
pADDR = 7'd4;
repeat(4)@(posedge pCLK);
pRESETn = 1'b0;

repeat(3)@(posedge pCLK);
	pRESETn = 1'b1;
	pTRANSFER = 1'b1;
repeat(4)@(posedge pCLK);
pRESETn = 1'b0;
repeat(9)@(posedge pCLK);
pRESETn = 1'b1;
pTRANSFER = 1'b0;
@(posedge pCLK);
pTRANSFER = 1'b1;
@(posedge pCLK);
pTRANSFER = 1'b0;
pWRITE = 1'b0;
pADDR = 7'd4;



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



