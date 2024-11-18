library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_negedge_8bit is
    port ( d   : in  STD_LOGIC_VECTOR(7 downto 0);
           clk : in  STD_LOGIC;
           q   : out STD_LOGIC_VECTOR(7 downto 0);
           qbar: out STD_LOGIC_VECTOR(7 downto 0)
         );
end dff_negedge_8bit;

architecture structural of dff_negedge_8bit is
    component dff_negedge is
        port ( d   : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               q   : out STD_LOGIC;
               qbar: out STD_LOGIC
             );
    end component dff_negedge;

begin
    bit0: component dff_negedge
        port map (
            d   => d(0),
            clk => clk,
            q   => q(0),
            qbar=> qbar(0)
        );

    bit1: component dff_negedge
        port map (
            d   => d(1),
            clk => clk,
            q   => q(1),
            qbar=> qbar(1)
        );

    bit2: component dff_negedge
        port map (
            d   => d(2),
            clk => clk,
            q   => q(2),
            qbar=> qbar(2)
        );

    bit3: component dff_negedge
        port map (
            d   => d(3),
            clk => clk,
            q   => q(3),
            qbar=> qbar(3)
        );

    bit4: component dff_negedge
        port map (
            d   => d(4),
            clk => clk,
            q   => q(4),
            qbar=> qbar(4)
        );

    bit5: component dff_negedge
        port map (
            d   => d(5),
            clk => clk,
            q   => q(5),
            qbar=> qbar(5)
        );

    bit6: component dff_negedge
        port map (
            d   => d(6),
            clk => clk,
            q   => q(6),
            qbar=> qbar(6)
        );

    bit7: component dff_negedge
        port map (
            d   => d(7),
            clk => clk,
            q   => q(7),
            qbar=> qbar(7)
        );

end structural;
