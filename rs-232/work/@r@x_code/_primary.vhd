library verilog;
use verilog.vl_types.all;
entity RX_code is
    generic(
        T0              : integer := 0;
        T1              : integer := 1;
        T2              : integer := 2;
        T3              : integer := 3;
        T4              : integer := 4;
        T5              : integer := 5;
        T6              : integer := 6
    );
    port(
        data_out        : out    vl_logic_vector(63 downto 0);
        data_in         : in     vl_logic;
        load_port_b     : out    vl_logic;
        tx_start        : out    vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ram_out         : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T0 : constant is 1;
    attribute mti_svvh_generic_type of T1 : constant is 1;
    attribute mti_svvh_generic_type of T2 : constant is 1;
    attribute mti_svvh_generic_type of T3 : constant is 1;
    attribute mti_svvh_generic_type of T4 : constant is 1;
    attribute mti_svvh_generic_type of T5 : constant is 1;
    attribute mti_svvh_generic_type of T6 : constant is 1;
end RX_code;
