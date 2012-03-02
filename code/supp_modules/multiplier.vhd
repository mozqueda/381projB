library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


---------------------------
-- The 32-bit Multiplier --
---------------------------
-- By Juan Mozqueda and John Ryan

entity multiplier is
  port(i_A  : in std_logic_vector(31 downto 0);
       i_B  : in std_logic_vector(31 downto 0);
       o_Result : out std_logic_vector(31 downto 0));
end multiplier;

architecture structure of multiplier is

       
component arr_mult_hpr
  port(i_A :      in std_logic_vector(31 downto 0);
       i_B :      in std_logic_vector(31 downto 0);
       i_prev :   in std_logic_vector(31 downto 0);
       o_F :      out std_logic_vector(31 downto 0);
       o_cout:   out std_logic);
end component;  


---------------
--- Signals ---
---------------
 

signal product_64    : std_logic_vector(63 downto 0);
signal product_32    : std_logic_vector(31 downto 0);

signal sum_helper1        : std_logic_vector(31 downto 0);
signal sum_helper2        : std_logic_vector(31 downto 0);
signal sum_helper3        : std_logic_vector(31 downto 0);
signal sum_helper4        : std_logic_vector(31 downto 0);
signal sum_helper5        : std_logic_vector(31 downto 0);
signal sum_helper6        : std_logic_vector(31 downto 0);
signal sum_helper7        : std_logic_vector(31 downto 0);
signal sum_helper8        : std_logic_vector(31 downto 0);
signal sum_helper9        : std_logic_vector(31 downto 0);
signal sum_helper10        : std_logic_vector(31 downto 0);
signal sum_helper11        : std_logic_vector(31 downto 0);
signal sum_helper12        : std_logic_vector(31 downto 0);
signal sum_helper13        : std_logic_vector(31 downto 0);
signal sum_helper14        : std_logic_vector(31 downto 0);
signal sum_helper15        : std_logic_vector(31 downto 0);
signal sum_helper16        : std_logic_vector(31 downto 0);
signal sum_helper17        : std_logic_vector(31 downto 0);
signal sum_helper18        : std_logic_vector(31 downto 0);
signal sum_helper19        : std_logic_vector(31 downto 0);
signal sum_helper20        : std_logic_vector(31 downto 0);
signal sum_helper21        : std_logic_vector(31 downto 0);
signal sum_helper22        : std_logic_vector(31 downto 0);
signal sum_helper23        : std_logic_vector(31 downto 0);
signal sum_helper24        : std_logic_vector(31 downto 0);
signal sum_helper25        : std_logic_vector(31 downto 0);
signal sum_helper26        : std_logic_vector(31 downto 0);
signal sum_helper27        : std_logic_vector(31 downto 0);
signal sum_helper28        : std_logic_vector(31 downto 0);
signal sum_helper29        : std_logic_vector(31 downto 0);
signal sum_helper30        : std_logic_vector(31 downto 0);
signal sum_helper31        : std_logic_vector(31 downto 0);


signal o_F_0       : std_logic_vector(31 downto 0);
signal o_F_1       : std_logic_vector(31 downto 0);
signal o_F_2       : std_logic_vector(31 downto 0);
signal o_F_3       : std_logic_vector(31 downto 0);
signal o_F_4       : std_logic_vector(31 downto 0);
signal o_F_5       : std_logic_vector(31 downto 0);
signal o_F_6       : std_logic_vector(31 downto 0);
signal o_F_7       : std_logic_vector(31 downto 0);
signal o_F_8       : std_logic_vector(31 downto 0);
signal o_F_9       : std_logic_vector(31 downto 0);
signal o_F_10       : std_logic_vector(31 downto 0);
signal o_F_11       : std_logic_vector(31 downto 0);
signal o_F_12       : std_logic_vector(31 downto 0);
signal o_F_13       : std_logic_vector(31 downto 0);
signal o_F_14       : std_logic_vector(31 downto 0);
signal o_F_15       : std_logic_vector(31 downto 0);
signal o_F_16       : std_logic_vector(31 downto 0);
signal o_F_17       : std_logic_vector(31 downto 0);
signal o_F_18       : std_logic_vector(31 downto 0);
signal o_F_19       : std_logic_vector(31 downto 0);
signal o_F_20       : std_logic_vector(31 downto 0);
signal o_F_21       : std_logic_vector(31 downto 0);
signal o_F_22       : std_logic_vector(31 downto 0);
signal o_F_23       : std_logic_vector(31 downto 0);
signal o_F_24       : std_logic_vector(31 downto 0);
signal o_F_25       : std_logic_vector(31 downto 0);
signal o_F_26       : std_logic_vector(31 downto 0);
signal o_F_27       : std_logic_vector(31 downto 0);
signal o_F_28       : std_logic_vector(31 downto 0);
signal o_F_29       : std_logic_vector(31 downto 0);
signal o_F_30       : std_logic_vector(31 downto 0);
signal o_F_31       : std_logic_vector(31 downto 0);



signal o_carry_0 : std_logic;
signal o_carry_1 : std_logic;
signal o_carry_2 : std_logic;
signal o_carry_3 : std_logic;
signal o_carry_4 : std_logic;
signal o_carry_5 : std_logic;
signal o_carry_6 : std_logic;
signal o_carry_7 : std_logic;
signal o_carry_8 : std_logic;
signal o_carry_9 : std_logic;
signal o_carry_10 : std_logic;
signal o_carry_11 : std_logic;
signal o_carry_12 : std_logic;
signal o_carry_13 : std_logic;
signal o_carry_14 : std_logic;
signal o_carry_15 : std_logic;
signal o_carry_16 : std_logic;
signal o_carry_17 : std_logic;
signal o_carry_18 : std_logic;
signal o_carry_19 : std_logic;
signal o_carry_20 : std_logic;
signal o_carry_21 : std_logic;
signal o_carry_22 : std_logic;
signal o_carry_23 : std_logic;
signal o_carry_24 : std_logic;
signal o_carry_25 : std_logic;
signal o_carry_26 : std_logic;
signal o_carry_27 : std_logic;
signal o_carry_28 : std_logic;
signal o_carry_29 : std_logic;
signal o_carry_30 : std_logic;
signal o_carry_31 : std_logic;


signal B_mult_0  : std_logic_vector(31 downto 0);
signal B_mult_1  : std_logic_vector(31 downto 0);
signal B_mult_2  : std_logic_vector(31 downto 0);
signal B_mult_3  : std_logic_vector(31 downto 0);
signal B_mult_4  : std_logic_vector(31 downto 0);
signal B_mult_5  : std_logic_vector(31 downto 0);
signal B_mult_6  : std_logic_vector(31 downto 0);
signal B_mult_7  : std_logic_vector(31 downto 0);
signal B_mult_8  : std_logic_vector(31 downto 0);
signal B_mult_9  : std_logic_vector(31 downto 0);
signal B_mult_10  : std_logic_vector(31 downto 0);
signal B_mult_11  : std_logic_vector(31 downto 0);
signal B_mult_12  : std_logic_vector(31 downto 0);
signal B_mult_13  : std_logic_vector(31 downto 0);
signal B_mult_14  : std_logic_vector(31 downto 0);
signal B_mult_15  : std_logic_vector(31 downto 0);
signal B_mult_16  : std_logic_vector(31 downto 0);
signal B_mult_17  : std_logic_vector(31 downto 0);
signal B_mult_18  : std_logic_vector(31 downto 0);
signal B_mult_19  : std_logic_vector(31 downto 0);
signal B_mult_20  : std_logic_vector(31 downto 0);
signal B_mult_21  : std_logic_vector(31 downto 0);
signal B_mult_22  : std_logic_vector(31 downto 0);
signal B_mult_23  : std_logic_vector(31 downto 0);
signal B_mult_24  : std_logic_vector(31 downto 0);
signal B_mult_25  : std_logic_vector(31 downto 0);
signal B_mult_26  : std_logic_vector(31 downto 0);
signal B_mult_27  : std_logic_vector(31 downto 0);
signal B_mult_28  : std_logic_vector(31 downto 0);
signal B_mult_29  : std_logic_vector(31 downto 0);
signal B_mult_30  : std_logic_vector(31 downto 0);
signal B_mult_31  : std_logic_vector(31 downto 0);


---------------
-- Structure --
---------------

begin
 
 -- Create the first array multiplier -- 
  
  
  G0: for i in 0 to 31 generate
    B_mult_0(i) <= i_B(0); 
  end generate; 
  
  mult_hpr0: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_0,
    i_prev  =>  x"00000000",
    o_F     =>  o_F_0,
    o_cout  =>  o_carry_0);
    
  --------
  
  G1: for i in 0 to 31 generate
    B_mult_1(i) <= i_B(1); 
  end generate; 
  
  sum_helper1 <= o_carry_0 & o_F_0(31 downto 1);
  
  mult_hpr1: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_1,
    i_prev  =>  sum_helper1,
    o_F     =>  o_F_1,
    o_cout  =>  o_carry_1);
    
  --------  

  G2: for i in 0 to 31 generate
    B_mult_2(i) <= i_B(2); 
  end generate; 
  
  sum_helper2 <= o_carry_1 & o_F_1(31 downto 1);
  
  mult_hpr2: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_2,
    i_prev  =>  sum_helper2,
    o_F     =>  o_F_2,
    o_cout  =>  o_carry_2);
 
  --------  

  G3: for i in 0 to 31 generate
    B_mult_3(i) <= i_B(3); 
  end generate; 
  
  sum_helper3 <= o_carry_2 & o_F_2(31 downto 1);
  
  mult_hpr3: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_3,
    i_prev  =>  sum_helper3,
    o_F     =>  o_F_3,
    o_cout  =>  o_carry_3);

  --------  

  G4: for i in 0 to 31 generate
    B_mult_4(i) <= i_B(4); 
  end generate; 
  
  sum_helper4 <= o_carry_3 & o_F_3(31 downto 1);
  
  mult_hpr4: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_4,
    i_prev  =>  sum_helper4,
    o_F     =>  o_F_4,
    o_cout  =>  o_carry_4);

  --------  

  G5: for i in 0 to 31 generate
    B_mult_5(i) <= i_B(5); 
  end generate; 
  
  sum_helper5 <= o_carry_4 & o_F_4(31 downto 1);
  
  mult_hpr5: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_5,
    i_prev  =>  sum_helper5,
    o_F     =>  o_F_5,
    o_cout  =>  o_carry_5);

  --------  

  G6: for i in 0 to 31 generate
    B_mult_6(i) <= i_B(6); 
  end generate; 
  
  sum_helper6 <= o_carry_5 & o_F_5(31 downto 1);
  
  mult_hpr6: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_6,
    i_prev  =>  sum_helper6,
    o_F     =>  o_F_6,
    o_cout  =>  o_carry_6);

  --------  

  G7: for i in 0 to 31 generate
    B_mult_7(i) <= i_B(7); 
  end generate; 
  
  sum_helper7 <= o_carry_6 & o_F_6(31 downto 1);
  
  mult_hpr7: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_7,
    i_prev  =>  sum_helper7,
    o_F     =>  o_F_7,
    o_cout  =>  o_carry_7);  

  --------  

  G8: for i in 0 to 31 generate
    B_mult_8(i) <= i_B(8); 
  end generate; 
  
  sum_helper8 <= o_carry_7 & o_F_7(31 downto 1);
  
  mult_hpr8: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_8,
    i_prev  =>  sum_helper8,
    o_F     =>  o_F_8,
    o_cout  =>  o_carry_8);

  --------  

  G9: for i in 0 to 31 generate
    B_mult_9(i) <= i_B(9); 
  end generate; 
  
  sum_helper9 <= o_carry_8 & o_F_8(31 downto 1);
  
  mult_hpr9: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_9,
    i_prev  =>  sum_helper9,
    o_F     =>  o_F_9,
    o_cout  =>  o_carry_9);
    
  --------  

  G10: for i in 0 to 31 generate
    B_mult_10(i) <= i_B(10); 
  end generate; 
  
  sum_helper10 <= o_carry_9 & o_F_9(31 downto 1);
  
  mult_hpr10: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_10,
    i_prev  =>  sum_helper10,
    o_F     =>  o_F_10,
    o_cout  =>  o_carry_10);    
    
  --------  

  G11: for i in 0 to 31 generate
    B_mult_11(i) <= i_B(11); 
  end generate; 
  
  sum_helper11 <= o_carry_10 & o_F_10(31 downto 1);
  
  mult_hpr11: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_11,
    i_prev  =>  sum_helper11,
    o_F     =>  o_F_11,
    o_cout  =>  o_carry_11);
    
  --------  

  G12: for i in 0 to 31 generate
    B_mult_12(i) <= i_B(12); 
  end generate; 
  
  sum_helper12 <= o_carry_11 & o_F_11(31 downto 1);
  
  mult_hpr12: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_12,
    i_prev  =>  sum_helper12,
    o_F     =>  o_F_12,
    o_cout  =>  o_carry_12);       
 
  --------  

  G13: for i in 0 to 31 generate
    B_mult_13(i) <= i_B(13); 
  end generate; 
  
  sum_helper13 <= o_carry_12 & o_F_12(31 downto 1);
  
  mult_hpr13: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_13,
    i_prev  =>  sum_helper13,
    o_F     =>  o_F_13,
    o_cout  =>  o_carry_13);    
  
  --------  

  G14: for i in 0 to 31 generate
    B_mult_14(i) <= i_B(14); 
  end generate; 
  
  sum_helper14 <= o_carry_13 & o_F_13(31 downto 1);
  
  mult_hpr14: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_14,
    i_prev  =>  sum_helper14,
    o_F     =>  o_F_14,
    o_cout  =>  o_carry_14);          
    
  --------  

  G15: for i in 0 to 31 generate
    B_mult_15(i) <= i_B(15); 
  end generate; 
  
  sum_helper15 <= o_carry_14 & o_F_14(31 downto 1);
  
  mult_hpr15: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_15,
    i_prev  =>  sum_helper15,
    o_F     =>  o_F_15,
    o_cout  =>  o_carry_15);  
    
  --------  

  G16: for i in 0 to 31 generate
    B_mult_16(i) <= i_B(16); 
  end generate; 
  
  sum_helper16 <= o_carry_15 & o_F_15(31 downto 1);
  
  mult_hpr16: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_16,
    i_prev  =>  sum_helper16,
    o_F     =>  o_F_16,
    o_cout  =>  o_carry_16);     
    
  --------  

  G17: for i in 0 to 31 generate
    B_mult_17(i) <= i_B(17); 
  end generate; 
  
  sum_helper17 <= o_carry_16 & o_F_16(31 downto 1);
  
  mult_hpr17: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_17,
    i_prev  =>  sum_helper17,
    o_F     =>  o_F_17,
    o_cout  =>  o_carry_17);    
 
   --------  

  G18: for i in 0 to 31 generate
    B_mult_18(i) <= i_B(18); 
  end generate; 
  
  sum_helper18 <= o_carry_17 & o_F_17(31 downto 1);
  
  mult_hpr18: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_18,
    i_prev  =>  sum_helper18,
    o_F     =>  o_F_18,
    o_cout  =>  o_carry_18);    
 
   --------  

  G19: for i in 0 to 31 generate
    B_mult_19(i) <= i_B(19); 
  end generate; 
  
  sum_helper19 <= o_carry_18 & o_F_18(31 downto 1);
  
  mult_hpr19: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_19,
    i_prev  =>  sum_helper19,
    o_F     =>  o_F_19,
    o_cout  =>  o_carry_19);   
 
   --------  

  G20: for i in 0 to 31 generate
    B_mult_20(i) <= i_B(20); 
  end generate; 
  
  sum_helper20 <= o_carry_19 & o_F_19(31 downto 1);
  
  mult_hpr20: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_20,
    i_prev  =>  sum_helper20,
    o_F     =>  o_F_20,
    o_cout  =>  o_carry_20);   
 
   --------  

  G21: for i in 0 to 31 generate
    B_mult_21(i) <= i_B(21); 
  end generate; 
  
  sum_helper21 <= o_carry_20 & o_F_20(31 downto 1);
  
  mult_hpr21: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_21,
    i_prev  =>  sum_helper21,
    o_F     =>  o_F_21,
    o_cout  =>  o_carry_21); 
 
    --------  

  G22: for i in 0 to 31 generate
    B_mult_22(i) <= i_B(22); 
  end generate; 
  
  sum_helper22 <= o_carry_21 & o_F_21(31 downto 1);
  
  mult_hpr22: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_22,
    i_prev  =>  sum_helper22,
    o_F     =>  o_F_22,
    o_cout  =>  o_carry_22);
    
    
    --------  

  G23: for i in 0 to 31 generate
    B_mult_23(i) <= i_B(23); 
  end generate; 
  
  sum_helper23 <= o_carry_22 & o_F_22(31 downto 1);
  
  mult_hpr23: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_23,
    i_prev  =>  sum_helper23,
    o_F     =>  o_F_23,
    o_cout  =>  o_carry_23);
    
    
  --------  

  G24: for i in 0 to 31 generate
    B_mult_24(i) <= i_B(24); 
  end generate; 
  
  sum_helper24 <= o_carry_23 & o_F_23(31 downto 1);
  
  mult_hpr24: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_24,
    i_prev  =>  sum_helper24,
    o_F     =>  o_F_24,
    o_cout  =>  o_carry_24);  
    
  --------  

  G25: for i in 0 to 31 generate
    B_mult_25(i) <= i_B(25); 
  end generate; 
  
  sum_helper25 <= o_carry_24 & o_F_24(31 downto 1);
  
  mult_hpr25: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_25,
    i_prev  =>  sum_helper25,
    o_F     =>  o_F_25,
    o_cout  =>  o_carry_25);     
    
  --------  

  G26: for i in 0 to 31 generate
    B_mult_26(i) <= i_B(26); 
  end generate; 
  
  sum_helper26 <= o_carry_25 & o_F_25(31 downto 1);
  
  mult_hpr26: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_26,
    i_prev  =>  sum_helper26,
    o_F     =>  o_F_26,
    o_cout  =>  o_carry_26);    
    
  --------  

  G27: for i in 0 to 31 generate
    B_mult_27(i) <= i_B(27); 
  end generate; 
  
  sum_helper27 <= o_carry_26 & o_F_26(31 downto 1);
  
  mult_hpr27: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_27,
    i_prev  =>  sum_helper27,
    o_F     =>  o_F_27,
    o_cout  =>  o_carry_27);      
         
  --------  

  G28: for i in 0 to 31 generate
    B_mult_28(i) <= i_B(28); 
  end generate; 
  
  sum_helper28 <= o_carry_27 & o_F_27(31 downto 1);
  
  mult_hpr28: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_28,
    i_prev  =>  sum_helper28,
    o_F     =>  o_F_28,
    o_cout  =>  o_carry_28);

  --------  

  G29: for i in 0 to 31 generate
    B_mult_29(i) <= i_B(29); 
  end generate; 
  
  sum_helper29 <= o_carry_28 & o_F_28(31 downto 1);
  
  mult_hpr29: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_29,
    i_prev  =>  sum_helper29,
    o_F     =>  o_F_29,
    o_cout  =>  o_carry_29);     
              
  --------  

  G30: for i in 0 to 31 generate
    B_mult_30(i) <= i_B(30); 
  end generate; 
  
  sum_helper30 <= o_carry_29 & o_F_29(31 downto 1);
  
  mult_hpr30: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_30,
    i_prev  =>  sum_helper30,
    o_F     =>  o_F_30,
    o_cout  =>  o_carry_30);   
    
  --------  

  G31: for i in 0 to 31 generate
    B_mult_31(i) <= i_B(31); 
  end generate; 
  
  sum_helper31 <= o_carry_30 & o_F_30(31 downto 1);
  
  mult_hpr31: arr_mult_hpr
  port Map(
    i_A     =>  i_A,
    i_B     =>  B_mult_31,
    i_prev  =>  sum_helper31,
    o_F     =>  o_F_31,
    o_cout  =>  o_carry_31);      
         
  
  
  o_result(0) <= o_F_0(0);
  o_result(1) <= o_F_1(0);
  o_result(2) <= o_F_2(0);
  o_result(3) <= o_F_3(0);
  o_result(4) <= o_F_4(0);
  o_result(5) <= o_F_5(0);
  o_result(6) <= o_F_6(0);
  o_result(7) <= o_F_7(0);
  o_result(8) <= o_F_8(0);
  o_result(9) <= o_F_9(0);
  o_result(10) <= o_F_10(0);
  o_result(11) <= o_F_11(0);
  o_result(12) <= o_F_12(0);
  o_result(13) <= o_F_13(0);
  o_result(14) <= o_F_14(0);
  o_result(15) <= o_F_15(0);
  o_result(16) <= o_F_16(0);
  o_result(17) <= o_F_17(0);
  o_result(18) <= o_F_18(0);
  o_result(19) <= o_F_19(0);
  o_result(20) <= o_F_20(0);
  o_result(21) <= o_F_21(0);
  o_result(22) <= o_F_22(0);
  o_result(23) <= o_F_23(0);
  o_result(24) <= o_F_24(0);   
  o_result(25) <= o_F_25(0);
  o_result(26) <= o_F_26(0);
  o_result(27) <= o_F_27(0);
  o_result(28) <= o_F_28(0);
  o_result(29) <= o_F_29(0);
  o_result(30) <= o_F_30(0);
  o_result(31) <= o_F_31(0);
  
     
      
--  o_Result(0) <= o_F_sum(0);  
    
 --Generate the last 31 array multipliers-- 
  
--  G1: for i in 1 to 31 generate
      
      
--      G2: for j in 0 to 31 generate       
--        B_multiplier(j) <= i_B(i); 
--      end generate; 
      
--      helper <= o_carry_first & o_F_sum(31 downto 1);
      
--      arr_mult_hprs: arr_mult_hpr
 --       port map(i_A    => i_A,
 --               i_B     => B_multiplier,
 --               i_prev  => helper,      
  --              o_F     => o_F_sum,
  --              o_cout => o_carry_first);
  
--    o_Result(i) <= o_F_sum(0);
  
--  end generate; 
    
    
end structure;
    