library verilog;
use verilog.vl_types.all;
entity shiftRows is
    port(
        \in\            : in     vl_logic_vector(0 to 127);
        shifted         : out    vl_logic_vector(0 to 127)
    );
end shiftRows;
