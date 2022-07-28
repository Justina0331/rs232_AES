library verilog;
use verilog.vl_types.all;
entity rs232 is
    port(
        TX              : out    vl_logic;
        RX              : in     vl_logic;
        sw2             : in     vl_logic;
        sw1             : in     vl_logic;
        sw0             : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        port_b_out      : out    vl_logic_vector(7 downto 0)
    );
end rs232;
