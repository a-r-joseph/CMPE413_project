-- Entity: demux_1x4
-- Architecture: Structural

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x4 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input
        sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
        data_out_3 : out STD_LOGIC; -- Output for selection "11"
        data_out_2 : out STD_LOGIC; -- Output for selection "10"
        data_out_1 : out STD_LOGIC; -- Output for selection "01"
        data_out_0 : out STD_LOGIC -- Output for selection "00"
    );
end entity demux_1x4;

architecture Structural of demux_1x4 is
    -- Declare the components for inverter and 3-input AND gate
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    component and_3x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_3x1;

    -- Internal signals
    signal sel_not : STD_LOGIC_VECTOR(1 downto 0);

begin
    -- Instantiate the two inverters for sel(0) and sel(1)
    gen_inv: for i in 0 to 1 generate
        inv: entity work.inverter(Structural)
        port map (
            input  => sel(i),
            output => sel_not(i)
        );
    end generate;

    -- Instantiate the three 3-input AND gates for outputs
    and_gate_0: entity work.and_3x1(Structural)
    port map (
        A          => data_in,
        B          => sel_not(1),
        C          => sel_not(0),
        output     => data_out_0
    );

    and_gate_1: entity work.and_3x1(Structural)
    port map (
        A          => data_in,
        B          => sel_not(1),
        C          => sel(0),
        output     => data_out_1
    );

    and_gate_2: entity work.and_3x1(Structural)
    port map (
        A          => data_in,
        B          => sel(1),
        C          => sel_not(0),
        output     => data_out_2
    );

    and_gate_3: entity work.and_3x1(Structural)
    port map (
        A          => data_in,
        B          => sel(1),
        C          => sel(0),
        output     => data_out_3
    );

end architecture Structural;