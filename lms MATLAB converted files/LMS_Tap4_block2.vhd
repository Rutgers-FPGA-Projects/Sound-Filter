

-- -------------------------------------------------------------
--
-- Module: LMS_Tap4_block2
-- Source Path: hdlcoderlms/lms/LMSx10_4/LMS_Tap4
-- Hierarchy Level: 2
--
--
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY LMS_Tap4_block2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Data_In                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        Step_Size                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
        Reset_Weights                     :   IN    std_logic;
        Delay_out                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        Tap_out                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
        );
END LMS_Tap4_block2;


ARCHITECTURE rtl OF LMS_Tap4_block2 IS

  -- Signals
  SIGNAL Data_In_signed                   : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Data_Delay1_out1                 : signed(15 DOWNTO 0);  -- sfix16_En13
  SIGNAL Ground_out1                      : signed(15 DOWNTO 0);  -- sfix16_En16
  SIGNAL Step_Size_signed                 : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL Product_out1                     : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL mul_temp                         : signed(47 DOWNTO 0);  -- sfix48_En33
  SIGNAL Coef1_out1                       : signed(15 DOWNTO 0);  -- sfix16_En16
  SIGNAL Sum_out1                         : signed(15 DOWNTO 0);  -- sfix16_En16
  SIGNAL add_cast                         : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_1                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp                         : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Switch_out1                      : signed(15 DOWNTO 0);  -- sfix16_En16
  SIGNAL Product5_out1                    : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL mul_temp_1                       : signed(31 DOWNTO 0);  -- sfix32_En29

BEGIN
  Data_In_signed <= signed(Data_In);

  Data_Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Data_Delay1_out1 <= to_signed(0, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Data_Delay1_out1 <= Data_In_signed;
      END IF;
    END IF;
  END PROCESS Data_Delay1_process;


  Delay_out <= std_logic_vector(Data_Delay1_out1);

  Ground_out1 <= to_signed(0, 16);

  Step_Size_signed <= signed(Step_Size);

  mul_temp <= Data_In_signed * Step_Size_signed;
  
  Product_out1 <= "01111111111111111111111111111111" WHEN ((mul_temp(47) = '0') AND (mul_temp(46 DOWNTO 44) /= "000")) OR ((mul_temp(47) = '0') AND (mul_temp(44 DOWNTO 13) = "01111111111111111111111111111111")) ELSE
      "10000000000000000000000000000000" WHEN (mul_temp(47) = '1') AND (mul_temp(46 DOWNTO 44) /= "111") ELSE
      mul_temp(44 DOWNTO 13) + ("0" & mul_temp(12));

  add_cast <= resize(Product_out1, 33);
  add_cast_1 <= resize(Coef1_out1 & '0' & '0' & '0' & '0', 33);
  add_temp <= add_cast + add_cast_1;
  
  Sum_out1 <= "0111111111111111" WHEN ((add_temp(32) = '0') AND (add_temp(31 DOWNTO 19) /= "0000000000000")) OR ((add_temp(32) = '0') AND (add_temp(19 DOWNTO 4) = "0111111111111111")) ELSE
      "1000000000000000" WHEN (add_temp(32) = '1') AND (add_temp(31 DOWNTO 19) /= "1111111111111") ELSE
      add_temp(19 DOWNTO 4) + ("0" & add_temp(3));

  
  Switch_out1 <= Ground_out1 WHEN Reset_Weights /= '0' ELSE
      Sum_out1;

  Coef1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Coef1_out1 <= to_signed(0, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Coef1_out1 <= Switch_out1;
      END IF;
    END IF;
  END PROCESS Coef1_process;


  mul_temp_1 <= Data_In_signed * Coef1_out1;
  Product5_out1 <= resize(mul_temp_1(31 DOWNTO 9), 32) + ("0" & mul_temp_1(8));

  Tap_out <= std_logic_vector(Product5_out1);

END rtl;

