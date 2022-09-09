library verilog;
use verilog.vl_types.all;
entity AES_Encrypt is
    generic(
        N               : integer := 128;
        Nr              : integer := 10;
        Nk              : integer := 4
    );
    port(
        \in\            : in     vl_logic_vector(127 downto 0);
        key             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector(127 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Nr : constant is 1;
    attribute mti_svvh_generic_type of Nk : constant is 1;
end AES_Encrypt;
