library verilog;
use verilog.vl_types.all;
entity aes_sbox is
    port(
        sboxw           : in     vl_logic_vector(31 downto 0);
        new_sboxw       : out    vl_logic_vector(31 downto 0)
    );
end aes_sbox;
