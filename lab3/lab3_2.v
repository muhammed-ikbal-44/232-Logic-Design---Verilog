`timescale 1ns / 1ps 
module lab3_2(
    	input [4:0] money,
		input CLK, 
		input [1:0] selectedMethod,  
    	input businessAvailability,
		output reg [4:0] moneyLeft,
		output reg [5:0] seatLeft,
		output reg seatUnavailable,
    	output reg invalidBusinessSeat,
    	output reg selectedSeatUnavailable,
    	output reg insufficientFund,
    	output reg seatReady
	);
	 

	// IMPLEMENT BELOWS
	
	reg [5:0] busNormal;
    reg [5:0] trainNormal;
    reg [5:0] trainBusiness;
    reg [5:0] planeNormal;
    reg [5:0] planeBusiness;

	initial
		begin
			busNormal = 6'd40;
			trainNormal = 6'd30;
			trainBusiness = 6'd20;
			planeNormal = 6'd30;
			planeBusiness = 6'd5;
		end

    always @(posedge CLK)
		begin
			seatUnavailable = 0;
			invalidBusinessSeat = 0;
			selectedSeatUnavailable= 0;
			insufficientFund = 0;
			seatReady = 0;
			moneyLeft = 0;
			seatLeft = 0;

			case (selectedMethod)
				2'b00:
					begin
						if(busNormal == 0)
							begin
								seatUnavailable = 1;
								seatLeft = busNormal;
                                moneyLeft = money;
							end
						else if(businessAvailability)
							begin
								invalidBusinessSeat = 1;
								seatLeft = busNormal;
                                moneyLeft = money;
							end
						else if(money < 5)
							begin
								moneyLeft = money;
								insufficientFund = 1;
                                seatLeft = busNormal;
							end
						else
							begin
								moneyLeft = money - 5;
								busNormal = busNormal - 1;
								seatLeft = busNormal;
								seatReady = 1;
							end
					end
				2'b01:
					begin
						if((trainNormal + trainBusiness) == 0)
							begin
								seatUnavailable = 1;
								seatLeft = trainNormal + trainBusiness;
                                moneyLeft = money;
							end
						else if(businessAvailability)
							begin
								if(trainBusiness == 0)
									begin
										selectedSeatUnavailable = 1;
										seatLeft = trainBusiness;
                                        moneyLeft = money;
									end
								else if(money < 15)
									begin
										moneyLeft = money;
										insufficientFund = 1;
										seatLeft = trainBusiness;
									end
								else
									begin
										trainBusiness = trainBusiness - 1;
										seatLeft = trainBusiness;
										moneyLeft = money - 15;
										seatReady = 1;
									end
							end
						else
							begin
								if(trainNormal == 0)
									begin
										selectedSeatUnavailable = 1;
										seatLeft = trainNormal;
                                        moneyLeft = money;
									end
								else if(money < 10)
									begin
										moneyLeft = money;
										insufficientFund = 1;
										seatLeft = trainNormal;
									end
								else
									begin
										trainNormal = trainNormal - 1;
										seatLeft = trainNormal;
										moneyLeft = money - 10;
										seatReady = 1;
									end
							end
					end
				2'b11:
					begin
						if((planeNormal + planeBusiness) == 0)
							begin
								seatUnavailable = 1;
								seatLeft = planeNormal + planeBusiness;
                                moneyLeft = money;
							end
						else if(businessAvailability)
							begin
								if(planeBusiness == 0)
									begin
										selectedSeatUnavailable = 1;
										seatLeft = planeBusiness;
                                        moneyLeft = money;
									end
								else if(money < 25)
									begin
										moneyLeft = money;
										insufficientFund = 1;
										seatLeft = planeBusiness;
									end
								else
									begin
										planeBusiness = planeBusiness - 1;
										seatLeft = planeBusiness;
										moneyLeft = money - 25;
										seatReady = 1;
									end
							end
						else
							begin
								if(planeNormal == 0)
									begin
										selectedSeatUnavailable = 1;
										seatLeft = planeNormal;
                                        moneyLeft = money;
									end
								else if(money < 15)
									begin
										moneyLeft = money;
										insufficientFund = 1;
										seatLeft = planeNormal;
									end
								else
									begin
										planeNormal = planeNormal - 1;
										seatLeft = planeNormal;
										moneyLeft = money - 15;
										seatReady = 1;
									end
							end
					end

				default:
					begin
					end
			endcase
		end


endmodule
