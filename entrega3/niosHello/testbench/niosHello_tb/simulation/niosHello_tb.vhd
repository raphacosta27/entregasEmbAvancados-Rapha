-- niosHello_tb.vhd

-- Generated using ACDS version 16.0 211

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity niosHello_tb is
end entity niosHello_tb;

architecture rtl of niosHello_tb is
	component niosHello is
		port (
			butsw_export  : in  std_logic_vector(4 downto 0) := (others => 'X'); -- export
			clk_clk       : in  std_logic                    := 'X';             -- clk
			echo_input    : in  std_logic                    := 'X';             -- input
			leds_output   : out std_logic_vector(3 downto 0);                    -- output
			reset_reset_n : in  std_logic                    := 'X';             -- reset_n
			triger_out    : out std_logic                                        -- out
		);
	end component niosHello;

	component altera_avalon_clock_source is
		generic (
			CLOCK_RATE : positive := 10;
			CLOCK_UNIT : positive := 1000000
		);
		port (
			clk : out std_logic   -- clk
		);
	end component altera_avalon_clock_source;

	component altera_avalon_reset_source is
		generic (
			ASSERT_HIGH_RESET    : integer := 1;
			INITIAL_RESET_CYCLES : integer := 0
		);
		port (
			reset : out std_logic;        -- reset_n
			clk   : in  std_logic := 'X'  -- clk
		);
	end component altera_avalon_reset_source;

	signal nioshello_inst_clk_bfm_clk_clk       : std_logic; -- niosHello_inst_clk_bfm:clk -> [niosHello_inst:clk_clk, niosHello_inst_reset_bfm:clk]
	signal nioshello_inst_reset_bfm_reset_reset : std_logic; -- niosHello_inst_reset_bfm:reset -> niosHello_inst:reset_reset_n

begin

	nioshello_inst : component niosHello
		port map (
			butsw_export  => open,                                 --  butsw.export
			clk_clk       => nioshello_inst_clk_bfm_clk_clk,       --    clk.clk
			echo_input    => open,                                 --   echo.input
			leds_output   => open,                                 --   leds.output
			reset_reset_n => nioshello_inst_reset_bfm_reset_reset, --  reset.reset_n
			triger_out    => open                                  -- triger.out
		);

	nioshello_inst_clk_bfm : component altera_avalon_clock_source
		generic map (
			CLOCK_RATE => 50000000,
			CLOCK_UNIT => 1
		)
		port map (
			clk => nioshello_inst_clk_bfm_clk_clk  -- clk.clk
		);

	nioshello_inst_reset_bfm : component altera_avalon_reset_source
		generic map (
			ASSERT_HIGH_RESET    => 0,
			INITIAL_RESET_CYCLES => 50
		)
		port map (
			reset => nioshello_inst_reset_bfm_reset_reset, -- reset.reset_n
			clk   => nioshello_inst_clk_bfm_clk_clk        --   clk.clk
		);

end architecture rtl; -- of niosHello_tb
