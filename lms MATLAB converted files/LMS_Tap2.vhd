

-- -------------------------------------------------------------
--
-- module: lms_tap2
-- source path: hdlcoderlms/lms/lmsx10_1/lms_tap2
-- hierarchy level: 2
--
--
-- -------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lms_tap2 is
  port( clk                               :   in    std_logic;
        reset                             :   in    std_logic;
        enb                               :   in    std_logic;
        data_in                           :   in    std_logic_vector(15 downto 0);  -- sfix16_en13
        step_size                         :   in    std_logic_vector(31 downto 0);  -- sfix32_en20
        reset_weights                     :   in    std_logic;
        delay_out                         :   out   std_logic_vector(15 downto 0);  -- sfix16_en13
        tap_out                           :   out   std_logic_vector(31 downto 0)  -- sfix32_en20
        );
end lms_tap2;


architecture rtl of lms_tap2 is

  -- signals
  signal data_in_signed                   : signed(15 downto 0);  -- sfix16_en13
  signal data_delay1_out1                 : signed(15 downto 0);  -- sfix16_en13
  signal ground_out1                      : signed(15 downto 0);  -- sfix16_en16
  signal step_size_signed                 : signed(31 downto 0);  -- sfix32_en20
  signal product_out1                     : signed(31 downto 0);  -- sfix32_en20
  signal mul_temp                         : signed(47 downto 0);  -- sfix48_en33
  signal coef1_out1                       : signed(15 downto 0);  -- sfix16_en16
  signal sum_out1                         : signed(15 downto 0);  -- sfix16_en16
  signal add_cast                         : signed(32 downto 0);  -- sfix33_en20
  signal add_cast_1                       : signed(32 downto 0);  -- sfix33_en20
  signal add_temp                         : signed(32 downto 0);  -- sfix33_en20
  signal switch_out1                      : signed(15 downto 0);  -- sfix16_en16
  signal product5_out1                    : signed(31 downto 0);  -- sfix32_en20
  signal mul_temp_1                       : signed(31 downto 0);  -- sfix32_en29

begin
  data_in_signed <= signed(data_in);

  data_delay1_process : process (clk, reset)
  begin
    if reset = '1' then
      data_delay1_out1 <= to_signed(0, 16);
    elsif clk'event and clk = '1' then
      if enb = '1' then
        data_delay1_out1 <= data_in_signed;
      end if;
    end if;
  end process data_delay1_process;


  delay_out <= std_logic_vector(data_delay1_out1);

  ground_out1 <= to_signed(0, 16);

  step_size_signed <= signed(step_size);

  mul_temp <= data_in_signed * step_size_signed;
  
  product_out1 <= "01111111111111111111111111111111" when ((mul_temp(47) = '0') and (mul_temp(46 downto 44) /= "000")) or ((mul_temp(47) = '0') and (mul_temp(44 downto 13) = "01111111111111111111111111111111")) else
      "10000000000000000000000000000000" when (mul_temp(47) = '1') and (mul_temp(46 downto 44) /= "111") else
      mul_temp(44 downto 13) + ("0" & mul_temp(12));

  add_cast <= resize(product_out1, 33);
  add_cast_1 <= resize(coef1_out1 & '0' & '0' & '0' & '0', 33);
  add_temp <= add_cast + add_cast_1;
  
  sum_out1 <= "0111111111111111" when ((add_temp(32) = '0') and (add_temp(31 downto 19) /= "0000000000000")) or ((add_temp(32) = '0') and (add_temp(19 downto 4) = "0111111111111111")) else
      "1000000000000000" when (add_temp(32) = '1') and (add_temp(31 downto 19) /= "1111111111111") else
      add_temp(19 downto 4) + ("0" & add_temp(3));

  
  switch_out1 <= ground_out1 when reset_weights /= '0' else
      sum_out1;

  coef1_process : process (clk, reset)
  begin
    if reset = '1' then
      coef1_out1 <= to_signed(0, 16);
    elsif clk'event and clk = '1' then
      if enb = '1' then
        coef1_out1 <= switch_out1;
      end if;
    end if;
  end process coef1_process;


  mul_temp_1 <= data_in_signed * coef1_out1;
  product5_out1 <= resize(mul_temp_1(31 downto 9), 32) + ("0" & mul_temp_1(8));

  tap_out <= std_logic_vector(product5_out1);

end rtl;

