`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 23:36:42
// Design Name: 
// Module Name: APB_Tb
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


module APB_Tb();
reg tbclk,tbrst,tbtransfer,tbwr_en;
reg [31:0]tbwrite_data,tbaddress;
wire [31:0]tbread_data;
wire tbready;
APB_MASTER_SLAVE dut(tbclk,tbrst,tbwr_en,tbtransfer,tbaddress,
tbwrite_data,tbread_data,tbready);
initial
begin
tbclk = 1'b0;
//tbrst = 1'b1;
//#10;
tbrst = 1'b0;
#10;
tbrst = 1'b1;
end

always #10 tbclk = ~tbclk;

initial
begin
tbtransfer = 1;
tbwr_en = 1;
tbaddress = 23;
tbwrite_data = 47;
wait(tbready == 1);
$display($time," Write to memory completed at address %0d with data %0d", tbaddress, tbwrite_data);
@(negedge tbclk)
tbwr_en = 0;
tbaddress = 23;
tbtransfer = 1;
repeat(5)@(negedge tbclk);
//wait(tbready == 1);
$display($time ," Data in memory of address %0d is %0d",tbaddress,tbread_data);

end
initial
begin
#500;
$finish;
end
endmodule
