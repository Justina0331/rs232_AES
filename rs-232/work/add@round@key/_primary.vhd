library verilog;
use verilog.vl_types.all;
entity addRoundKey is
    port(
        data            : in     vl_logic_vector(127 downto 0);
        \out\           : out    vl_logic_vector(127 downto 0);
        key             : in     vl_logic_vector(127 downto 0)
    );
end addRoundKey;
