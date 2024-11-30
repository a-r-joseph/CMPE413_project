library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_posedge_8bit is
    port (
        d    : in  STD_LOGIC_VECTOR(7 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(7 downto 0);
        qbar : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity dff_posedge_8bit;

architecture Structural of dff_posedge_8bit is

    component dff_posedge_4bit is
        port (
            d    : in  STD_LOGIC_VECTOR(3 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(3 downto 0);
            qbar : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component dff_posedge_4bit;

begin

    gen_dffs: for i in 0 to 1 generate
        dff: entity work.dff_posedge_4bit(Structural)
        port map (
            d    => d(4 * i + 3 downto 4 * i),
            clk  => clk,
            q    => q(4 * i + 3 downto 4 * i),
            qbar => qbar(4 * i + 3 downto 4 * i)
        );
    end generate;

end architecture Structural;