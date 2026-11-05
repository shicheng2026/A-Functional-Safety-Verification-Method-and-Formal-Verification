// Partial, illustrative property excerpts accompanying the manuscript:
// A Functional Safety Verification Method Combining Simulation-Based
// Fault Injection and Formal Verification.
//
// Adapted from the three examples in the manuscript, not a release of the
// complete experimental property suite. No RTL, bind configuration, or
// environment assumptions are included. Signal mapping and timing windows
// must be checked for the target design before use. See README.md.

module formal_property_examples #(
    parameter logic [1:0] NONSEQ = 2'b10
) (
    input logic       clk,
    input logic       rst_n,
    input logic       inject_err_en,
    input logic       ecc_alarm,
    input logic       hclk,
    input logic       hresetn,
    input logic       hsel,
    input logic [1:0] htrans,
    input logic       hwrite,
    input logic       penable,
    input logic       pwrite,
    input logic       fifo_empty,
    input logic       fifo_rd_en,
    input logic       fifo_full,
    input logic       fifo_wr_en
);

    // Non-overlapped implication followed by a 1..3 cycle delay:
    // the consequent is sampled 2..4 clock edges after the antecedent.
    property check_ecc_alarm;
        @(posedge clk) disable iff (!rst_n)
            inject_err_en |=> ##[1:3] ecc_alarm;
    endproperty
    assert_ecc_alarm: assert property (check_ecc_alarm);

    // Illustrative write-response check, not a complete AHB/APB checker.
    // Acceptance, wait-state, and clock-domain assumptions are not supplied.
    // The non-overlapped implication gives a 2..6 hclk-edge response window.
    property check_ahb2apb_handshake;
        @(posedge hclk) disable iff (!hresetn)
            (hsel && htrans == NONSEQ && hwrite)
            |=> ##[1:5] (penable && pwrite);
    endproperty
    assert_handshake: assert property (check_ahb2apb_handshake);

    // Interface access check; adapt to the FIFO's simultaneous-access rules.
    property check_fifo_consistency;
        @(posedge hclk) disable iff (!hresetn)
            !(fifo_empty && fifo_rd_en) && !(fifo_full && fifo_wr_en);
    endproperty
    assert_fifo: assert property (check_fifo_consistency);

endmodule
