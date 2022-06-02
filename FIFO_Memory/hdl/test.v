//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
//Proiect     : Limbaje de descriere hardware
//Autor       : El-Naser Majed
//Data        : 23.05.2022
//Tema        : Memorie FIFO
//------------------------------------------------------------------------------
// Descriere   : Mediu de testare
//------------------------------------------------------------------------------


module test();

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;

wire                     rst_n;
wire                     clk;
wire                     push;
wire                     pop;
wire [DATA_WIDTH -1 : 0] data_in;
wire [DATA_WIDTH -1 : 0] data_out;
wire                     empty; 
wire                     full;  
wire [DATA_WIDTH -1 : 0] fifo_counter; 

wire [ADDR_WIDTH -1 : 0] tail; 
wire [ADDR_WIDTH -1 : 0] head; 


//instantierea DUT-ului
fifo #(DATA_WIDTH, ADDR_WIDTH) DUT 
(
.rst_n         (rst_n         ),
.clk           (clk           ),
.push          (push          ),
.pop           (pop           ),
.data_in       (data_in       ),
.data_out      (data_out      ),
.empty         (empty         ),
.full          (full          ),
.fifo_counter  (fifo_counter  )
);


//instantierea TB-ului(a generatorului de stimuli)
fifo_tb #(DATA_WIDTH) TB
(
.rst_n         (rst_n         ),
.clk           (clk           ),
.push          (push          ),
.pop           (pop           ),
.data_in       (data_in       )
);
endmodule