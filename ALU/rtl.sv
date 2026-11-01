module alu (
    input  logic [4:0]  alu_control,
    input  logic [31:0] rs1_data,
    input  logic [31:0] rs2_data,
    output logic [31:0] alu_out,
    output logic        zero
);

    always_comb begin
        unique case (alu_control)
            5'b00000: alu_out = rs1_data + rs2_data;                          // ADD / ADDI
            5'b00001: alu_out = rs1_data - rs2_data;                          // SUB
            5'b00010: alu_out = rs1_data ^ rs2_data;                          // XOR / XORI
            5'b00011: alu_out = rs1_data | rs2_data;                          // OR / ORI
            5'b00100: alu_out = rs1_data & rs2_data;                          // AND / ANDI
            5'b00101: alu_out = rs1_data << rs2_data[4:0];                    // SLL / SLLI
            5'b00110: alu_out = rs1_data >> rs2_data[4:0];                    // SRL / SRLI
            5'b00111: alu_out = unsigned'($signed(rs1_data) >>> rs2_data[4:0]); // SRA / SRAI
            5'b01000: alu_out = ($signed(rs1_data) < $signed(rs2_data)) ? 32'd1 : 32'd0; // SLT / SLTI
            5'b01001: alu_out = (rs1_data < rs2_data) ? 32'd1 : 32'd0;        // SLTU / SLTIU
            default:  alu_out = rs1_data + rs2_data;
        endcase

        zero = (alu_out == 32'd0);
    end

endmodule