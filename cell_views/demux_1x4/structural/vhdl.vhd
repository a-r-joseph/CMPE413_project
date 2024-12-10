-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Fri Dec  6 13:37:41 2024


architecture Structural of demux_1x4 is
    -- Declare the components for inverter and 3-input AND gate
    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component and_3x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Internal signals
    signal sel_not : STD_LOGIC_VECTOR(1 downto 0);

    -- Component binding statements
    for all : inverter use entity work.inverter(Structural);
    for all : and_3x1 use entity work.and_3x1(Structural);

begin
    -- Instantiate the two inverters for sel(0) and sel(1)
    inv0: inverter
    port map (
        input  => sel(0),
        output => sel_not(0)
    );

    inv1: inverter
    port map (
        input  => sel(1),
        output => sel_not(1)
    );

    -- Instantiate the three 3-input AND gates for outputs
    and_gate_0: and_3x1
    port map (
        A          => data_in,
        B          => sel_not(1),
        C          => sel_not(0),
        output     => data_out_0
    );

    and_gate_1: and_3x1
    port map (
        A          => data_in,
        B          => sel_not(1),
        C          => sel(0),
        output     => data_out_1
    );

    and_gate_2: and_3x1
    port map (
        A          => data_in,
        B          => sel(1),
        C          => sel_not(0),
        output     => data_out_2
    );

    and_gate_3: and_3x1
    port map (
        A          => data_in,
        B          => sel(1),
        C          => sel(0),
        output     => data_out_3
    );

end Structural;