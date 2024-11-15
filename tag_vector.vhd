-- Entity: tag_vector
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tag_vector is
    port (
        write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit shared write data
        chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
        RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
        sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux
        read_data_3 : out STD_LOGIC_VECTOR(1 downto 0); -- Read data output for cell 3
        read_data_2 : out STD_LOGIC_VECTOR(1 downto 0); -- Read data output for cell 2
        read_data_1 : out STD_LOGIC_VECTOR(1 downto 0); -- Read data output for cell 1
        read_data_0 : out STD_LOGIC_VECTOR(1 downto 0) -- Read data output for cell 0
    );
end entity tag_vector;

architecture Structural of tag_vector is
    -- Declare the cache_cell_2bit component
    component cache_cell_2bit is
        port (
            write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit write data
            chip_enable : in  STD_LOGIC;                    -- 1-bit chip enable
            RW          : in  STD_LOGIC;                    -- 1-bit Read/Write
            read_data   : out STD_LOGIC_VECTOR(1 downto 0)  -- 2-bit read data
        );
    end component cache_cell_2bit;

    -- Declare the demux_1x4_2bit component
    component demux_1x4_2bit is
        port (
            data_in    : in  STD_LOGIC_VECTOR(1 downto 0);  -- 2-bit input data
            sel        : in  STD_LOGIC_VECTOR(1 downto 0);  -- 2-bit selector
            data_out_3 : out STD_LOGIC_VECTOR(1 downto 0);  -- Output for selection "11"
            data_out_2 : out STD_LOGIC_VECTOR(1 downto 0);  -- Output for selection "10"
            data_out_1 : out STD_LOGIC_VECTOR(1 downto 0);  -- Output for selection "01"
            data_out_0 : out STD_LOGIC_VECTOR(1 downto 0)   -- Output for selection "00"
        );
    end component demux_1x4_2bit;

    -- Internal signals for the demux outputs
    signal demux_out_3, demux_out_2, demux_out_1, demux_out_0 : STD_LOGIC_VECTOR(1 downto 0);
    for demux_inst: demux_1x4_2bit use entity work.demux_1x4_2bit(structural);
    for cache_0, cache_1, cache_2, cache_3: cache_cell_2bit use entity work.cache_cell_2bit(structural);

begin
    -- Instantiate the demux_1x4_2bit and connect the shared write_data and sel
    demux_inst: component demux_1x4_2bit
    port map (
        data_in     => write_data,                          -- Shared write data input
        sel         => sel,                                 -- 2-bit selector input
        data_out_3  => demux_out_3,                         -- Output connected to cache_cell_3's write_data
        data_out_2  => demux_out_2,                         -- Output connected to cache_cell_2's write_data
        data_out_1  => demux_out_1,                         -- Output connected to cache_cell_1's write_data
        data_out_0  => demux_out_0                          -- Output connected to cache_cell_0's write_data
    );

    -- Instantiate each cache_cell_2bit and connect signals as required
    cache_0: component cache_cell_2bit
    port map (
        write_data  => demux_out_0,                         -- Demux output for cache cell 0
        chip_enable => chip_enable(0),                      -- Unique chip enable for cache cell 0
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_0                          -- Unique read data output for cache cell 0
    );

    cache_1: component cache_cell_2bit
    port map (
        write_data  => demux_out_1,                         -- Demux output for cache cell 1
        chip_enable => chip_enable(1),                      -- Unique chip enable for cache cell 1
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_1                          -- Unique read data output for cache cell 1
    );

    cache_2: component cache_cell_2bit
    port map (
        write_data  => demux_out_2,                         -- Demux output for cache cell 2
        chip_enable => chip_enable(2),                      -- Unique chip enable for cache cell 2
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_2                          -- Unique read data output for cache cell 2
    );

    cache_3: component cache_cell_2bit
    port map (
        write_data  => demux_out_3,                         -- Demux output for cache cell 3
        chip_enable => chip_enable(3),                      -- Unique chip enable for cache cell 3
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_3                          -- Unique read data output for cache cell 3
    );

end architecture Structural;