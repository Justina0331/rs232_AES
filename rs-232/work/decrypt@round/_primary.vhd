library verilog;
use verilog.vl_types.all;
entity decryptRound is
    port(
        \in\            : in     vl_logic_vector(127 downto 0);
        key             : in     vl_logic_vector(127 downto 0);
        \out\           : out    vl_logic_vector(127 downto 0)
    );
end decryptRound;
