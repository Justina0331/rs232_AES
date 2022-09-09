library verilog;
use verilog.vl_types.all;
entity inverseSbox is
    port(
        selector        : in     vl_logic_vector(7 downto 0);
        sbout           : out    vl_logic_vector(7 downto 0)
    );
end inverseSbox;
