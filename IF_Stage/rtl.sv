module if_stage (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,
    input  logic        and_out,
    input  logic [31:0] pc_signed_offset,
    output logic [31:0] address,
    output logic [31:0] pc_new
);

    logic [31:0] pc_next;
    logic [31:0] pc_reg;

    assign pc_new = pc_reg + 32'd4;

    assign pc_next = and_out ? pc_signed_offset : pc_new;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_reg <= 32'h8000_0000;
        else if (!stall)
            pc_reg <= pc_next;
    end

    assign address = pc_reg;

endmodule