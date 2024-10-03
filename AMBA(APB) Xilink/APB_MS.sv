`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2024 22:02:09
// Design Name: 
// Module Name: APB_MSp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module APB_MS(input pclk,prst,pready,ptransfer_m,
pwrite_read_en,input [31:0]paddress_m,
pwdata_m,preaddata,output logic psel,penable,pwr_en,
output logic [31:0]paddress_s,pwrite_s,pread_data_s);
typedef enum{IDLE =0,SETUP = 1,ACCESS = 2}state;
state pstate,nextstate;
always @(posedge pclk,negedge prst)
begin
if(!prst)
begin
pstate<=IDLE;
end
else
begin
pstate<=nextstate;
end
end
////////////////////////////////////////////////////////////////////////////////////
always@(*)
begin
case(pstate)
IDLE:begin
    if(ptransfer_m)
    begin
    nextstate<=SETUP;
    end
    else
    begin
    nextstate<=IDLE;
    end
        end
SETUP:begin
      nextstate<=ACCESS;
      end
ACCESS:begin
    if(pready && ptransfer_m)
    nextstate<=SETUP;
    else if(pready && !ptransfer_m)
    nextstate<= IDLE;
    else
    nextstate<=ACCESS;
  end
  default:nextstate<=IDLE;
endcase
end

//////////////////////////////////////////////////////////////////
always @(posedge pclk , negedge prst)
begin
if(!prst)
begin
paddress_s<= 32'b0;
psel<=1'b0;
penable<=1'b0;
pwrite_s<=32'b0;
pwr_en <= 1'b1;
//pread_data_s <= 32'b0;
end
else 
begin
case(pstate)
IDLE:begin
    psel<=1'b0;
    penable<=1'b0;
    end
SETUP:begin
    psel<=1;
    penable<=0;
    pwrite_s<=pwdata_m;
    paddress_s<=paddress_m;
    pwr_en<= pwrite_read_en;
    end
ACCESS:begin
penable<=1;
psel<=1;
if(!pwrite_read_en && pready)
begin
   pread_data_s<=preaddata;
end
else if(pwrite_read_en && pready)
    pread_data_s <= 32'b0;   
end
default: begin
                // Define default state behavior here
                psel <= 1'b0;
                penable <= 1'b0;
                paddress_s <= 32'b0;
                pwrite_s <= 32'b0;
                pwr_en <= 1'b1;
                pread_data_s <= 32'b0; // Clear or retain as per your logic
            end
endcase
end
end
endmodule

///////////////////////////////////////////////////////////////////

module slave(input pclk,prst,prw_en,penable,psel,
input[31:0]paddress,pwdata,output logic pready,
output logic [31:0]preaddata);

reg [31:0]mem[32];
always@(posedge pclk,negedge prst)
  begin
     if(!prst)
       begin
        pready<=1'b0;
        preaddata<=1'b0;
        for(integer i =0;i<32;i = i+1)
            begin
              mem[i]<=32'b0;
            end
        end
     else
        begin
        if(psel && penable)
        begin
           if(prw_en)
                begin
                    pready <= 1'b1;
                  mem[paddress] <= pwdata;
                  
                end
            else
                begin
                pready<=1'b1;
                    preaddata<= mem[paddress];
                    
                end
        end
        else
             pready<=1'b0;
        end 
end
endmodule

////////////////////////////////////////////////////////////////////

module APB_MASTER_SLAVE(input logic msclk,msrst,msrw_en,
mstransfer,input logic [31:0]msaddress,mswdata,
output logic[31:0]msread_out,output logic msready);

logic [31:0]mid_address,mid_w_data,mid_r_data;
logic mid_enable,mid_sel,mid_ready,mid_wr_en;

APB_MS master(msclk,msrst,msready,mstransfer,msrw_en,msaddress,
mswdata,msread_out,mid_sel,mid_enable,mid_wr_en,mid_address,
mid_w_data,mid_r_data);


slave slave1(msclk,msrst,mid_wr_en,mid_enable,mid_sel,mid_address,
mid_w_data,msready,msread_out);


endmodule



 
