library IEEE;

-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

-- SIGNED and UNSIGNED types, and relevant functions
use ieee.numeric_std.all;

entity led_peripheral is
    port (
		  clk       : in  std_logic;             -- clock.clk
        freq      : in  std_logic_vector(3 downto 0);
		  en        : in  std_logic;

        leds       : out std_logic_vector(5 downto 0)

	);
end entity led_peripheral;

architecture led of led_peripheral is
-- signal
signal blink : std_logic := '0';
signal dividend: integer := 0;

begin
  process(clk) 
      variable counter : integer range 0 to 25000000 := 0;
      begin
        if (rising_edge(clk)) then
		  

						dividend <= to_integer(unsigned(freq));
						
						if(dividend = 0) then
							dividend <= 1;
						end if;
						
                  if (counter < (20000000/dividend)) then
                      counter := counter + 1;
                  else
                      blink <= not blink;
                      counter := 0;
                  end if;
        end if;
  end process;

  leds(0) <= blink and en;
  leds(1) <= blink and en;
  leds(2) <= blink and en;
  leds(3) <= blink and en;
  leds(4) <= blink and en;
  leds(5) <= blink and en;
  
end architecture;