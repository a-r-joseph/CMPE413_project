-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


architecture Structural of mux_4x1_2bit is
    -- Declare the mux_4x1 component
    component mux_4x1
        port (
            read_data0 : in  STD_LOGIC;
            read_data1 : in  STD_LOGIC;
            read_data2 : in  STD_LOGIC;
            read_data3 : in  STD_LOGIC;
            sel        : in  STD_LOGIC_VECTOR(1 downto 0);
            F          : out STD_LOGIC
        );
    end component;

    for all: mux_4x1 use entity work.mux_4x1(Structural);

    -- Internal signal for the outputs of the two mux_4x1 instances
    signal mux_out : STD_LOGIC_VECTOR(1 downto 0);

begin
    -- Instantiate the first mux_4x1 for the lower bit (bit 0)
    mux_bit0: mux_4x1
    port map (
        read_data0 => read_data0(0),
        read_data1 => read_data1(0),
        read_data2 => read_data2(0),
        read_data3 => read_data3(0),
        sel        => sel,
        F          => mux_out(0)
    );

    -- Instantiate the second mux_4x1 for the higher bit (bit 1)
    mux_bit1: mux_4x1
    port map (
        read_data0 => read_data0(1),
        read_data1 => read_data1(1),
        read_data2 => read_data2(1),
        read_data3 => read_data3(1),
        sel        => sel,
        F          => mux_out(1)
    );

    F <= mux_out;

end Structural;
