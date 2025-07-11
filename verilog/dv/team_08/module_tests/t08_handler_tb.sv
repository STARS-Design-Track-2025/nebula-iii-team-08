`timescale 1ms/10ps
module t08_handler_tb;
logic [31:0] rs1=0,  mem=0, mem_address=0;
logic write=0, read=0, clk=0, nrst=0, writeout, readout;
logic [2:0] func3=0;
logic [31:0] data_reg,  data_mem, addressnew;

task tfr;
   nrst = 1; #1;
   nrst = 0; #1;
endtask
    
always #1 clk = ~clk;

t08_handler blockhandle(.readout(readout), .writeout(writeout), .rs1(rs1), .mem(mem), .mem_address(mem_address), .write(write), .read(read), .clk(clk),.nrst(nrst), .func3(func3), .data_reg(data_reg), . data_mem(data_mem), .addressnew(addressnew));

initial begin
    $dumpfile("waves/t08_handler.vcd"); 
    $dumpvars(0, t08_handler_tb);
    
    tfr; #1;
    rs1 = {1'b0,{31{1'b1}}};

    mem_address = 12;
    write = 1;
    for (integer i = 0; i <= 2; i++) begin
        func3 = i;
        #5;end
    #10;

    write = 0;
    read = 1;
    mem = {1'b0,{31{1'b1}}};
    for (integer j = 0; j <= 5; j++) begin
        if (j == 3) begin j = 4; end
            func3 = j;
        #5; end
    #10;

    mem = {1'b1,{31{1'b1}}};
    for (integer k = 0; k <= 5; k++) begin
        if (k == 3) begin k = 4; end
           func3 = k;
        #5; end
    #10;


    #5; $finish;
    end
endmodule


