

-- -------------------------------------------------------------
--
-- module: lmsx10_4
-- source path: hdlcoderlms/lms/lmsx10_4
-- hierarchy level: 1
--
--
-- -------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lmsx10_4 is
  port( clk                               :   in    std_logic;
        reset                             :   in    std_logic;
        enb                               :   in    std_logic;
        data_in                           :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
        step_size                         :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
        reset_weights                     :   in    std_logic;
        sum_in                            :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
        delay_out                         :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
        sum_out                           :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
        );
end lmsx10_4;


architecture rtl of lmsx10_4 is

  -- component declarations
  component lms_tap1_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap2_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap3_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap4_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap5_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap6_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap7_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap8_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap9_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  component lms_tap10_block2
    port( clk                             :   in    std_logic;
          reset                           :   in    std_logic;
          enb                             :   in    std_logic;
          data_in                         :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
          step_size                       :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
          reset_weights                   :   in    std_logic;
          delay_out                       :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
          tap_out                         :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
          );
  end component;

  -- component configuration statements
  for all : lms_tap1_block2
    use entity work.lms_tap1_block2(rtl);

  for all : lms_tap2_block2
    use entity work.lms_tap2_block2(rtl);

  for all : lms_tap3_block2
    use entity work.lms_tap3_block2(rtl);

  for all : lms_tap4_block2
    use entity work.lms_tap4_block2(rtl);

  for all : lms_tap5_block2
    use entity work.lms_tap5_block2(rtl);

  for all : lms_tap6_block2
    use entity work.lms_tap6_block2(rtl);

  for all : lms_tap7_block2
    use entity work.lms_tap7_block2(rtl);

  for all : lms_tap8_block2
    use entity work.lms_tap8_block2(rtl);

  for all : lms_tap9_block2
    use entity work.lms_tap9_block2(rtl);

  for all : lms_tap10_block2
    use entity work.lms_tap10_block2(rtl);

  -- signals
  signal lms_tap1_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap1_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap2_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap2_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap3_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap3_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap4_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap4_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap5_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap5_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap6_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap6_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap7_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap7_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap8_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap8_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap9_out1                    : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap9_out2                    : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap10_out1                   : std_logic_vector(15 downto 0);  -- ufix16
  signal lms_tap10_out2                   : std_logic_vector(31 downto 0);  -- ufix32
  signal lms_tap10_out2_signed            : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap9_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap8_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap7_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap6_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap5_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap4_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap3_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap2_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal lms_tap1_out2_signed             : signed(31 downto 0);  -- sfix32_en20
  signal sum_in_signed                    : signed(31 downto 0);  -- sfix32_en20
  signal sum9_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast                         : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_1                       : signed(32 downto 0);  -- sfix33_en20
  signal add_temp                         : signed(32 downto 0);  -- sfix33_en20
  signal sum_out1                         : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_2                       : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_3                       : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_1                       : signed(32 downto 0);  -- sfix33_en20
  signal sum1_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_4                       : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_5                       : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_2                       : signed(32 downto 0);  -- sfix33_en20
  signal sum2_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_6                       : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_7                       : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_3                       : signed(32 downto 0);  -- sfix33_en20
  signal sum3_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_8                       : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_9                       : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_4                       : signed(32 downto 0);  -- sfix33_en20
  signal sum4_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_10                      : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_11                      : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_5                       : signed(32 downto 0);  -- sfix33_en20
  signal sum5_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_12                      : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_13                      : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_6                       : signed(32 downto 0);  -- sfix33_en20
  signal sum6_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_14                      : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_15                      : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_7                       : signed(32 downto 0);  -- sfix33_en20
  signal sum7_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_16                      : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_17                      : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_8                       : signed(32 downto 0);  -- sfix33_en20
  signal sum8_out1                        : signed(31 downto 0);  -- sfix32_en20
  signal add_cast_18                      : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_19                      : signed(32 downto 0);  -- sfix33_en20
  signal add_temp_9                       : signed(32 downto 0);  -- sfix33_en20

begin
  u_lms_tap1 : lms_tap1_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => data_in,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap1_out1,  -- sfix16_en13
       tap_out => lms_tap1_out2  -- sfix32_en20
       );

  u_lms_tap2 : lms_tap2_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap1_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap2_out1,  -- sfix16_en13
       tap_out => lms_tap2_out2  -- sfix32_en20
       );

  u_lms_tap3 : lms_tap3_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap2_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap3_out1,  -- sfix16_en13
       tap_out => lms_tap3_out2  -- sfix32_en20
       );

  u_lms_tap4 : lms_tap4_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap3_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap4_out1,  -- sfix16_en13
       tap_out => lms_tap4_out2  -- sfix32_en20
       );

  u_lms_tap5 : lms_tap5_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap4_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap5_out1,  -- sfix16_en13
       tap_out => lms_tap5_out2  -- sfix32_en20
       );

  u_lms_tap6 : lms_tap6_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap5_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap6_out1,  -- sfix16_en13
       tap_out => lms_tap6_out2  -- sfix32_en20
       );

  u_lms_tap7 : lms_tap7_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap6_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap7_out1,  -- sfix16_en13
       tap_out => lms_tap7_out2  -- sfix32_en20
       );

  u_lms_tap8 : lms_tap8_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap7_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap8_out1,  -- sfix16_en13
       tap_out => lms_tap8_out2  -- sfix32_en20
       );

  u_lms_tap9 : lms_tap9_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap8_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap9_out1,  -- sfix16_en13
       tap_out => lms_tap9_out2  -- sfix32_en20
       );

  u_lms_tap10 : lms_tap10_block2
    port map
      (clk => clk,
       reset => reset,
       enb => enb,
       data_in => lms_tap9_out1,  -- sfix16_en13
       step_size => step_size,  -- sfix32_en20
       reset_weights => reset_weights,
       delay_out => lms_tap10_out1,  -- sfix16_en13
       tap_out => lms_tap10_out2  -- sfix32_en20
       );
  delay_out <= lms_tap10_out1;

  lms_tap10_out2_signed <= signed(lms_tap10_out2);

  lms_tap9_out2_signed <= signed(lms_tap9_out2);

  lms_tap8_out2_signed <= signed(lms_tap8_out2);

  lms_tap7_out2_signed <= signed(lms_tap7_out2);

  lms_tap6_out2_signed <= signed(lms_tap6_out2);

  lms_tap5_out2_signed <= signed(lms_tap5_out2);

  lms_tap4_out2_signed <= signed(lms_tap4_out2);

  lms_tap3_out2_signed <= signed(lms_tap3_out2);

  lms_tap2_out2_signed <= signed(lms_tap2_out2);

  lms_tap1_out2_signed <= signed(lms_tap1_out2);

  sum_in_signed <= signed(sum_in);

  add_cast <= resize(lms_tap1_out2_signed, 33);
  add_cast_1 <= resize(sum_in_signed, 33);
  add_temp <= add_cast + add_cast_1;
  
  sum9_out1 <= "01111111111111111111111111111111" when (add_temp(32) = '0') and (add_temp(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp(32) = '1') and (add_temp(31) /= '1') else
      add_temp(31 downto 0);

  add_cast_2 <= resize(lms_tap2_out2_signed, 33);
  add_cast_3 <= resize(sum9_out1, 33);
  add_temp_1 <= add_cast_2 + add_cast_3;
  
  sum_out1 <= "01111111111111111111111111111111" when (add_temp_1(32) = '0') and (add_temp_1(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_1(32) = '1') and (add_temp_1(31) /= '1') else
      add_temp_1(31 downto 0);

  add_cast_4 <= resize(lms_tap3_out2_signed, 33);
  add_cast_5 <= resize(sum_out1, 33);
  add_temp_2 <= add_cast_4 + add_cast_5;
  
  sum1_out1 <= "01111111111111111111111111111111" when (add_temp_2(32) = '0') and (add_temp_2(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_2(32) = '1') and (add_temp_2(31) /= '1') else
      add_temp_2(31 downto 0);

  add_cast_6 <= resize(lms_tap4_out2_signed, 33);
  add_cast_7 <= resize(sum1_out1, 33);
  add_temp_3 <= add_cast_6 + add_cast_7;
  
  sum2_out1 <= "01111111111111111111111111111111" when (add_temp_3(32) = '0') and (add_temp_3(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_3(32) = '1') and (add_temp_3(31) /= '1') else
      add_temp_3(31 downto 0);

  add_cast_8 <= resize(lms_tap5_out2_signed, 33);
  add_cast_9 <= resize(sum2_out1, 33);
  add_temp_4 <= add_cast_8 + add_cast_9;
  
  sum3_out1 <= "01111111111111111111111111111111" when (add_temp_4(32) = '0') and (add_temp_4(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_4(32) = '1') and (add_temp_4(31) /= '1') else
      add_temp_4(31 downto 0);

  add_cast_10 <= resize(lms_tap6_out2_signed, 33);
  add_cast_11 <= resize(sum3_out1, 33);
  add_temp_5 <= add_cast_10 + add_cast_11;
  
  sum4_out1 <= "01111111111111111111111111111111" when (add_temp_5(32) = '0') and (add_temp_5(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_5(32) = '1') and (add_temp_5(31) /= '1') else
      add_temp_5(31 downto 0);

  add_cast_12 <= resize(lms_tap7_out2_signed, 33);
  add_cast_13 <= resize(sum4_out1, 33);
  add_temp_6 <= add_cast_12 + add_cast_13;
  
  sum5_out1 <= "01111111111111111111111111111111" when (add_temp_6(32) = '0') and (add_temp_6(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_6(32) = '1') and (add_temp_6(31) /= '1') else
      add_temp_6(31 downto 0);

  add_cast_14 <= resize(lms_tap8_out2_signed, 33);
  add_cast_15 <= resize(sum5_out1, 33);
  add_temp_7 <= add_cast_14 + add_cast_15;
  
  sum6_out1 <= "01111111111111111111111111111111" when (add_temp_7(32) = '0') and (add_temp_7(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_7(32) = '1') and (add_temp_7(31) /= '1') else
      add_temp_7(31 downto 0);

  add_cast_16 <= resize(lms_tap9_out2_signed, 33);
  add_cast_17 <= resize(sum6_out1, 33);
  add_temp_8 <= add_cast_16 + add_cast_17;
  
  sum7_out1 <= "01111111111111111111111111111111" when (add_temp_8(32) = '0') and (add_temp_8(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_8(32) = '1') and (add_temp_8(31) /= '1') else
      add_temp_8(31 downto 0);

  add_cast_18 <= resize(lms_tap10_out2_signed, 33);
  add_cast_19 <= resize(sum7_out1, 33);
  add_temp_9 <= add_cast_18 + add_cast_19;
  
  sum8_out1 <= "01111111111111111111111111111111" when (add_temp_9(32) = '0') and (add_temp_9(31) /= '0') else
      "10000000000000000000000000000000" when (add_temp_9(32) = '1') and (add_temp_9(31) /= '1') else
      add_temp_9(31 downto 0);

  sum_out <= std_logic_vector(sum8_out1);

end rtl;

