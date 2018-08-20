library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
		  fpga_key_sw			: in std_logic_vector(3 downto 0);
		  fpga_en_but			: in std_logic;
        fpga_led_pio       : out std_logic_vector(5 downto 0)

	);
end entity topLevel;

architecture rtl of topLevel is

component LED_peripheral
    port (
		  clk       : in  std_logic;             -- clock.clk
        freq      : in  std_logic_vector(3 downto 0);
		  en        : in  std_logic;

        leds       : out std_logic_vector(5 downto 0)

	);
end component;

begin

  clock: LED_peripheral port map (fpga_clk_50, fpga_key_sw, fpga_en_but, fpga_led_pio);
  
end architecture;