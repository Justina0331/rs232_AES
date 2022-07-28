library verilog;
use verilog.vl_types.all;
entity TX is
    port(
        data_out        : out    vl_logic;
        data_in         : in     vl_logic;
        start           : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        CHECK_TIME      : in     vl_logic
    );
end TX;
