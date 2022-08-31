library verilog;
use verilog.vl_types.all;
entity ram_128x32 is
    port(
        data_in         : in     vl_logic_vector(31 downto 0);
        addr            : in     vl_logic_vector(6 downto 0);
        en              : in     vl_logic;
        action          : in     vl_logic;
        clk             : in     vl_logic;
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end ram_128x32;
