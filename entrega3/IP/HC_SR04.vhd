-- Nao esquecer de limpar irq ao ler o status

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.all;

entity HC_SR04 is
    generic (
        LEN  : natural := 4
    );
    port (
        -- Gloabals
        clk                : in  std_logic                     := '0';             
        reset              : in  std_logic                     := '0';             

        -- I/Os
		  echo					: in std_logic;
		  triger					: out std_logic;
		  
		  --irq
		  irq						: out std_logic                      := '0';
		  
        -- Avalion Memmory Mapped Slave
        avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read        : in  std_logic                     := '0';             
        avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write       : in  std_logic                     := '0';             
        avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')
	);
end entity HC_SR04;

architecture rtl of HC_SR04 is

signal REG_CONFIG : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal REG_COUNTER : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal s_en: std_logic;
signal end_counter: std_logic;
signal counterTimer : integer := 500;


begin

  process(clk)
  begin
    if (reset = '1') then
		REG_CONFIG 		<= (others => '0');
		REG_COUNTER 	<= x"A5A5A5A5";

		
    elsif(rising_edge(clk)) then
			s_en <= '0';
			if(avs_write = '1') then
				if(avs_address = "0000") then                  -- REG_DATA
					--REG_CONFIG(0) <= avs_writedata(0);
					s_en <= avs_writedata(0);
					-- s_en para dar um pulso e o process posterior identificar mudanca no s_en	
				elsif (avs_address = "0001") then
					REG_COUNTER <= avs_writedata;
				end if;
			end if;
			
			if(avs_read = '1') then
				if(avs_address = "0000") then                  -- REG_DAT
					avs_readdata <= REG_CONFIG;
				elsif (avs_address = "0001") then
					avs_readdata <= REG_COUNTER;
				end if;
			end if;
			
			REG_CONFIG(1) <= echo;  
			--triger <= REG_CONFIG(0);

    end if;
  end process;
  
	process(clk)
		variable counter : integer := 0;
		variable en_fixo : std_logic;
		begin
			if(reset = '1') then
				counter := 0;
				end_counter <= '0';
				en_fixo := '0';
			elsif(rising_edge(clk)) then
				if(s_en = '1' or en_fixo = '1') then
					if(counter < counterTimer) then
						end_counter <= '0';
						counter :=  counter + 1;
						en_fixo := '1';
					else
						end_counter <= '1';
						counter := 0;
						en_fixo := '0';
					end if;
				else
					counter := 0;
					end_counter <= '0';
				end if;
				triger <= en_fixo;
			end if;
	end process;
	
end rtl;