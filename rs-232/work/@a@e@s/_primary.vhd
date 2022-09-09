library verilog;
use verilog.vl_types.all;
entity AES is
    port(
        enable          : in     vl_logic;
        e128_in         : in     vl_logic_vector(127 downto 0);
        e128_out        : out    vl_logic_vector(127 downto 0);
        d128            : out    vl_logic
    );
end AES;
