library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ksa is 
  generic(N: integer := 8); 
  port(
    CLOCK_50            : in  std_logic;  -- Clock pin
    KEY                 : in  std_logic_vector(3 downto 0);  -- push button switches
    SW                 : in  std_logic_vector(9 downto 0);  -- slider switches
    LEDR : out std_logic_vector(9 downto 0);  -- red lights
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0));
end ksa;

architecture rtl of ksa is
   COMPONENT SevenSegmentDisplayDecoder IS
        PORT
        (
            ssOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            nIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    -- instantiate a counter in verilog counting up from 0 to 255
    COMPONENT counter IS
        PORT
        (
            clkc, reset: in STD_LOGIC;       --reset --> reset_n
            qc: out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    END COMPONENT; 

    COMPONENT Jreg IS
        PORT
        (
            clkj, resetj,enj: in STD_LOGIC;       
            inj, i_intoj: in STD_LOGIC_VECTOR(N-1 downto 0);
            outj: out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    END COMPONENT; 

    --connect the s_memory to counter
    COMPONENT s_memory IS
        PORT
        (
            address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            --clock		: IN STD_LOGIC  := '1';
            clock		: IN STD_LOGIC;
            data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            --wren		: IN STD_LOGIC ;
            wren		: IN STD_LOGIC := '1' ;
            q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT statemachine IS
    PORT
    (
        q: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        q_m: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        clks: IN STD_LOGIC;
        resets: IN STD_LOGIC;
        wren: OUT STD_LOGIC;
        wren_d: OUT STD_LOGIC;
        reset_i: OUT STD_LOGIC;
        enj: OUT STD_LOGIC;
        jin: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        data: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        address: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        address_d: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        data_d: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        address_m: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END COMPONENT;
   
    -- clock and reset signals  
	 signal clk, reset_n,reset_i2,enj2 : std_logic;	
     --signal clkc,wrenh: std_logic;
     signal wrenh,wrenh2	: STD_LOGIC := '1';
     signal qch,qch2,js,inj2: STD_LOGIC_VECTOR(N-1 downto 0);	
     signal qhere : STD_LOGIC_VECTOR (7 DOWNTO 0);							

begin

    clk <= CLOCK_50;
    reset_n <= KEY(3);

    UUIT1: counter PORT MAP(
            --counter
            clkc => clk,
            reset => reset_n or reset_i2,
            qc => qch);
    UUIT2: s_memory PORT MAP(
            --s_memory
            address => qch,
            clock => clk,
            data => qch,
            wren => wrenh,
            q => qhere);
    UUIT3: SevenSegmentDisplayDecoder PORT MAP(
            --7segment
            ssOut => HEX0,
            nIn => qhere(3 DOWNTO 0)
            );
    UUIT4: Jreg PORT MAP(
            clkj => clk,
            resetj => reset_n,
            enj => enj2,
            inj => inj2,
            i_intoj => qch,
            outj =>js
            );

    UUIT5: statemachine PORT MAP(
        q => qhere,
        q_m=> qhere,
        clks=> clk,
        resets=> reset_n ,
        wren=> wrenh2,
        wren_d=> wrenh2,
        reset_i=> reset_i2,
        enj=> enj2,
        jin=> inj2,
        data=> qch2,
        address=> qch2,
        address_d=> qch2,
        data_d=> qch2,
        address_m=> qch2
    );

end RTL;


