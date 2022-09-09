library verilog;
use verilog.vl_types.all;
entity keyExpansion is
    generic(
        nk              : integer := 4;
        nr              : integer := 10
    );
    port(
        key             : in     vl_logic_vector;
        w               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of nk : constant is 1;
    attribute mti_svvh_generic_type of nr : constant is 1;
end keyExpansion;
