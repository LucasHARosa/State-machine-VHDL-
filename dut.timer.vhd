library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pacote.all;


entity dut_timer is
	port(
		clk     : in std_logic;
		reset   : in std_logic;
		enable  : in std_logic;
		direction : in std_logic;
		contagem: out std_logic_vector(5 downto 0)
    );
end dut_timer;

architecture basic of dut_timer is

	type my_state is (Zera, Parado, Soma, Subtrai);
	signal estadoAtual   : my_state;
	signal proximoEstado : my_state;
	
	signal contador : unsigned(5 downto 0); -- valores de 0 a 59
	signal controle : std_logic_vector(2 downto 0);

begin
	controle <= reset & enable & direction;
	contagem <= std_logic_vector(contador);

	process(clk)
	begin
		if rising_edge(clk) then
			estadoAtual <= proximoEstado;
			case estadoAtual is
				when Zera => contador <= to_unsigned(0,contador'length);
				when Parado => contador <= contador;
				when Soma =>
					if(contador=59)then
						contador <= to_unsigned(0,contador'length);
					else
						contador <= contador + 1;
					end if;
				when Subtrai =>
					if(contador=0)then
						contador <= to_unsigned(59,contador'length);
					else
						contador <= contador - 1;
					end if;
			end case;
		end if;
	end process;

	process(controle)
	begin
		case controle is

			-- Quando direction for igual a '0' o contador irá somar
			-- Quando direction for igual a '1' o contador irá subtrair

			when "000" => -- reset=0 enable=0 direction = 0
					proximoEstado <= Parado;	
			when "010" => -- reset=0 enable=1 direction = 0
					proximoEstado <= Soma;
			when "100" => -- reset=1 enable=0 direction = 0
					proximoEstado <= Zera;
			when "110" => -- reset=1 enable=1 direction = 0
					proximoEstado <= Zera;
			when "001" => -- reset=0 enable=0 direction = 1
					proximoEstado <= Parado;	
			when "011" => -- reset=0 enable=1 direction = 1
					proximoEstado <= Subtrai;
			when "101" => -- reset=1 enable=0 direction = 1
					proximoEstado <= Zera;
			when "111" => -- reset=1 enable=1 direction = 1
					proximoEstado <= Zera;
			when others =>  proximoEstado <= estadoAtual;
		end case;
	end process;
end basic;