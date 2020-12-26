// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
module tb;
  reg[7:0] ip;
  reg wr, rd, clk, rst;
  wire empty, full;
  wire[4:0] cnt;
  wire[7:0] op;
  
  fifo Fifo(
    ip,
    wr,rd,clk,rst,
    op,
    empty, full,
    cnt
  );
  
  integer i;
  
  always #10 clk <= ~clk;
  
  initial
    begin
      
      $monitor("Time = %0t clk = %0d ip = %0d wr = %0d rd = %0d rst = %0d op = %0d empty = %0d full = %0d cnt = %0d", $time, clk, ip, wr, rd, rst, op, empty, full, cnt);
      clk = 1'b1;
      rst = 1'b1;

      #20;
      rst = 1'b0;
      #10;
      wr = 1'b1;
      ip = 8'b00010001;
      rd = 1'b0;

      #20;
      wr = 1'b1;
      ip = 8'b00000110;
      rd = 1'b0;
      
      #20;
      wr = 1'b1;
      ip = 8'b01000011;
      rd = 1'b0;

      #20;
      wr = 1'b1;
      ip = 8'b00010100;
      rd = 1'b0;

      #20;
      wr = 1'b0;
      rd = 1'b1;

      #20;
      wr = 1'b0;
      rd = 1'b1;

      $finish;      
    end 
endmodule