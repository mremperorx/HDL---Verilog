module DW03_bictr_genertator_semnal #(parameter WIDTH = 8)
(
input        clk,
input        reset,
output    reg   load,
output    reg    cen,
output    reg      up_dn,
output    reg [WIDTH-1 : 0] data,
output    reg   [WIDTH-1 : 0] count_to
);

initial
 begin
            
            load <= 1'b1;
            cen <=1'b0;
            up_dn <=1'b1;
            data <= 8'b0;
			count_to = 'd4;
            @(posedge clk);
			load <= 1'b0;
            repeat(3) @(posedge clk);
			load <= 1'b1;
			repeat(2) @(posedge clk);
			cen <= 1'b1;
			repeat(14) @(posedge clk);
			$stop;
            
end

endmodule