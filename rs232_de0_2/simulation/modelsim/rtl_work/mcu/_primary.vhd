library verilog;
use verilog.vl_types.all;
entity mcu is
    port(
        CLK             : in     vl_logic;
        BTN             : in     vl_logic_vector(2 downto 0);
        RX              : in     vl_logic;
        TX              : out    vl_logic
    );
end mcu;
