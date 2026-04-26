module APB_slave(input pCLK,pRESETn,pSELX,pENABLE,input pWRITE,input [3:0]pSTROBE,input [31:0]pWDATA,input [6:0]pADDR,output reg [31:0]pRDATA,output reg pREADY,pSLAVE_ERROR);

parameter [1:0]IDLE = 2'b00;
parameter [1:0]SETUP =2'b01;
parameter [1:0]ACCESS = 2'b10;

reg [1:0]state,next_state;

reg [31:0]memory[31:0];


always @(posedge pCLK,negedge pRESETn)
begin
	if(!pRESETn)
	begin
		state<=IDLE;
	end
	else
		state<=next_state;
end

always@(*)
begin
	case(state)
		IDLE:begin
			pREADY=1'b0;
			pSLAVE_ERROR=1'b0;
			if(pSELX==1'b1 && pENABLE == 1'b0)
				next_state=SETUP;
			else
				next_state=IDLE;
			end
		SETUP:begin
			pREADY=1'b0;
			pSLAVE_ERROR = 1'b0;
			if(pSELX ==1'b1 && pENABLE == 1'b1)
				next_state=ACCESS;
			else 
				next_state =IDLE;
		       end
		ACCESS:begin
			if(pSELX == 1'b1 && pENABLE == 1'b1)
			begin	
	                     if(pWRITE == 1'b1)
	                 	begin
	                	if(pADDR[1:0] == 2'b11 && pSTROBE%8 == 1'b0 && pSTROBE != 4'b0000)
	                       	begin 
memory[pADDR[6:2]][31:24] = (pWDATA[31:24] & {8{pSTROBE[3]}})|(memory[pADDR[6:2]][31:24] & {8{~pSTROBE[3]}});
					

				end
				else if(pADDR[1:0] ==2'b10 && pSTROBE%4 ==1'b0 && pSTROBE != 4'b0000)
				begin
					memory[pADDR[6:2]][23:16] = (pWDATA[23:16] & {8{pSTROBE[2]}})|(memory[pADDR[6:2]][23:16] & {8{~pSTROBE[2]}});

					memory[pADDR[6:2]][31:24] = (pWDATA[31:24] & {8{pSTROBE[3]}})|(memory[pADDR[6:2]][31:24] & {8{~pSTROBE[3]}});
				

				end
				else if(pADDR[1:0]==2'b01 && pSTROBE%2 == 1'b0 && pSTROBE != 4'b0000)
				begin
					memory[pADDR[6:2]][15:8] = (pWDATA[15:8] & {8{pSTROBE[1]}})|(memory[pADDR[6:2]][15:8] & {8{~pSTROBE[1]}});

					memory[pADDR[6:2]][23:16] = (pWDATA[23:16] & {8{pSTROBE[2]}})|(memory[pADDR[6:2]][23:16] & {8{~pSTROBE[2]}});

					memory[pADDR[6:2]][31:24] = (pWDATA[31:24] & {8{pSTROBE[3]}})|(memory[pADDR[6:2]][31:24] & {8{~pSTROBE[3]}});
				

				end
				else if(pADDR[1:0]==2'b00)
				begin
				
					memory[pADDR[6:2]][7:0] = (pWDATA[7:0] & {8{pSTROBE[0]}})|(memory[pADDR[6:2]][7:0] & {8{~pSTROBE[0]}});

					memory[pADDR[6:2]][15:8] = (pWDATA[15:8] & {8{pSTROBE[1]}})|(memory[pADDR[6:2]][15:8] & {8{~pSTROBE[1]}});

					memory[pADDR[6:2]][23:16] = (pWDATA[23:16] & {8{pSTROBE[2]}})|(memory[pADDR[6:2]][23:16] & {8{~pSTROBE[2]}});

					memory[pADDR[6:2]][31:24] = (pWDATA[31:24] & {8{pSTROBE[3]}})|(memory[pADDR[6:2]][31:24] & {8{~pSTROBE[3]}});
				
				end
				else 
				begin
					pSLAVE_ERROR = 1'b1;
			     	 end
			 end
			else //if(pWRITE ==1'b0) 
			begin
				pRDATA = memory[pADDR];
			end
			pREADY = 1'b1;
			end
			
			if(pSELX == 1'b1 && pENABLE == 1'b0)
			begin
				next_state=SETUP;
			end
			else if(pSELX == 1'b0)
			begin
				next_state=IDLE;
			end
			else
			begin
				next_state=ACCESS;
			end
		end
		default : next_state = IDLE;
	endcase
end
endmodule	

