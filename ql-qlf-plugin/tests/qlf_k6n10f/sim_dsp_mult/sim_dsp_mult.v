// Copyright (C) 2020-2021  The SymbiFlow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier:ISC

`include "qlf_k6n10f/cells_sim.v"
`timescale 1ns/1ps

module tb();

    // Clock
    reg clk;
    initial clk <= 1'b0;
    always #0.5 clk <= ~clk;

    // Reset
    reg rst;
    initial begin
            rst <= 1'b0;
        #1  rst <= 1'b1;
        #2  rst <= 1'b0;
    end

    // Input data / reference
    reg signed [19:0] A;
    reg signed [17:0] B;
    reg signed [37:0] C;

    always @(posedge clk) begin
        A = $random;
        B = $random;

        C <= A * B;
    end

    // UUT
    wire signed [37:0] Z;

    dsp_t1_sim # (
    ) uut (
        .a_i            	(A),
        .b_i            	(B),
        .unsigned_a_i   	(1'h0),
        .unsigned_b_i   	(1'h0),
        .feedback_i     	(3'h0),
	.register_inputs_i	(1'h0),
	.output_select_i	(3'h0),
        .z_o            	(Z)
    );

    // Error detection
    wire error = (Z != C);

    // Error counting
    integer error_count;
    initial error_count <= 0;
    always @(posedge clk) begin
        if (error) error_count <= error_count + 1;
    end

    // Simulation control / data dump
    initial begin
        $dumpfile(`VCD_FILE);
        $dumpvars(0, tb);
        #10000 $finish_and_return( (error_count == 0) ? 0 : -1 );
    end

endmodule
