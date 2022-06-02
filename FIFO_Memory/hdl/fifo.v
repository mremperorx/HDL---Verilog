//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
//Proiect     : Limbaje de descriere hardware
//Autor       : El-Naser Majed
//Data        : 23.05.2022
//Tema        : Memorie FIFO
//------------------------------------------------------------------------------
// Descriere   : Circuit fifo
//------------------------------------------------------------------------------

module fifo 
#(
parameter DATA_WIDTH = 8,						//numarul de biti
parameter ADDR_WIDTH = 4						//lungimea adresei
)(
input                          rst_n,			//reset
input                          clk,				//clock
input                          push,			//variabila pentru scrierea datelor in fifo
input                          pop,				//variabila pentru citirea datelor din fifo
input      [DATA_WIDTH -1 : 0] data_in,			//date de intrare
output reg [DATA_WIDTH -1 : 0] data_out,		//date de iesire
output reg                     empty,
output reg                     full,
output reg [DATA_WIDTH -1 : 0] fifo_counter		//counter fifo
);

reg [ADDR_WIDTH -1 : 0] tail; 					//datele sunt citite din tail
reg [ADDR_WIDTH -1 : 0] head; 					//datele sunt scrise in head
reg [DATA_WIDTH -1 : 0] buf_mem[63:0]; 			//buffer de memorie de 64 de biti


always@(fifo_counter) 
begin
	empty = (fifo_counter == 0 );  				//cand counterul e 0, atunci fifo e empty
	full  = (fifo_counter == 64); 				//cand counterul e 64, atunci fifo e full
end

//setare fifo_counter
always@(posedge clk or posedge rst_n) 
begin
	if (rst_n) 										//daca resetul e activ
		fifo_counter <= 0; 							//resetam counterul la 0
	else if ((!full && push) && (!empty && pop))	//daca citim si scriem in acelasi timp, si fifo nu este nici full dar nici empty
		fifo_counter <= fifo_counter;				//atunci nu trebuie sa dam update counterului, adica isi pastreaza valoarea
	else if (!full && push) 						//daca scriem in fifo, iar acesta nu este full
		fifo_counter <= fifo_counter + 1;			//atunci incrementam counterul cu 1
	else if (!empty && pop) 						//daca citim din fifo si acesta nu e empty
		fifo_counter <= fifo_counter - 1;			//atunci decrementam counterul cu 1
	else
		fifo_counter <= fifo_counter; 				//si daca nicio conditie nu e respectata, atunci counterul isi pastreaza valoarea
end


//citirea din fifo
always@(posedge clk or posedge rst_n) 				//pentru frontul pozitiv de clk sau frontul pozitiv de reset
begin
	if (rst_n)										//daca resetul e activ
		data_out <= 0; 								//datele de iesire se reseteaza la 0
	else begin
		if (pop && !empty) 							//daca citim din fifo si acesta nu e empty
			data_out <= buf_mem[tail]; 				
		else
			data_out <= data_out; 					//datele de iesire isi pastreaza valoarea
	end
end



//scrierea in fifo
always@(posedge clk) 
begin
	if (push && !full) 								//daca scriem in fifo iar acesta nu e full
		buf_mem[head] <= data_in; 
	else
		buf_mem[head] <= buf_mem[head]; 
end


//setare head si tail
always@(posedge clk or posedge rst_n)
begin
	if(rst_n)										//daca resetul este activ
		begin
			head <= 0; 								//head si tail se reseteaza in 0
			tail <= 0; 
		end
	else
		begin
			if(!full && push) 						//daca scriem in fifo si acesta nu este full
				head <= head + 1; 					//incrementam head cu 1
			else
				head <= head;						//head isi pastreaza valoarea
			if(!empty && pop) 						//daca citim din fifo si acesta nu este empty
				tail <= tail + 1; 					//incrementam tail cu 1
			else
				tail <= tail;						//tail isi pastreaza valoarea
		end

end

endmodule
	
