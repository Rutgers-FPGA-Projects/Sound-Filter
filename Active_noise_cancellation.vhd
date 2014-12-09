LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity Active_noise_cancellation is
port(
KEY: in std_logic_vector(3 downto 0);
CLOCK_50: in std_logic;
AUD_ADCDAT: in std_logic ;
AUD_DACDAT: out std_logic ;
AUD_ADCLRCK: out std_logic;
AUD_DACLRCK: out std_logic;
AUD_XCK: out std_logic;
AUD_BCLK: out std_logic;
CLOCK_27: in std_logic;
SW: in std_logic_vector(0 downto 0);
LEDR: out std_logic_vector (17 downto 0);
LEDG: out std_logic_vector (8 downto 0);
HEX0, HEX1: out std_LOGIC_VECTOR (6 downto 0)
);
end Active_noise_cancellation;
architecture toplevel of Active_noise_cancellation is
component clockBuffer IS
PORT
(
areset : IN STD_LOGIC := '0';
inclk0 : IN STD_LOGIC := '0';
c0 : OUT STD_LOGIC
);
END component;
component audioPLLClock IS
PORT
(
areset : IN STD_LOGIC := '0';
inclk0 : IN STD_LOGIC := '0';
c0 : OUT STD_LOGIC
);
END component;
component delayCounter is
port(
clock,reset: in std_logic;
resetAdc: out std_logic
);
end component;
component AdcDacController is
port(
reset_n: in std_logic;
clock18MHz_in: in std_logic;
A_to_D: in std_logic;
D_to_A: out std_logic;
bitClock: out std_logic;
D_to_A_LorR: out std_logic;
A_to_D_LorR: out std_logic;
out_select: in std_logic_vector(0 downto 0);
ledr_on : out std_logic_vector(17 downto 0);
hex1_sig : out std_LOGIC_VECTOR(6 downto 0);
hex0_sig : out std_LOGIC_VECTOR (6 downto 0)
);
end component;
signal clock50MHz: std_logic;
signal clock18MHz: std_logic;
signal reset: std_logic;
signal codecreset_n: std_logic;
signal adcDat_sig: std_logic;
signal adcLRCK_sig: std_logic;
signal dacLRCK_sig: std_logic;
signal dacDat_sig: std_logic;
signal bck_sig: std_logic;
signal out_select: std_logic_vector(0 downto 0);
signal ledr_sig : std_LOGIC_VECTOR(17 downto 0);
signal hex0_on, hex1_on : std_LOGIC_VECTOR(6 downto 0);
begin
reset <= not KEY(3);
out_select <= SW(0 downto 0);
clockBufferInstance: clockBuffer port map(reset,CLOCK_50,clock50MHz);
audioPLLClockMap: audioPLLClock port map(reset, CLOCK_27, clock18MHz);
delayCounterMap: delayCounter port map(clock50MHz, reset, codecreset_n);
AdcDacControllerMap: AdcDacController port map(codecreset_n, clock18MHz, adcDat_sig, dacDat_sig,
bck_sig, dacLRCK_sig, adcLRCK_sig, out_select, ledr_sig, hex0_on, hex1_on);
adcDat_sig <= AUD_ADCDAT;
AUD_ADCLRCK <= adcLRCK_sig;
AUD_DACLRCK <= dacLRCK_sig;
AUD_DACDAT <= dacDat_sig;
AUD_XCK <= clock18MHz;
AUD_BCLK <= bck_sig;
LEDR <= ledr_sig ;
LEDG(6) <= reset;
HEX0 <= hex0_on;
HEX1 <= hex1_on;
end toplevel;







library ieee;
use ieee.std_logic_1164.all;
entity AdcDacController is
port(
A_to_D: in std_logic;
A_to_D_LorR: out std_logic;
D_to_A: out std_logic;
D_to_A_LorR: out std_logic;
bitClock: out std_logic;
reset_n: in std_logic;
clock18MHz_in: in std_logic;
out_select: in std_logic_vector(0 downto 0);
ledr_on : out std_logic_vector(17 downto 0);
hex1_sig : out std_LOGIC_VECTOR(6 downto 0);
hex0_sig : out std_LOGIC_VECTOR (6 downto 0)
);
end AdcDacController;

architecture behavior of AdcDacController is
component lms is
port( 
	 
        clk                         	   :   in    std_logic;
        reset                             :   in    std_logic;
        clk_enable                        :   in    std_logic;
        input                             :   in    std_logic_vector(15 downto 0); 
        desired                           :   in    std_logic_vector(15 downto 0); 
        step_size                         :   in    std_logic_vector(15 downto 0); 
        reset_weights                     :   in    std_logic;
        ce_out                            :   out   std_logic;
        error_out                         :   out   std_logic_vector(15 downto 0) 
		  
        );
		  
end component;   
component bclk_counter is
port(
reset: in std_logic;
mclk: in std_logic;
bclk: out std_logic
);
end component;
component LRchannelCounter is
port(
reset: in std_logic;
bclk: in std_logic;
LRchannel: out std_logic
);
end component;
signal reset: std_logic;
signal bitClock_sig: std_logic;
signal LRchannel_sig: std_logic;
signal bitCounter: integer range 15 downto 0 := 15;
signal reset_1									  :  std_logic := '0';
signal clk                         	     :  std_logic;
signal clk_enable                        :  std_logic :='1';
signal input                             :  std_logic_vector(15 downto 0); 
signal desired                           :  std_logic_vector(15 downto 0); 
signal step_size                         :  std_logic_vector(15 downto 0):= "0000000000000100"; 
signal reset_weights                     :  std_logic:= '0';
signal ce_out                            :  std_logic;
signal error_out                         :  std_logic_vector(15 downto 0);
begin
reset <= not reset_n;
bclk_counterMap: bclk_counter port map(reset, clock18MHz_in, bitClock_sig);
LRchannelCounterMap: LRchannelCounter port map(reset, bitClock_sig, LRchannel_sig);
bitClock <= bitClock_sig;
D_to_A_LorR <= LRchannel_sig;
A_to_D_LorR <= LRchannel_sig;
process(bitClock_sig, bitCounter)
begin
if rising_edge(bitClock_sig) then
if bitCounter > 0 then
bitCounter <= bitCounter - 1;
else
bitCounter <= 15;
end if;
end if;
end process;
process(A_to_D, out_select)
begin
if out_select = "0" then
D_to_A <= A_to_D;
ledr_on(17 downto 0) <= "000000000000000000";
hex1_sig (6 downto 0) <= "1111111";	
hex0_sig (6 downto 0) <= "1111111";
elsif out_select = "1" then
D_to_A <= not A_to_D;
ledr_on(17 downto 0) <= "111111111111111111";
hex1_sig (6 downto 0) <= "0101011";	
hex0_sig (6 downto 0) <= "1000000";
end if;
end process;
end behavior;





library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delayCounter is
port(
	clock,reset: in std_logic;
		resetAdc: out std_logic
);
end delayCounter;

architecture behavior of delayCounter is
signal count: integer range 0 to 20000000;
signal output: std_logic;
begin
process(clock,reset,output)
begin
if (reset = '0') then
if rising_edge(clock) then
if output = '0' then
if count = 20000000 then 
count <= 0;
output <= '1';
else
count <= count + 1;
end if;
end if;
end if;
else
count <= 0;
output <= '0';
end if;
end process;
resetAdc <= output;
end behavior;


-- This lms entity is generated from MATLAB HDL CODER 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lms is 

  port( 
	 
        clk                         	   :   in    std_logic;
        reset                             :   in    std_logic;
        clk_enable                        :   in    std_logic;
        input                             :   in    std_logic_vector(15 downto 0); 
        desired                           :   in    std_logic_vector(15 downto 0); 
        step_size                         :   in    std_logic_vector(15 downto 0); 
        reset_weights                     :   in    std_logic;
        ce_out                            :   out   std_logic;
        error_out                         :   out   std_logic_vector(15 downto 0) 
		  
        );
		  
end lms;

architecture rtl of lms is

  
  
component lmsx10_1

    port(
			
			clk                              :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0); 
          step_size                       :   in    std_logic_vector(31 downto 0); 
          reset_weights                   :   in    std_logic;
          sum_in                          :   in    std_logic_vector(31 downto 0);
          delay_out                       :   out   std_logic_vector(15 downto 0);  
          sum_out                         :   out   std_logic_vector(31 downto 0)
			 
        
		  );

end component;

component lmsx10_2

    port( 
			 clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  
          step_size                       :   in    std_logic_vector(31 downto 0);  
          reset_weights                   :   in    std_logic;
          sum_in                          :   in    std_logic_vector(31 downto 0);  
          delay_out                       :   out   std_logic_vector(15 downto 0); 
          sum_out                         :   out   std_logic_vector(31 downto 0)  
			 
          );
			 
end component;

component lmsx10_3

	port( 
			 clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);
          step_size                       :   in    std_logic_vector(31 downto 0);  
          reset_weights                   :   in    std_logic;
          sum_in                          :   in    std_logic_vector(31 downto 0);  
          delay_out                       :   out   std_logic_vector(15 downto 0);  
          sum_out                         :   out   std_logic_vector(31 downto 0) 
			 
        
		  );

end component;

component lmsx10_4


    port( 
			 
			 clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  
          step_size                       :   in    std_logic_vector(31 downto 0); 
          reset_weights                   :   in    std_logic;
          sum_in                          :   in    std_logic_vector(31 downto 0);  
          delay_out                       :   out   std_logic_vector(15 downto 0); 
          sum_out                         :   out   std_logic_vector(31 downto 0)  
			 
			 
          );
end component;

 
  
  for all : lmsx10_1
  
    use entity work.lmsx10_1(rtl);

  for all : lmsx10_2
    use entity work.lmsx10_2(rtl);

  for all : lmsx10_3
    use entity work.lmsx10_3(rtl);

  for all : lmsx10_4
    use entity work.lmsx10_4(rtl);

  
  
  signal enb                              : std_logic;
  signal enb_1_1_1                        : std_logic;
  
  signal desired_signed                   : signed(15 downto 0); 
  signal desired_reg_out1                 : signed(15 downto 0); 
  signal input_signed                     : signed(15 downto 0); 
  signal input_reg_out1                   : signed(15 downto 0);  
  
  signal input_reg_out1_1                 : std_logic_vector(15 downto 0);
  
  signal step_size_signed                 : signed(15 downto 0); 
  signal sum_out1                         : signed(15 downto 0); 
  signal product_out1                     : signed(31 downto 0); 
  signal mul_temp                         : signed(31 downto 0); 
  
  signal product_out1_1                   : std_logic_vector(31 downto 0); 
  
  signal constant_out1                    : signed(31 downto 0);
  
  signal constant_out1_1                  : std_logic_vector(31 downto 0);  
  signal lmsx10_1_out1                    : std_logic_vector(15 downto 0);  
  signal lmsx10_1_out2                    : std_logic_vector(31 downto 0); 
  signal product_out1_2                   : std_logic_vector(31 downto 0); 
  signal lmsx10_2_out1                    : std_logic_vector(15 downto 0); 
  signal lmsx10_2_out2                    : std_logic_vector(31 downto 0);  
  signal product_out1_3                   : std_logic_vector(31 downto 0); 
  signal lmsx10_3_out1                    : std_logic_vector(15 downto 0); 
  signal lmsx10_3_out2                    : std_logic_vector(31 downto 0); 
  signal product_out1_4                   : std_logic_vector(31 downto 0);  
  signal lmsx10_4_out1                    : std_logic_vector(15 downto 0);
  signal lmsx10_4_out2                    : std_logic_vector(31 downto 0); 
  
  signal lmsx10_4_out2_signed             : signed(31 downto 0);  
  signal sub_cast                         : signed(16 downto 0); 
  signal sub_cast_1                       : signed(15 downto 0);  
  signal sub_cast_2                       : signed(16 downto 0); 
  signal sub_temp                         : signed(16 downto 0); 
  signal error_out_reg_out1               : signed(15 downto 0);  
  signal lmsx10_4_out1_signed             : signed(15 downto 0); 

begin

  u_lmsx10_1 : lmsx10_1
  
  
   port map
		
		(
				
				 clk				 =>	   clk,
				 reset 			 =>	   reset,
				 enb 				 => 	   enb,
				 data_in			 => 	   input_reg_out1_1,  
				 step_size		 =>      product_out1_1, 
				 reset_weights  =>      reset_weights,
				 sum_in			 =>      constant_out1_1,
				 delay_out		 =>      lmsx10_1_out1, 
				 sum_out 		 =>      lmsx10_1_out2  
				 
       );

  u_lmsx10_2 : lmsx10_2
  
  
    port map
     
		(
				 clk 			    =>	 clk,
				 reset			 => 	 reset,
				 enb			 	 => 	 enb,
				 data_in 		 => 	 lmsx10_1_out1, 
				 step_size 		 => 	 product_out1_2, 
				 reset_weights  =>    reset_weights,
				 sum_in			 =>    lmsx10_1_out2, 
				 delay_out 		 =>    lmsx10_2_out1,  
				 sum_out 		 =>    lmsx10_2_out2  
				 
       );

  u_lmsx10_3 : lmsx10_3

    port map
	 
      (
		 
				 clk			 => 		clk,
				 reset 			 => 		reset,
				 enb			 =>		enb,
				 data_in		 => 		lmsx10_2_out1,  
				 step_size 		 => 		product_out1_3, 
				 reset_weights 		 => 		reset_weights,
				 sum_in 		 => 		lmsx10_2_out2,  
				 delay_out		 => 		lmsx10_3_out1,  
				 sum_out 		 => 		lmsx10_3_out2  
       );

  u_lmsx10_4 : lmsx10_4
  
   port map
      (
		
				 clk			 	=> 		clk,
				 reset			 => 		reset,
				 enb			 	=> 		enb,
				 data_in			 =>		lmsx10_3_out1,  
				 step_size		 => 		product_out1_4, 
				 reset_weights		 => 		reset_weights,
				 sum_in			 => 		lmsx10_3_out2,  
				 delay_out		 => 		lmsx10_4_out1, 
				 sum_out		 => 		lmsx10_4_out2  
       );
		 
		 
		 
  enb_1_1_1 		   	<= clk_enable;

  ce_out					   <= enb_1_1_1;

  desired_signed        <= signed(desired);
  
  

process (clk, reset)
  
  begin
    
	 if (reset = '1') then
     
				desired_reg_out1 <= to_signed(0, 16);
		
    elsif clk'event and clk = '1' then
	 
				if (enb = '1') then

				desired_reg_out1 <= desired_signed;
		  
				end if;
   end if;
	
 end process;


 enb <= clk_enable;

 input_signed <= signed(input);
 

 process (clk, reset)
 
  begin
  
    if reset = '1' then
    
				input_reg_out1 <= to_signed(0, 16);
				
    elsif clk'event and clk = '1' then
	 
			if (enb = '1') then
			
				input_reg_out1 <= input_signed;
			
			end if;
    
	end if;
	
 end process;


  input_reg_out1_1 		<= 	std_logic_vector(input_reg_out1);

  step_size_signed 		<= 	signed(step_size);

  mul_temp					<= 	step_size_signed * sum_out1;
  
  product_out1				<= 	resize(mul_temp(31 downto 8), 32) + ("0" & mul_temp(7));
  
  product_out1_1 			<= 	std_logic_vector(product_out1);

  constant_out1 			<=		to_signed(0, 32);

  constant_out1_1 		<= 	std_logic_vector(constant_out1);

  product_out1_2 			<= 	std_logic_vector(product_out1);

  product_out1_3 			<= 	std_logic_vector(product_out1);

  product_out1_4		   <= 	std_logic_vector(product_out1);
  

  lmsx10_4_out2_signed 	<= 	signed(lmsx10_4_out2);

  sub_cast 					<= 	resize(desired_reg_out1, 17);
  
  
  
  sub_cast_1 				<= "0111111111111111" when ((lmsx10_4_out2_signed(31) = '0') and (lmsx10_4_out2_signed(30 downto 22) /= "000000000")) or ((lmsx10_4_out2_signed(31) = '0') and (lmsx10_4_out2_signed(22 downto 7) = "0111111111111111")) else
      "1000000000000000" when (lmsx10_4_out2_signed(31) = '1') and (lmsx10_4_out2_signed(30 downto 22) /= "111111111") else
      lmsx10_4_out2_signed(22 downto 7) + ("0" & lmsx10_4_out2_signed(6));
		
  sub_cast_2 <= resize(sub_cast_1, 17);
  sub_temp <= sub_cast - sub_cast_2;
  
  
  sum_out1 <= "0111111111111111" when (sub_temp(16) = '0') and (sub_temp(15) /= '0') else
      "1000000000000000" when (sub_temp(16) = '1') and (sub_temp(15) /= '1') else
      sub_temp(15 downto 0);

  
  process (clk, reset)
  
  begin
  
    if (reset = '1') then
	 
      error_out_reg_out1 <= to_signed(0, 16);
		
    elsif clk'event and clk = '1' then
	 
				if (enb = '1') then
				
					error_out_reg_out1 <= sum_out1;
					
				end if;
    end if;
	 
  end process;

  error_out			 		 <= 	std_logic_vector(error_out_reg_out1);

  lmsx10_4_out1_signed 	 <= 	signed(lmsx10_4_out1);


end rtl;



-- megafunction wizard: %ALTPLL%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altpll 

-- ============================================================
-- File Name: clockBuffer.vhd
-- Megafunction Name(s):
-- 			altpll
--
-- Simulation Library Files(s):
-- 			altera_mf
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 10.0 Build 218 06/27/2010 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2010 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.





LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY clockBuffer IS			
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
END clockBuffer;


ARCHITECTURE SYN OF clockbuffer IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (5 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC ;
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL sub_wire4_bv	: BIT_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (0 DOWNTO 0);



	COMPONENT altpll
	GENERIC (
		clk0_divide_by		: NATURAL;
		clk0_duty_cycle		: NATURAL;
		clk0_multiply_by		: NATURAL;
		clk0_phase_shift		: STRING;
		compensate_clock		: STRING;
		inclk0_input_frequency		: NATURAL;
		intended_device_family		: STRING;
		lpm_hint		: STRING;
		lpm_type		: STRING;
		operation_mode		: STRING;
		port_activeclock		: STRING;
		port_areset		: STRING;
		port_clkbad0		: STRING;
		port_clkbad1		: STRING;
		port_clkloss		: STRING;
		port_clkswitch		: STRING;
		port_configupdate		: STRING;
		port_fbin		: STRING;
		port_inclk0		: STRING;
		port_inclk1		: STRING;
		port_locked		: STRING;
		port_pfdena		: STRING;
		port_phasecounterselect		: STRING;
		port_phasedone		: STRING;
		port_phasestep		: STRING;
		port_phaseupdown		: STRING;
		port_pllena		: STRING;
		port_scanaclr		: STRING;
		port_scanclk		: STRING;
		port_scanclkena		: STRING;
		port_scandata		: STRING;
		port_scandataout		: STRING;
		port_scandone		: STRING;
		port_scanread		: STRING;
		port_scanwrite		: STRING;
		port_clk0		: STRING;
		port_clk1		: STRING;
		port_clk2		: STRING;
		port_clk3		: STRING;
		port_clk4		: STRING;
		port_clk5		: STRING;
		port_clkena0		: STRING;
		port_clkena1		: STRING;
		port_clkena2		: STRING;
		port_clkena3		: STRING;
		port_clkena4		: STRING;
		port_clkena5		: STRING;
		port_extclk0		: STRING;
		port_extclk1		: STRING;
		port_extclk2		: STRING;
		port_extclk3		: STRING
	);
	PORT (
			areset	: IN STD_LOGIC ;
			clk	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
			inclk	: IN STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	sub_wire4_bv(0 DOWNTO 0) <= "0";
	sub_wire4    <= To_stdlogicvector(sub_wire4_bv);
	sub_wire1    <= sub_wire0(0);
	c0    <= sub_wire1;
	sub_wire2    <= inclk0;
	sub_wire3    <= sub_wire4(0 DOWNTO 0) & sub_wire2;

	altpll_component : altpll
	GENERIC MAP (
		clk0_divide_by => 1,
		clk0_duty_cycle => 50,
		clk0_multiply_by => 1,
		clk0_phase_shift => "0",
		compensate_clock => "CLK0",
		inclk0_input_frequency => 20000,
		intended_device_family => "Cyclone II",
		lpm_hint => "CBX_MODULE_PREFIX=clockBuffer",
		lpm_type => "altpll",
		operation_mode => "NORMAL",
		port_activeclock => "PORT_UNUSED",
		port_areset => "PORT_USED",
		port_clkbad0 => "PORT_UNUSED",
		port_clkbad1 => "PORT_UNUSED",
		port_clkloss => "PORT_UNUSED",
		port_clkswitch => "PORT_UNUSED",
		port_configupdate => "PORT_UNUSED",
		port_fbin => "PORT_UNUSED",
		port_inclk0 => "PORT_USED",
		port_inclk1 => "PORT_UNUSED",
		port_locked => "PORT_UNUSED",
		port_pfdena => "PORT_UNUSED",
		port_phasecounterselect => "PORT_UNUSED",
		port_phasedone => "PORT_UNUSED",
		port_phasestep => "PORT_UNUSED",
		port_phaseupdown => "PORT_UNUSED",
		port_pllena => "PORT_UNUSED",
		port_scanaclr => "PORT_UNUSED",
		port_scanclk => "PORT_UNUSED",
		port_scanclkena => "PORT_UNUSED",
		port_scandata => "PORT_UNUSED",
		port_scandataout => "PORT_UNUSED",
		port_scandone => "PORT_UNUSED",
		port_scanread => "PORT_UNUSED",
		port_scanwrite => "PORT_UNUSED",
		port_clk0 => "PORT_USED",
		port_clk1 => "PORT_UNUSED",
		port_clk2 => "PORT_UNUSED",
		port_clk3 => "PORT_UNUSED",
		port_clk4 => "PORT_UNUSED",
		port_clk5 => "PORT_UNUSED",
		port_clkena0 => "PORT_UNUSED",
		port_clkena1 => "PORT_UNUSED",
		port_clkena2 => "PORT_UNUSED",
		port_clkena3 => "PORT_UNUSED",
		port_clkena4 => "PORT_UNUSED",
		port_clkena5 => "PORT_UNUSED",
		port_extclk0 => "PORT_UNUSED",
		port_extclk1 => "PORT_UNUSED",
		port_extclk2 => "PORT_UNUSED",
		port_extclk3 => "PORT_UNUSED"
	)
	PORT MAP (
		areset => areset,
		inclk => sub_wire3,
		clk => sub_wire0
	);



END SYN;



library ieee;
use ieee.std_logic_1164.all;
entity bclk_counter is
port(
reset: in std_logic;
mclk: in std_logic;
bclk: out std_logic
);
end bclk_counter;
architecture behavior of bclk_counter is
signal count: integer range 0 to 5 := 0;
signal output: std_logic := '0';
begin
process(reset, mclk)
begin
if reset = '1' then
count <= 0;
elsif rising_edge(mclk) then
if count < 5 then
count <= count + 1;
else
output <= not output;
count <= 0;
end if;
end if;
end process;
bclk <= output;
end behavior;
library ieee;
use ieee.std_logic_1164.all;
entity LRchannelCounter is
port(
reset: in std_logic;
bclk: in std_logic;
LRchannel: out std_logic
);
end LRchannelCounter;
architecture behavior of LRchannelCounter is
signal count: integer range 0 to 15 := 0;
signal output: std_logic := '1';
begin
process(reset, bclk)
begin
if reset = '1' then
output <= '1';
count <= 0;
elsif falling_edge(bclk) then
if count < 15 then
count <= count + 1;
else
output <= not output;
count <= 0;
end if;
end if;
end process;
LRchannel <= output;
end behavior;




LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY audioPLLClock IS				
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
END audioPLLClock;


ARCHITECTURE SYN OF audiopllclock IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (5 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC ;
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL sub_wire4_bv	: BIT_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (0 DOWNTO 0);



	COMPONENT altpll
	GENERIC (
		clk0_divide_by		: NATURAL;
		clk0_duty_cycle		: NATURAL;
		clk0_multiply_by		: NATURAL;
		clk0_phase_shift		: STRING;
		compensate_clock		: STRING;
		inclk0_input_frequency		: NATURAL;
		intended_device_family		: STRING;
		lpm_hint		: STRING;
		lpm_type		: STRING;
		operation_mode		: STRING;
		port_activeclock		: STRING;
		port_areset		: STRING;
		port_clkbad0		: STRING;
		port_clkbad1		: STRING;
		port_clkloss		: STRING;
		port_clkswitch		: STRING;
		port_configupdate		: STRING;
		port_fbin		: STRING;
		port_inclk0		: STRING;
		port_inclk1		: STRING;
		port_locked		: STRING;
		port_pfdena		: STRING;
		port_phasecounterselect		: STRING;
		port_phasedone		: STRING;
		port_phasestep		: STRING;
		port_phaseupdown		: STRING;
		port_pllena		: STRING;
		port_scanaclr		: STRING;
		port_scanclk		: STRING;
		port_scanclkena		: STRING;
		port_scandata		: STRING;
		port_scandataout		: STRING;
		port_scandone		: STRING;
		port_scanread		: STRING;
		port_scanwrite		: STRING;
		port_clk0		: STRING;
		port_clk1		: STRING;
		port_clk2		: STRING;
		port_clk3		: STRING;
		port_clk4		: STRING;
		port_clk5		: STRING;
		port_clkena0		: STRING;
		port_clkena1		: STRING;
		port_clkena2		: STRING;
		port_clkena3		: STRING;
		port_clkena4		: STRING;
		port_clkena5		: STRING;
		port_extclk0		: STRING;
		port_extclk1		: STRING;
		port_extclk2		: STRING;
		port_extclk3		: STRING
	);
	PORT (
			areset	: IN STD_LOGIC ;
			clk	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
			inclk	: IN STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	sub_wire4_bv(0 DOWNTO 0) <= "0";
	sub_wire4    <= To_stdlogicvector(sub_wire4_bv);
	sub_wire1    <= sub_wire0(0);
	c0    <= sub_wire1;
	sub_wire2    <= inclk0;
	sub_wire3    <= sub_wire4(0 DOWNTO 0) & sub_wire2;

	altpll_component : altpll
	GENERIC MAP (
		clk0_divide_by => 135,
		clk0_duty_cycle => 50,
		clk0_multiply_by => 92,
		clk0_phase_shift => "0",
		compensate_clock => "CLK0",
		inclk0_input_frequency => 37037,
		intended_device_family => "Cyclone II",
		lpm_hint => "CBX_MODULE_PREFIX=audioPLLClock",
		lpm_type => "altpll",
		operation_mode => "NORMAL",
		port_activeclock => "PORT_UNUSED",
		port_areset => "PORT_USED",
		port_clkbad0 => "PORT_UNUSED",
		port_clkbad1 => "PORT_UNUSED",
		port_clkloss => "PORT_UNUSED",
		port_clkswitch => "PORT_UNUSED",
		port_configupdate => "PORT_UNUSED",
		port_fbin => "PORT_UNUSED",
		port_inclk0 => "PORT_USED",
		port_inclk1 => "PORT_UNUSED",
		port_locked => "PORT_UNUSED",
		port_pfdena => "PORT_UNUSED",
		port_phasecounterselect => "PORT_UNUSED",
		port_phasedone => "PORT_UNUSED",
		port_phasestep => "PORT_UNUSED",
		port_phaseupdown => "PORT_UNUSED",
		port_pllena => "PORT_UNUSED",
		port_scanaclr => "PORT_UNUSED",
		port_scanclk => "PORT_UNUSED",
		port_scanclkena => "PORT_UNUSED",
		port_scandata => "PORT_UNUSED",
		port_scandataout => "PORT_UNUSED",
		port_scandone => "PORT_UNUSED",
		port_scanread => "PORT_UNUSED",
		port_scanwrite => "PORT_UNUSED",
		port_clk0 => "PORT_USED",
		port_clk1 => "PORT_UNUSED",
		port_clk2 => "PORT_UNUSED",
		port_clk3 => "PORT_UNUSED",
		port_clk4 => "PORT_UNUSED",
		port_clk5 => "PORT_UNUSED",
		port_clkena0 => "PORT_UNUSED",
		port_clkena1 => "PORT_UNUSED",
		port_clkena2 => "PORT_UNUSED",
		port_clkena3 => "PORT_UNUSED",
		port_clkena4 => "PORT_UNUSED",
		port_clkena5 => "PORT_UNUSED",
		port_extclk0 => "PORT_UNUSED",
		port_extclk1 => "PORT_UNUSED",
		port_extclk2 => "PORT_UNUSED",
		port_extclk3 => "PORT_UNUSED"
	)
	PORT MAP (
		areset => areset,
		inclk => sub_wire3,
		clk => sub_wire0
	);



END SYN;



