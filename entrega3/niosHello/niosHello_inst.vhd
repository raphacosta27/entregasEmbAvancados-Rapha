	component niosHello is
		port (
			butsw_export  : in  std_logic_vector(4 downto 0) := (others => 'X'); -- export
			clk_clk       : in  std_logic                    := 'X';             -- clk
			echo_out      : in  std_logic                    := 'X';             -- out
			echo_input    : out std_logic;                                       -- input
			leds_output   : out std_logic_vector(3 downto 0);                    -- output
			reset_reset_n : in  std_logic                    := 'X'              -- reset_n
		);
	end component niosHello;

	u0 : component niosHello
		port map (
			butsw_export  => CONNECTED_TO_butsw_export,  -- butsw.export
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			echo_out      => CONNECTED_TO_echo_out,      --  echo.out
			echo_input    => CONNECTED_TO_echo_input,    --      .input
			leds_output   => CONNECTED_TO_leds_output,   --  leds.output
			reset_reset_n => CONNECTED_TO_reset_reset_n  -- reset.reset_n
		);

