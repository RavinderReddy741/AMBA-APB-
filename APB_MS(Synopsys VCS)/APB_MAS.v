
module Master(input pTRANSFER,pCLK,pRESET,pWRITE_I,pREADY,pSLAVE_ERROR,input [3:0]pSTROBE_I,input [31:0]pWDATA_I,input [31:0]pRDATA,input [6:0]pADDR_I,output reg pSELx,pENABLE,pWRITE,pSLAVE_ERROR_out,output reg [3:0]pSTROBE,output reg [31:0]pWDATA,output reg [6:0]pADDR);

parameter [1:0] IDLE = 2'b00;
parameter [1:0]SETUP = 2'b01;
parameter [1:0]ACCESS = 2'b10;

reg [1:0] state,next_state;

always @(posedge pCLK ,negedge pRESET)
begin
	if(!pRESET)
	begin
		state<=IDLE;
	end
	else
	begin
		state <=next_state;
	end
end

always @(*)
begin
	case(state)
	IDLE:
		begin
			pSELx = 1'b0;
			pENABLE = 1'b0;
			if(pTRANSFER)
			begin
				next_state=SETUP;
			end
			else
			begin
				next_state = IDLE;
				pSELx = 1'b0;
				pENABLE = 1'b0;
				
			end
		end
	SETUP:
		begin
			pSELx = 1'b1;
			pENABLE = 1'b0;
			pWRITE = pWRITE_I;
			pWDATA = pWDATA_I;
			pADDR = pADDR_I;
			pSTROBE = pSTROBE_I;

			next_state=ACCESS;
		end
	ACCESS:
		begin
			pSELx = 1'b1;
			pENABLE = 1'b1;	
			pSLAVE_ERROR_out = pSLAVE_ERROR;
			if(pTRANSFER==1'b1 && pREADY==1'b1)
			begin
				next_state=SETUP;
			end
			else if(pTRANSFER == 1'b0 && pREADY == 1'b1)
			begin
				next_state=IDLE;
			end
			else
			begin
				next_state = ACCESS;
			end
		end
		default:next_state = IDLE;
		endcase
	end
endmodule

