/*  AMBA APB PROTOCOL (ADVANCE MICROCONTROLLER BUS ARCHITECTURE ) (ADVANCE
*  PERPHERILA BUS)(APB SLAVE)
*  Here the below code describe then AMBA APB slave .It is on chip bus
*  protocol .
        INPUT SIGNALS:
	*  	pCLK    : pCLK is a clock signal. All APB signals are
                         	timed against the rising edge of PCLK. 
        *	pRESETn : pRESETn is the reset signal and is active-LOW.
				PRESETn is normally connected directly to the
				system bus reset signal.
        * 	pADDR   : pADDR is the APB address bus. pADDR can be
				up to 32 bits wide. 
	*  	pSELx	: The Requester generates a pSELx signal for each
				Completer. pSELx indicates that the Completer is
				selected and that a data transfer is required
	* 	pENABLE : It indicates the second and subsequent
				cycles of an APB transfer.
	* 	pWRITE  : Direction.
				pWRITE indicates an APB write access when
				HIGH and an APB read access when LOW.
	* 	pWDATA  : The pWDATA write data bus is driven by the
				APB bridge Requester during write cycles when
				pWRITE is HIGH.
				pWDATA can be 8 bits, 16 bits, or 32 bits wide.
	* 	pSTRB	: It  indicates which byte lanes to update
				during a write transfer. There is one write strobe
				for each 8 bits of the write data bus. pSTRB[n]
				corresponds to pWDATA[(8n + 7):(8n)].
				pSTRB must not be active during a read transfer.
	OUTPUT SIGNALS:
	*	pREADY  : It is used to extend an APB transfer by
				the Completer.
	*	pRDATA 	: The pRDATA read data bus is driven by the
				selected Completer during read cycles when
				pWRITE is LOW.
				pRDATA can be 8 bits, 16 bits, or 32 bits wide.

	FUNCTIONALITY:

	*  It has three states  
*  		IDLE(pSELx =0)---transfer----> SETUP(pSELx=1,pENABLE = 0) ----> ACCESS(psel
*  		=1,pENABLE =1) if(transfer) 
*  			moves to SETUP 
*  		  else if(!pREADY)
*  		     stay in same state;
*  		  else if(pREADY==1 && !transfer)
*  		  	moves to IDLE
*
*
*/

//`define is used to define the width of data and address bus
//Design module of APB with inputs and outputs
`define  WIDTHADDR 32
`define  WIDTHDATA 32

module apb(input pCLK,pRESET,pSELx,pENABLE,input [2:0]pNUM,
	input [`WIDTHADDR -1:0]pADDR,
	input [`WIDTHDATA-1:0]pWDATA,
	input pWRITE,
	input [3:0]pSTROBE,
	output reg pREADY,output reg [`WIDTHDATA-1:0]pRDATA);
//memory 
reg [`WIDTHDATA-1:0] memory [`WIDTHADDR -1:0];
// States
parameter IDLE = 2'b00;
parameter SETUP = 2'b01;
parameter ACCESS = 2'b10;
//Used for representation of the states.
reg [1:0] state;
reg [1:0] next_state;
//always block for the state transitions with respective to the pclk,preset
always @(posedge pCLK,negedge pRESET)
begin
	if(!pRESET)
	begin
		state<=IDLE;
	end
	else
		state<=next_state;
end
//always block for the inputs
always @(*)
begin
	case(state)
		IDLE: begin
			if(pSELx==1'b1 && pENABLE == 1'b0)
				next_state=SETUP;
			else
				next_state = IDLE;
		       end
		SETUP: begin
			if(pSELx ==1'b1 && pENABLE ==1'b1)
				next_state = ACCESS;
			end
		ACCESS: begin
			if(pSELx ==1'b1 && pENABLE = 1'b1)
			begin
				if(pWRITE == 1'b1)
				begin
						if(pSTROBE[0]==1'b1)
							memory[pADDR][7:0] = pWDATA[7:0];
						if(pSTROBE[1] ==1'b1)
							memory[pADDR][15:8] = pWDATA[15:8];
						if(pSTROBE[2] ==1'b1)
							memory[pADDR][23:16] = pWDATA[23:16];						           if(pSTROBE[3] ==1'b1)
							memory[pADDR][31:24] = pWDATA[31:24];
					pREADY = 1'b1;
				end
				else if(pWRITE == 1'b0)
				begin
					pRDATA = memory[pADDR];
					pREADY = 1'b1;
				end
			end
			if(

				




endmodule


