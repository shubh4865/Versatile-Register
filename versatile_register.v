module versatile_register (
    input wire parin3, parin2, parin1, parin0,  // Parallel data inputs for PIPO
    input wire serialin,                        // Serial input for SISO
    input wire clk,                             // Clock signal
    input wire reset,                           // Asynchronous reset
    input wire preset,                          // Asynchronous preset
    input wire [1:0] C,                         // Control signals C1 and C0
    output reg Q3, Q2, Q1, Q0,                  // Parallel data outputs
    output wire serialout,                      // Serial data output from SISO
    output wire carry                           // Carry output from counter
);

    // Internal wires for connecting modules
    wire [3:0] pipo_out;                        // Output of the PIPO register
    wire [3:0] counter_out;                     // Output of the counter
    wire [3:0] lfsr_out;                        // Output of the LFSR

    // Instantiate PIPO module
    PIPO pipo_inst (
        .parin3(parin3),
        .parin2(parin2),
        .parin1(parin1),
        .parin0(parin0),
        .clk(clk),
        .reset(reset),
        .Q3(pipo_out[3]),
        .Q2(pipo_out[2]),
        .Q1(pipo_out[1]),
        .Q0(pipo_out[0])
    );

    // Instantiate Counter module
    counter counter_inst (
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2),
        .Q3(Q3),
        .S0(counter_out[0]),
        .S1(counter_out[1]),
        .S2(counter_out[2]),
        .S3(counter_out[3]),
        .carry(carry)
    );

    // Instantiate SISO module
    siso siso_inst (
        .serialin(serialin),
        .clk(clk),
        .reset(reset),
        .serialout(serialout)
    );

    // Instantiate LFSR module
    LFSR lfsr_inst (
        .clk(clk),
        .reset(reset),
        .lfsr_out(lfsr_out)
    );

    // Control logic for versatile register operations
    always @(posedge clk or posedge reset or posedge preset) begin
        if (reset) begin
            {Q3, Q2, Q1, Q0} <= 4'b0000;       // Asynchronous reset to 0
        end else if (preset) begin
            {Q3, Q2, Q1, Q0} <= 4'b1111;       // Asynchronous preset to 1
        end else begin
            case (C)
                2'b00: {Q3, Q2, Q1, Q0} <= pipo_out;             // Load parallel data from PIPO
                2'b01: {Q3, Q2, Q1, Q0} <= counter_out;          // Increment using counter
                2'b10: {Q3, Q2, Q1, Q0} <= {serialin, Q3, Q2, Q1}; // Right shift with serial input
                2'b11: {Q3, Q2, Q1, Q0} <= lfsr_out;             // Linear feedback shift (LFSR)
                default: {Q3, Q2, Q1, Q0} <= {Q3, Q2, Q1, Q0};   // Hold current state
            endcase
        end
    end

endmodule
