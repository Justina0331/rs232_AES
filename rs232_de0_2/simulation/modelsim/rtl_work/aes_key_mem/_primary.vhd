library verilog;
use verilog.vl_types.all;
entity aes_key_mem is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        key             : in     vl_logic_vector(255 downto 0);
        keylen          : in     vl_logic;
        init            : in     vl_logic;
        round           : in     vl_logic_vector(3 downto 0);
        round_key       : out    vl_logic_vector(127 downto 0);
        ready           : out    vl_logic;
        sboxw           : out    vl_logic_vector(31 downto 0);
        new_sboxw       : in     vl_logic_vector(31 downto 0)
    );
end aes_key_mem;
