`timescale 1ns / 1ps

module versatile_register_tb;

    // Inputs
    reg parin3, parin2, parin1, parin0; // Parallel data inputs for PIPO
    reg serialin;                       // Serial input for SISO
    reg clk;                            // Clock signal
    reg reset;                          // Asynchronous reset
    reg preset;                         // Asynchronous preset
    reg [1:0] C;                        // Control signals C1 and C0

    // Outputs
    wire Q3, Q2, Q1, Q0;                // Parallel data outputs
    wire serialout;                     // Serial data output from SISO
    wire carry;                         // Carry output from counter

    // Instantiate the Versatile Register module
    versatile_register uut (
        .parin3(parin3),
        .parin2(parin2),
        .parin1(parin1),
        .parin0(parin0),
        .serialin(serialin),
        .clk(clk),
        .reset(reset),
        .preset(preset),
        .C(C),
        .Q3(Q3),
        .Q2(Q2),
        .Q1(Q1),
        .Q0(Q0),
        .serialout(serialout),
        .carry(carry)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        parin3 = 1'b1; parin2 = 1'b0; parin1 = 1'b1; parin0 = 1'b0;
        serialin = 1'b1;
        reset = 1'b0;
        preset = 1'b0;
        C = 2'b00;

        // Apply asynchronous reset
        reset = 1'b1;
        #10;
        reset = 1'b0;

        // Apply asynchronous preset
        preset = 1'b1;
        #10;
        preset = 1'b0;

        // Test Case 1: Load parallel data (C = 00)
        parin3 = 1'b1; parin2 = 1'b0; parin1 = 1'b1; parin0 = 1'b0;
        C = 2'b00;
        #10;

        // Test Case 2: Increment (C = 01)
        C = 2'b01;
        #10;

        // Test Case 3: Right shift with serial input (C = 10)
        serialin = 1'b1;
        C = 2'b10;
        #10;

        // Test Case 4: Linear feedback shift (C = 11)
        C = 2'b11;
        #10;

        // Test additional cases or repeat as needed
        // End of simulation
        $stop;
    end

    // Monitor outputs for debugging
    initial begin
        $monitor("Time=%0t | Reset=%b | Preset=%b | C=%b | Q3 Q2 Q1 Q0=%b%b%b%b | SerialOut=%b | Carry=%b",
                 $time, reset, preset, C, Q3, Q2, Q1, Q0, serialout, carry);
    end

endmodule

