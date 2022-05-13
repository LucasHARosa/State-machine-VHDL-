library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_timer is

end entity;

architecture sim of tb_timer is
	component dut_timer is
		port(
			clk     : in std_logic;
			reset   : in std_logic;
			enable  : in std_logic;
			direction : in std_logic;
			contagem: out std_logic_vector(5 downto 0)
    		);
	end component;	

	signal clk   : std_logic;
	signal reset : std_logic;
	signal enable: std_logic;
	signal direction : std_logic;
	signal contagem: std_logic_vector(5 downto 0);

begin
my_timer: dut_timer
	port map(
		clk => clk,
		reset => reset,
		enable => enable,
		direction => direction,
		contagem => contagem
	);

	process is
	begin
		
		clk <= '0';
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
	end process;

	process is
	begin
		wait for 2 ns;
		-- Inicia a contagem de soma
		reset <= '0';
		enable <= '1';
		direction <= '0';
		wait for 10 ns;
		-- Zera e para a contagem
		reset <= '1';
		enable <= '0';
		direction <= '0';
		wait for 6 ns;
		-- Inicia a contagem de soma
		reset <= '0';
		enable <= '1';
		direction <= '0';
		wait for 30 ns;
		-- Para a contagem
		reset <= '0';
		enable <= '0';
		direction <= '0';
		wait for 8 ns;
		-- Retoma a contagem de soma
		reset <= '0';
		enable <= '1';
		direction <= '0';
		wait for 8 ns;
		-- Zera e para a contagem
		reset <= '1';
		enable <= '1';
		direction <= '0';
		wait for 6 ns;
		-- Inicia a contagem de soma
		reset <= '0';
		enable <= '1';
		direction <= '0';
		wait for 80 ns;
		-- Inicia a contagem de subtracao
		reset <= '0';
		enable <= '1';
		direction <= '1';
		wait for 30 ns;
		-- Zera e para a contagem
		reset <= '1';
		enable <= '0';
		direction <= '1';
		wait for 6 ns;
		-- Inicia a contagem de subtacao
		reset <= '0';
		enable <= '1';
		direction <= '1';
		wait for 8 ns;
		-- Para a contagem
		reset <= '0';
		enable <= '0';
		direction <= '1';
		wait for 6 ns;
		--Retoma a contagem
		reset <= '0';
		enable <= '1';
		direction <= '1';
		wait for 124 ns;
		-- Para a contagem
		reset <= '0';
		enable <= '0';
		direction <= '1';
		wait for 6 ns;
		-- Zera a contagem
		reset <= '1';
		enable <= '0';
		direction <= '1';
		wait for 6 ns;
		-- Inicia a contagem somando
		reset <= '0';
		enable <= '1';
		direction <= '0';
		wait for 124 ns;
		wait;		

	end process;


	

end architecture;