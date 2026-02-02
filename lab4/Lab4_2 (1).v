`timescale 1ns / 1ps

module TransportationSystem(
    input [1:0] mode,         // Modes: 00 for Registration, 01 for Check-In, 10 for Search
    input [1:0] method,       // Transportation method (Bus, Train, Airplane, High-Speed Train)
	 input [3:0] seatNumber,   // 4-bit seat number (0000 to 1111)
    input CLK,                // Clock signal
    output reg [1:0] selectedMethod, // Shows user-selected method
    output reg [5:0] seatLeft,        // Number of available seats in the selected method
    output reg registered,            // Indicates if a passenger is registered
    output reg checkInStatus,         // Indicates if a passenger has checked in
    output reg alreadyRegistered,     // Indicates if a passenger is already registered
    output reg notRegistered,         // Indicates if a passenger is not registered
    output reg seatUnavailable,       // Indicates if the selected seat is unavailable
    output reg alreadyCheckedIn       // Indicates if a passenger has already checked in
);
	reg [1:0] bus [0:15];
    reg [1:0] train [0:14];
    reg [1:0] plane [0:14];
    reg [1:0] highTrain [0:15];

    reg [5:0] busSeat;
    reg [5:0] trainSeat;
    reg [5:0] planeSeat;
    reg [5:0] highTrainSeat;

    integer i;
    initial
        begin 
            for (i = 0; i < 16; i = i + 1)
                begin
                    bus[i] = 2'b00;
                end
            for (i = 0; i < 15; i = i + 1)
                begin
                    train[i] = 2'b00;
                end
            for (i = 0; i < 15; i = i + 1)
                begin
                    plane[i] = 2'b00;
                end
            for (i = 0; i < 16; i = i + 1)
                begin
                    highTrain[i] = 2'b00;
                end

            busSeat = 5'd16;
            trainSeat = 5'd15;
            planeSeat = 5'd15;
            highTrainSeat = 5'd16;

        end
    
    always @(posedge CLK) 
        begin
            registered = 0;
            checkInStatus = 0;
            alreadyRegistered = 0;
            notRegistered = 0;
            seatUnavailable = 0;
            alreadyCheckedIn = 0;
            selectedMethod = method;
            
            case (method)
                2'b00:
                    begin
                        seatLeft = busSeat;
                        case (mode)
                            2'b00:
                                begin
                                    if(busSeat == 0)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(bus[seatNumber] != 0)
                                        begin
                                            alreadyRegistered = 1;
                                            seatLeft = busSeat;
                                        end
                                    else
                                        begin
                                            bus[seatNumber] = 1;
                                            busSeat = busSeat -1;
                                            registered = 1;
                                            seatLeft = busSeat;
                                        end
                                end
                            2'b01:
                                begin
                                    if(bus[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if (bus[seatNumber] == 2)
                                        begin
                                            alreadyCheckedIn = 1;
                                        end
                                    else
                                        begin
                                            bus[seatNumber] = 2;
                                            checkInStatus = 1;
                                        end
                                end
                            2'b10:
                                begin
                                    if(bus[seatNumber] == 1)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                    else if(bus[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if(bus[seatNumber] == 2)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                end
                        endcase
                    end
                2'b01:
                    begin
                        seatLeft = trainSeat;
                        case (mode)
                            2'b00:
                                begin
                                    if(trainSeat == 0)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if (seatNumber == 15)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(train[seatNumber] != 0)
                                        begin
                                            alreadyRegistered = 1;
                                            seatLeft = trainSeat;
                                        end
                                    else
                                        begin
                                            train[seatNumber] = 1;
                                            trainSeat = trainSeat -1;
                                            registered = 1;
                                            seatLeft = trainSeat;
                                        end
                                end
                            2'b01:
                                begin
                                    if (seatNumber == 15)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(train[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if (train[seatNumber] == 2)
                                        begin
                                            alreadyCheckedIn = 1;
                                        end
                                    else
                                        begin
                                            train[seatNumber] = 2;
                                            checkInStatus = 1;
                                        end
                                end
                            2'b10:
                                begin
                                    if (seatNumber == 15)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(train[seatNumber] == 1)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                    else if(train[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if(train[seatNumber] == 2)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                end
                        endcase
                    end
                2'b11:
                    begin
                        seatLeft = planeSeat;
                        case (mode)
                            2'b00:
                                begin
                                    if(planeSeat == 0)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if (seatNumber == 15)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(plane[seatNumber] != 0)
                                        begin
                                            alreadyRegistered = 1;
                                            seatLeft = planeSeat;
                                        end
                                    else
                                        begin
                                            plane[seatNumber] = 1;
                                            planeSeat = planeSeat -1;
                                            registered = 1;
                                            seatLeft = planeSeat;
                                        end
                                end
                            2'b01:
                                begin
                                    if (seatNumber == 15)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(plane[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if (plane[seatNumber] == 2)
                                        begin
                                            alreadyCheckedIn = 1;
                                        end
                                    else
                                        begin
                                            plane[seatNumber] = 2;
                                            checkInStatus = 1;
                                        end
                                end
                            2'b10:
                                begin
                                    if (seatNumber == 15)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(plane[seatNumber] == 1)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                    else if(plane[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if(plane[seatNumber] == 2)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                end
                        endcase
                    end
                2'b10:
                    begin
                        seatLeft = highTrainSeat;
                        case (mode)
                            2'b00:
                                begin
                                    if(highTrainSeat == 0)
                                        begin
                                            seatUnavailable = 1;
                                        end
                                    else if(highTrain[seatNumber] != 0)
                                        begin
                                            alreadyRegistered = 1;
                                            seatLeft = highTrainSeat;
                                        end
                                    else
                                        begin
                                            highTrain[seatNumber] = 1;
                                            highTrainSeat = highTrainSeat -1;
                                            registered = 1;
                                            seatLeft = highTrainSeat;
                                        end
                                end
                            2'b01:
                                begin
                                    if(highTrain[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if (highTrain[seatNumber] == 2)
                                        begin
                                            alreadyCheckedIn = 1;
                                        end
                                    else
                                        begin
                                            highTrain[seatNumber] = 2;
                                            checkInStatus = 1;
                                        end
                                end
                            2'b10:
                                begin
                                    if(highTrain[seatNumber] == 1)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                    else if(highTrain[seatNumber] == 0)
                                        begin
                                            notRegistered = 1;
                                        end
                                    else if(highTrain[seatNumber] == 2)
                                        begin
                                            alreadyRegistered = 1;
                                        end
                                end
                        endcase
                    end
            endcase
        end
    
endmodule
