library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_posedge_2bit is
    port ( d   : in  STD_LOGIC_VECTOR(1 downto 0);
           clk : in  STD_LOGIC;
           q   : out STD_LOGIC_VECTOR(1 downto 0);
           qbar: out STD_LOGIC_VECTOR(1 downto 0)
         );
end dff_posedge_2bit;

architecture structural of dff_posedge_2bit is
    component dff_posedge is
        port ( d   : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               q   : out STD_LOGIC;
               qbar: out STD_LOGIC
             );
    end component dff_posedge;

begin
    bit0: component dff_posedge
        port map (
            d    => d(0),
            clk  => clk,
            q    => q(0),
            qbar => qbar(0)
        );

    bit1: component dff_posedge
        port map (
            d    => d(1),
            clk  => clk,
            q    => q(1),
            qbar => qbar(1)
        );

end structural;
