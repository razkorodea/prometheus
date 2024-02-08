-------------------------------------------------------------------------------
-- SIAE MICROELETTRONICA
-------------------------------------------------------------------------------
--   FILENAME :   thesis_gmii_if.vhd
--
--     AUTHOR :   Gheorghe Balan        
-- START DATE :   xx/yy/zzzz
-------------------------------------------------------------------------------
-- DESCRIPTION 
--		> ...
-------------------------------------------------------------------------------
-- NOTES 
--		> ...
-------------------------------------------------------------------------------
-- CHANGES 
-- 	> ...
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ============================================================================
-- ENTITY
-- ============================================================================

entity thesis_gmii_if is
   port (
      ck             : in  std_logic;
      sync           : in  std_logic;
      ---
      egmii_dv_in    : in  std_logic;
      egmii_er_in    : in  std_logic;
      egmii_dt_in    : in  std_logic_vector (15 downto 0);
      egmii_mod_in   : in  std_logic;
      ---
      egmii_dv_out   : out std_logic;
      egmii_er_out   : out std_logic;
      egmii_dt_out   : out std_logic_vector (15 downto 0);
      egmii_mod_out  : out std_logic;
      ---
      dbg_alfa       : out std_logic
   );
end thesis_gmii_if;


-- ============================================================================
-- ARCHITECTURE
-- ============================================================================

architecture rtl of thesis_gmii_if is

   ----------------------------------------------------------------------------
   -- CONSTANTS
   ----------------------------------------------------------------------------


   ----------------------------------------------------------------------------
   -- COMPONENTS
   ----------------------------------------------------------------------------
   

   ----------------------------------------------------------------------------
   -- NETS
   ----------------------------------------------------------------------------
   signal egmii_dv_net     : std_logic;
   signal egmii_er_net     : std_logic;
   signal egmii_dt_net     : std_logic_vector (15 downto 0);
   signal egmii_md_net     : std_logic;
   
   ----------------------------------------------------------------------------
   -- debug
   ----------------------------------------------------------------------------
   attribute DONT_TOUCH : string;
   attribute MARK_DEBUG : string;
   
   -- attribute DONT_TOUCH of egmii_dv_net   : signal is "true";
   -- attribute DONT_TOUCH of egmii_er_net   : signal is "true";
   -- attribute DONT_TOUCH of egmii_dt_net   : signal is "true";
   -- attribute DONT_TOUCH of egmii_md_net   : signal is "true";
   
   -- attribute MARK_DEBUG of egmii_dv_net   : signal is "true";
   -- attribute MARK_DEBUG of egmii_er_net   : signal is "true";
   -- attribute MARK_DEBUG of egmii_dt_net   : signal is "true";
   -- attribute MARK_DEBUG of egmii_md_net   : signal is "true";

begin
   -----------------------------------------------------------------------------
   -- 
   -----------------------------------------------------------------------------
   egmii_dv_net <= egmii_dv_in ;
   egmii_er_net <= egmii_er_in ;
   egmii_dt_net <= egmii_dt_in ;
   egmii_md_net <= egmii_mod_in;
   
   egmii_dv_out  <= egmii_dv_net;
   egmii_er_out  <= egmii_er_net;
   egmii_dt_out  <= egmii_dt_net;
   egmii_mod_out <= egmii_md_net;

end rtl;