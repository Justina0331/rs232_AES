library verilog;
use verilog.vl_types.all;
entity aes_encipher_block is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        \next\          : in     vl_logic;
        keylen          : in     vl_logic;
        round           : out    vl_logic_vector(3 downto 0);
        round_key       : in     vl_logic_vector(127 downto 0);
        sboxw           : out    vl_logic_vector(31 downto 0);
        new_sboxw       : in     vl_logic_vector(31 downto 0);
        \block\         : in     vl_logic_vector(127 downto 0);
        new_block       : out    vl_logic_vector(127 downto 0);
        ready           : out    vl_logic
    );
end aes_encipher_block;
