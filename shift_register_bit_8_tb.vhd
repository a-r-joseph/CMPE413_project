library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_shift_register_bit_8 is
    -- Test bench has no ports
end entity tb_shift_register_bit_8;

architecture test of tb_shift_register_bit_8 is
    -- Component Declaration
    component shift_register_bit_8 is
        port(
            input           : in  std_logic;
            clk             : in  std_logic;
            output          : out std_logic;
            addr_en_encode  : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signals for Input and Output
    signal input_sig       : std_logic := '0';
    signal clk             : std_logic := '0'; -- Test bench clock
    signal output_sig      : std_logic;
    signal addr_en_encode  : std_logic_vector(3 downto 0);

    -- Clock Period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: shift_register_bit_8
        port map(
            input          => input_sig,
            clk            => clk,
            output         => output_sig,
            addr_en_encode => addr_en_encode
        );

    -- Generate Test Bench Clock
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus Process
    stimulus: process
    begin
        -- Test Case 1: Initialize input to '0'
        input_sig <= '0';
        wait for clk_period;

        -- Test Case 2: Shift a single '1' through the register
        input_sig <= '1';
        wait for clk_period;

        input_sig <= '0';
        wait for clk_period * 7; -- Observe the shift through all bits

        -- Test Case 3: Test continuous input pattern
        input_sig <= '1';
        wait for clk_period;

        input_sig <= '0';
        wait for clk_period;

        --input_sig <= '1';
        wait for clk_period;

        --input_sig <= '0';
        wait for clk_period;

        -- Test Case 4: Observe addr_en_encode outputs
        wait for clk_period * 10; -- Allow multiple clock cycles for full observation

        -- End Simulation
        wait;
    end process;

end architecture test;