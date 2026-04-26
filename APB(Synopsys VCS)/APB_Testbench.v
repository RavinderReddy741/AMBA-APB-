//APB Slave's Testbench where it acts as Master.
//It is not having the wait states 
`define WIDTHADDR 32
`define WIDTHDATA 32
module tb();
//signals
reg pCLK,pRESET,pSELx,pENABLE;
reg [2:0]pNUM;
reg [`WIDTHADDR-1:0]pADDR;
reg [`WIDTHDATA-1:0]pWDATA;
reg pWRITE;
reg [3:0]pSTROBE;
wire pREADY;
wire [`WIDTHDATA-1:0]pRDATA;
//connectivity of the testbench and Design
apb dut( pCLK,pRESET,pSELx,pENABLE,pNUM,pADDR,pWDATA,pWRITE,pSTROBE,pREADY,pRDATA);
//assign pSELx_w = #2 pSELx;

initial
begin
	pCLK = 1'b0;
	pRESET =  1'b0;//reseting the system for getting started
	#10;
	pRESET = 1'b1;//starting the system
	#10;
	write();
	#110;
	read();
	#110;
	$finish();
	
end

task write();
	begin
	pSELx = 1'b0;//IDLE state
	#10;		 
	pADDR = 32'd30;//SETUP state
	pWRITE = 1'b1;
	pWDATA = 32'd42;
	pSELx = 1'b1;
	pSTROBE = 4'b1111;
	pENABLE = 1'b0;
	pNUM = 3'd2; 
	repeat(2) @(posedge pCLK);//ACCESS State
	pENABLE = 1'b1;
	end
endtask

task read();
	begin
//	pSELx = 1'b0;
	pNUM = 3'd3;
	#56;
	pSELx = 1'b1;
	pENABLE = 1'b0;
	pWRITE = 1'b0;
	#50;
	pENABLE = 1'b1;
	end
endtask
//clock generation
always #10 pCLK = ~pCLK;
//fsdb for waveform generation
initial
begin
	$fsdbDumpfile("RTL.fsdb");
	$fsdbDumpvars();

end
endmodule

