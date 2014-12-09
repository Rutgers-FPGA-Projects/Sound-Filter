

-- -------------------------------------------------------------
--
-- Module: LMSx10_3
-- Source Path: hdlcoderlms/lms/LMSx10_3
-- Hierarchy Level: 1
--
--
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY LMSx10_3 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Data_In                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        Step_Size                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
        Reset_Weights                     :   IN    std_logic;
        Sum_In                            :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
        Delay_Out                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
        Sum_Out                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
        );
END LMSx10_3;


ARCHITECTURE rtl OF LMSx10_3 IS

  -- Component Declarations
  COMPONENT LMS_Tap1_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap2_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap3_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap4_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap5_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap6_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap7_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap8_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap9_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  COMPONENT LMS_Tap10_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Data_In                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Step_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En20
          Reset_Weights                   :   IN    std_logic;
          Delay_out                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En13
          Tap_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En20
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : LMS_Tap1_block1
    USE ENTITY work.LMS_Tap1_block1(rtl);

  FOR ALL : LMS_Tap2_block1
    USE ENTITY work.LMS_Tap2_block1(rtl);

  FOR ALL : LMS_Tap3_block1
    USE ENTITY work.LMS_Tap3_block1(rtl);

  FOR ALL : LMS_Tap4_block1
    USE ENTITY work.LMS_Tap4_block1(rtl);

  FOR ALL : LMS_Tap5_block1
    USE ENTITY work.LMS_Tap5_block1(rtl);

  FOR ALL : LMS_Tap6_block1
    USE ENTITY work.LMS_Tap6_block1(rtl);

  FOR ALL : LMS_Tap7_block1
    USE ENTITY work.LMS_Tap7_block1(rtl);

  FOR ALL : LMS_Tap8_block1
    USE ENTITY work.LMS_Tap8_block1(rtl);

  FOR ALL : LMS_Tap9_block1
    USE ENTITY work.LMS_Tap9_block1(rtl);

  FOR ALL : LMS_Tap10_block1
    USE ENTITY work.LMS_Tap10_block1(rtl);

  -- Signals
  SIGNAL LMS_Tap1_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap1_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap2_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap2_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap3_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap3_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap4_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap4_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap5_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap5_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap6_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap6_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap7_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap7_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap8_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap8_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap9_out1                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap9_out2                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap10_out1                   : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LMS_Tap10_out2                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL LMS_Tap10_out2_signed            : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap9_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap8_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap7_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap6_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap5_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap4_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap3_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap2_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL LMS_Tap1_out2_signed             : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL Sum_In_signed                    : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL Sum9_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast                         : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_1                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp                         : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum_out1                         : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_2                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_3                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_1                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum1_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_4                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_5                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_2                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum2_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_6                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_7                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_3                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum3_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_8                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_9                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_4                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum4_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_10                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_11                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_5                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum5_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_12                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_13                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_6                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum6_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_14                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_15                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_7                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum7_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_16                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_17                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_8                       : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL Sum8_out1                        : signed(31 DOWNTO 0);  -- sfix32_En20
  SIGNAL add_cast_18                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_cast_19                      : signed(32 DOWNTO 0);  -- sfix33_En20
  SIGNAL add_temp_9                       : signed(32 DOWNTO 0);  -- sfix33_En20

BEGIN
  u_LMS_Tap1 : LMS_Tap1_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => Data_In,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap1_out1,  -- sfix16_En13
       Tap_out => LMS_Tap1_out2  -- sfix32_En20
       );

  u_LMS_Tap2 : LMS_Tap2_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap1_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap2_out1,  -- sfix16_En13
       Tap_out => LMS_Tap2_out2  -- sfix32_En20
       );

  u_LMS_Tap3 : LMS_Tap3_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap2_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap3_out1,  -- sfix16_En13
       Tap_out => LMS_Tap3_out2  -- sfix32_En20
       );

  u_LMS_Tap4 : LMS_Tap4_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap3_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap4_out1,  -- sfix16_En13
       Tap_out => LMS_Tap4_out2  -- sfix32_En20
       );

  u_LMS_Tap5 : LMS_Tap5_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap4_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap5_out1,  -- sfix16_En13
       Tap_out => LMS_Tap5_out2  -- sfix32_En20
       );

  u_LMS_Tap6 : LMS_Tap6_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap5_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap6_out1,  -- sfix16_En13
       Tap_out => LMS_Tap6_out2  -- sfix32_En20
       );

  u_LMS_Tap7 : LMS_Tap7_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap6_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap7_out1,  -- sfix16_En13
       Tap_out => LMS_Tap7_out2  -- sfix32_En20
       );

  u_LMS_Tap8 : LMS_Tap8_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap7_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap8_out1,  -- sfix16_En13
       Tap_out => LMS_Tap8_out2  -- sfix32_En20
       );

  u_LMS_Tap9 : LMS_Tap9_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap8_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap9_out1,  -- sfix16_En13
       Tap_out => LMS_Tap9_out2  -- sfix32_En20
       );

  u_LMS_Tap10 : LMS_Tap10_block1
    PORT MAP
      (clk => clk,
       reset => reset,
       enb => enb,
       Data_In => LMS_Tap9_out1,  -- sfix16_En13
       Step_Size => Step_Size,  -- sfix32_En20
       Reset_Weights => Reset_Weights,
       Delay_out => LMS_Tap10_out1,  -- sfix16_En13
       Tap_out => LMS_Tap10_out2  -- sfix32_En20
       );
  Delay_Out <= LMS_Tap10_out1;

  LMS_Tap10_out2_signed <= signed(LMS_Tap10_out2);

  LMS_Tap9_out2_signed <= signed(LMS_Tap9_out2);

  LMS_Tap8_out2_signed <= signed(LMS_Tap8_out2);

  LMS_Tap7_out2_signed <= signed(LMS_Tap7_out2);

  LMS_Tap6_out2_signed <= signed(LMS_Tap6_out2);

  LMS_Tap5_out2_signed <= signed(LMS_Tap5_out2);

  LMS_Tap4_out2_signed <= signed(LMS_Tap4_out2);

  LMS_Tap3_out2_signed <= signed(LMS_Tap3_out2);

  LMS_Tap2_out2_signed <= signed(LMS_Tap2_out2);

  LMS_Tap1_out2_signed <= signed(LMS_Tap1_out2);

  Sum_In_signed <= signed(Sum_In);

  add_cast <= resize(LMS_Tap1_out2_signed, 33);
  add_cast_1 <= resize(Sum_In_signed, 33);
  add_temp <= add_cast + add_cast_1;
  
  Sum9_out1 <= "01111111111111111111111111111111" WHEN (add_temp(32) = '0') AND (add_temp(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp(32) = '1') AND (add_temp(31) /= '1') ELSE
      add_temp(31 DOWNTO 0);

  add_cast_2 <= resize(LMS_Tap2_out2_signed, 33);
  add_cast_3 <= resize(Sum9_out1, 33);
  add_temp_1 <= add_cast_2 + add_cast_3;
  
  Sum_out1 <= "01111111111111111111111111111111" WHEN (add_temp_1(32) = '0') AND (add_temp_1(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_1(32) = '1') AND (add_temp_1(31) /= '1') ELSE
      add_temp_1(31 DOWNTO 0);

  add_cast_4 <= resize(LMS_Tap3_out2_signed, 33);
  add_cast_5 <= resize(Sum_out1, 33);
  add_temp_2 <= add_cast_4 + add_cast_5;
  
  Sum1_out1 <= "01111111111111111111111111111111" WHEN (add_temp_2(32) = '0') AND (add_temp_2(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_2(32) = '1') AND (add_temp_2(31) /= '1') ELSE
      add_temp_2(31 DOWNTO 0);

  add_cast_6 <= resize(LMS_Tap4_out2_signed, 33);
  add_cast_7 <= resize(Sum1_out1, 33);
  add_temp_3 <= add_cast_6 + add_cast_7;
  
  Sum2_out1 <= "01111111111111111111111111111111" WHEN (add_temp_3(32) = '0') AND (add_temp_3(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_3(32) = '1') AND (add_temp_3(31) /= '1') ELSE
      add_temp_3(31 DOWNTO 0);

  add_cast_8 <= resize(LMS_Tap5_out2_signed, 33);
  add_cast_9 <= resize(Sum2_out1, 33);
  add_temp_4 <= add_cast_8 + add_cast_9;
  
  Sum3_out1 <= "01111111111111111111111111111111" WHEN (add_temp_4(32) = '0') AND (add_temp_4(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_4(32) = '1') AND (add_temp_4(31) /= '1') ELSE
      add_temp_4(31 DOWNTO 0);

  add_cast_10 <= resize(LMS_Tap6_out2_signed, 33);
  add_cast_11 <= resize(Sum3_out1, 33);
  add_temp_5 <= add_cast_10 + add_cast_11;
  
  Sum4_out1 <= "01111111111111111111111111111111" WHEN (add_temp_5(32) = '0') AND (add_temp_5(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_5(32) = '1') AND (add_temp_5(31) /= '1') ELSE
      add_temp_5(31 DOWNTO 0);

  add_cast_12 <= resize(LMS_Tap7_out2_signed, 33);
  add_cast_13 <= resize(Sum4_out1, 33);
  add_temp_6 <= add_cast_12 + add_cast_13;
  
  Sum5_out1 <= "01111111111111111111111111111111" WHEN (add_temp_6(32) = '0') AND (add_temp_6(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_6(32) = '1') AND (add_temp_6(31) /= '1') ELSE
      add_temp_6(31 DOWNTO 0);

  add_cast_14 <= resize(LMS_Tap8_out2_signed, 33);
  add_cast_15 <= resize(Sum5_out1, 33);
  add_temp_7 <= add_cast_14 + add_cast_15;
  
  Sum6_out1 <= "01111111111111111111111111111111" WHEN (add_temp_7(32) = '0') AND (add_temp_7(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_7(32) = '1') AND (add_temp_7(31) /= '1') ELSE
      add_temp_7(31 DOWNTO 0);

  add_cast_16 <= resize(LMS_Tap9_out2_signed, 33);
  add_cast_17 <= resize(Sum6_out1, 33);
  add_temp_8 <= add_cast_16 + add_cast_17;
  
  Sum7_out1 <= "01111111111111111111111111111111" WHEN (add_temp_8(32) = '0') AND (add_temp_8(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_8(32) = '1') AND (add_temp_8(31) /= '1') ELSE
      add_temp_8(31 DOWNTO 0);

  add_cast_18 <= resize(LMS_Tap10_out2_signed, 33);
  add_cast_19 <= resize(Sum7_out1, 33);
  add_temp_9 <= add_cast_18 + add_cast_19;
  
  Sum8_out1 <= "01111111111111111111111111111111" WHEN (add_temp_9(32) = '0') AND (add_temp_9(31) /= '0') ELSE
      "10000000000000000000000000000000" WHEN (add_temp_9(32) = '1') AND (add_temp_9(31) /= '1') ELSE
      add_temp_9(31 DOWNTO 0);

  Sum_Out <= std_logic_vector(Sum8_out1);

END rtl;

