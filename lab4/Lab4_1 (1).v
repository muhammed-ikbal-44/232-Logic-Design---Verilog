`timescale 1ns / 1ps

module ROLM (
    input [2:0] addr,
    output reg [7:0] dataOut
);
    // Initialize the ROLM with predefined values
    reg [7:0] data [0:7];
    integer i;
    initial begin
        data[0] = 8'b11011011;
        data[1] = 8'b10101010;
        data[2] = 8'b01111110;
        data[3] = 8'b00001111;
        data[4] = 8'b10011001;
        data[5] = 8'b11100011;
        data[6] = 8'b01010101;
        data[7] = 8'b00110011;
    end

    always @(*)
        begin
            dataOut = data[addr];
        end

endmodule



module IDS (
    input mode,                     // 0 for write, 1 for read
    input [2:0] addr,               // RAM address
    input [1:0] operation,          // Operation code
    input [7:0] dataIn,             // Input data
	 input [7:0] romData,				// Data from ROM used in operations
    input CLK,                      // Clock signal
    output reg [7:0] dataOut        // Output data
);
// Your code here
    reg [7:0] data [0:7];
    integer i;
    initial
        begin 
            for (i = 0; i < 8; i = i + 1)
                begin
                    data[i] = 8'b00000000;
                end
        end

    always @(posedge CLK) 
        begin
            if (mode == 1'b0) 
                begin
                    case (operation)
                        2'b00: data[addr] <= romData + dataIn;
                        2'b01: data[addr] <= dataIn - romData;
                        2'b10: data[addr] <= 8'b00000000;
                        2'b11: data[addr] <= 8'b11111111;
                    endcase
                end
        end

    always @(*) 
        begin
            if (mode == 1'b1)
                dataOut = data[addr];
        end

endmodule


module Incremental_Memory_System (
    input mode,                          // 0 for write, 1 for read
    input [2:0] systemAddr,              // System address
    input [1:0] operation,               // Operation code
    input [7:0] dataIn,                  // System data input
    input CLK,                           // Clock signal
    output [7:0] systemOutput            // System output
);

// Your code here
    wire [7:0] rom_out;

    ROLM rom_instance (
        .addr(systemAddr),
        .dataOut(rom_out)
    );

    IDS ids_instance (
        .mode(mode),
        .addr(systemAddr),
        .operation(operation),
        .dataIn(dataIn),
        .romData(rom_out),
        .CLK(CLK),
        .dataOut(systemOutput)
    );


    
endmodule