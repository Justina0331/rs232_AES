library verilog;
use verilog.vl_types.all;
entity sbox is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        c               : out    vl_logic_vector(7 downto 0)
    );
end sbox;
