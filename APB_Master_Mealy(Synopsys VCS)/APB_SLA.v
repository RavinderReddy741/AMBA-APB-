module APB_slave(input pCLK,pRESETn,pSELX,pENABLE,input pWRITE,input [3:0]pSTROBE,input [31:0]pWDATA,input [31:0]pADDR,output reg [31:0]pRDATA,output reg pREADY);

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
		pREADY<=1'b0;
	end
	else
		state<=next_state;
end

always@(*)
begin
	case(state)
		IDLE:begin
			if(pSELX==1'b1 && pENABLE == 1'b0)
				next_state=SETUP;
			else
				next_state=IDLE;
			end
		SETUP:begin
			if(pSELX ==1'b1 && pENABLE == 1'b1)
			begin
			if(pWRITE ==1'b1)
				begin
				if(pSTROBE[0]==1'b1)
					memory[pADDR][7:0] = pWDATA[7:0];
				if(pSTROBE[1] ==1'b1)
					memory[pADDR][15:8] = pWDATA[15:8];
				if(pSTROBE[2] ==1'b1)
					memory[pADDR][23:16] = pWDATA[23:16];
				if(pSTROBE[3] ==1'b1)
					memory[pADDR][31:24] = pWDATA[31:24];
				end
			else if(pWRITE == 1'b0)
				begin
				pRDATA = memory[pADDR];
				end
			next_state=ACCESS;
			pREADY= 1'b1;	
			end
			else if(pSELX == 1'b1 && pENABLE ==1'b0)
				next_state = SETUP;
			else 
				next_state =IDLE;
		       end
		ACCESS:begin
			if(pSELX == 1'b1 && pENABLE == 1'b0)
			begin
				next_state=SETUP;
			end
			else if(pSELX ==1'b0)
			begin
				next_state=IDLE;
			end
			else if(pREADY==1'b0)
			begin
				next_state=ACCESS;
			end
		end
		default : next_state = IDLE;
	endcase
	end

endmodule			
