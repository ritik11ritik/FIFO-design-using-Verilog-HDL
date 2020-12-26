// Code your design here
`timescale 1ns / 1ps
module fifo(
  input[7:0] data_in,
  input wr, rd, clk, rst,
  output reg[7:0] data_out,
  output reg empty, full,
  output reg[4:0] cnt
);
  
  reg[7:0] mem[15:0];
  reg[4:0] rd_ptr, wr_ptr;
  
  always @(*)
    begin
      if(rst) 
        begin
          rd_ptr <= 5'b00000;
          wr_ptr <= 5'b00000;
          empty <= 1'b1;
          full <= 1'b0;
          cnt <= 5'b00000;
        end
    end

  always @(negedge clk)
    begin
      if(rd && !empty)
        begin
          data_out = mem[rd_ptr];
          rd_ptr = rd_ptr + 5'b00001;
          cnt = cnt - 5'b00001;
          if (cnt==5'b00000)
            empty = 1'b1;
          else
            empty = 1'b0;
          
          if(cnt==5'b10000)
            full = 1'b1;
          else
            full = 1'b0;
        end
      else if(wr && !full)
        begin
          mem[wr_ptr] = data_in;
          wr_ptr = wr_ptr + 5'b00001;
          cnt = cnt + 5'b00001;
          if(cnt==5'b10000)
            full = 1'b1;
          else
            full = 1'b0;
          
          if (cnt==5'b00000)
            empty = 1'b1;
          else
            empty = 1'b0;
        end
      else
        $display("Error");
    end
endmodule
        