library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  fpga_butsw_pio     : in  std_logic_vector(4 downto 0);             -- clock.clk
		  fpga_echo				: in std_logic;
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(3 downto 0);
		  fpga_triger			: out std_logic
	);
end entity topLevel;

architecture rtl of topLevel is
	component niosHello is
        port (
            butsw_export  : in  std_logic_vector(4 downto 0) := (others => 'X'); -- export
            clk_clk       : in  std_logic                    := 'X';             -- clk
            echo_input    : in  std_logic                    := 'X';             -- input
            leds_output   : out std_logic_vector(3 downto 0);                    -- output
            reset_reset_n : in  std_logic                    := 'X';             -- reset_n
            triger_out    : out std_logic                                        -- out                 -- output
        );
    end component niosHello;
	 
begin

    u0 : component niosHello
        port map (
            butsw_export  => fpga_butsw_pio,  -- butsw.export
            clk_clk       => fpga_clk_50,       --   clk.clk
				echo_input    => fpga_echo,    --   echo.input
            leds_output   => fpga_led_pio,   --  leds.output
            reset_reset_n => '1',				-- reset.reset_n
				triger_out    => fpga_triger     -- triger.out

        );
end architecture;




-- MAPEAR PINOS E TESTAR OS REGISTRADORES, VAMO GIGAS
