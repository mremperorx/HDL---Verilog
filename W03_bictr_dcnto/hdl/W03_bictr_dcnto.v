//---------------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Proiect     : Limbaje de descriere hardware
// Autor       : <El-Naser Majed>
// Data        : <11.4.2021>
//---------------------------------------------------------------------------------------
// Descriere   : <Up/Down Binary Counter with Dynamic count-to Flag>
//---------------------------------------------------------------------------------------
module DW03_bictr_dcnto #(parameter WIDTH = 8)
(
          
		   input [WIDTH-1 : 0] data,
           input [WIDTH-1 : 0] count_to, 
           input up_dn,  
           input load,  
           input cen, 
           input clk,  
           input reset, 
           output reg [WIDTH-1 : 0] count, 
           output tercnt  		   
);  

 


     always @(posedge(clk) or negedge(reset)) begin
        if(~reset) 
        count <=  1'b0;
		else if(~load) 
        count <=  4'b0000;
        else if (~cen)
        count <= count;
        else if (~up_dn)
		count <= count-1;
		else count <= count+1;
     end  
	  assign tercnt=(count == count_to)?  1'b1:
										  1'b0;

	 
endmodule