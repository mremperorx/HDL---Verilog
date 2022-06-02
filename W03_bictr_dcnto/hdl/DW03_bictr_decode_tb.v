module DW03_bictr_dcnto_tb #(parameter WIDTH = 8);
 
 
 wire					 clk;
 wire					 reset;
 wire                    load;
 wire                    cen;
 wire                    up_dn;
 wire					 [WIDTH-1 : 0] data;
 wire                    tercnt;
 wire                    [WIDTH-1 : 0] count; 
 wire                    [WIDTH-1 : 0] count_to;
 


DW03_bictr_dcnto i_DUT (
          .clk            (clk), 
          .reset          (reset),
          .load           (load),
          .cen            (cen),
          .up_dn          (up_dn), 
          .data           (data),
          .tercnt         (tercnt), 
          .count          (count),
		  .count_to       (count_to)
);

ck_rst_tb #(.CK_SEMIPERIOD ('d10))
 i_ck_rst_tb(
.clk    (clk  ),
.reset  (reset)
);
DW03_bictr_genertator_semnal i_DW03_bictr_genertator_semnal(
         .clk            (clk), 
          .reset          (reset),
          .load           (load),
          .cen            (cen),
          .up_dn          (up_dn), 
          .data           (data),
		  .count_to       (count_to)
		  );
       

endmodule