library verilog;
use verilog.vl_types.all;
entity rs232 is
    port(
        TX              : out    vl_logic;
        RX              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end rs232;
