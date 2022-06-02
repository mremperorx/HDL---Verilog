//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
//Proiect     : Limbaje de descriere hardware
//Autor       : El-Naser Majed
//Data        : 23.05.2022
//Tema        : Memorie FIFO
//------------------------------------------------------------------------------
// Descriere   : Generator de date pentru modulul fifo
//------------------------------------------------------------------------------

module fifo_tb
#(
parameter DATA_WIDTH = 8
)(
output reg                     rst_n,
output reg                     clk,
output reg                     push,		//scriere in fifo
output reg                     pop,			//citire din fifo
output reg [DATA_WIDTH -1 : 0] data_in
); 

wire [DATA_WIDTH -1 : 0] data_out;
wire                     empty; 
wire                     full;  
wire [DATA_WIDTH -1 : 0] fifo_counter; 

always #8 clk <= ~clk;  	

initial begin 

rst_n    <= 1;			//resetul ia valoarea 1
clk      <= 0;			//clockul incepe din 0
push     <= 0;			
pop      <= 0;
data_in  <= 8'd0;		//data de intrare va fi 8 biti de 0

#40						//dupa 40ns
rst_n    <= 0;			//resetul ia valoarea 0
push     <= 1;			//push ia valoarea 1(incepe scrierea in fifo)
data_in  <= 8'd0;		//data de intrare va fi 8 biti de 0
#24;					//dupa 24ns
data_in  <= 8'd1;		//data de intrare va fi valoarea 1 pe 8 biti(00000001)
#24;					//dupa 24ns
data_in  <= 8'd2;		//data de intrare va fi valoarea 2 pe 8 biti(00000010)
#24;					//dupa 24ns
data_in  <= 8'd3;		//data de intrare va fi valoarea 3 pe 8 biti(00000011)
#24;					//dupa 24ns
data_in  <= 8'd4;		//data de intrare va fi valoarea 4 pe 8 biti(00000100)
#24;					//dupa 24ns
push     <= 0;			//push ia valoarea 0 (se opreste scrierea in fifo)
pop      <= 1; 			//pop ia valoarea 1 (incepe citirea din fifo)
end

endmodule