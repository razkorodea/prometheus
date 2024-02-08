-------------------------------------------------------------------------------
-- SIAE MICROELETTRONICA
-------------------------------------------------------------------------------
--   FILENAME :   thesis_top.vhd
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

library Ethernet_AXI4s_lib;
use Ethernet_AXI4s_lib.pkg_axi4s_functional.all;
use Ethernet_AXI4s_lib.pkg_axi4s_interface.all;

-- ============================================================================
-- ENTITY
-- ============================================================================

entity thesis_top is
end thesis_top;


-- ============================================================================
-- ARCHITECTURE
-- ============================================================================

architecture rtl of thesis_top is

   ----------------------------------------------------------------------------
   -- CONSTANTS
   ----------------------------------------------------------------------------


   ----------------------------------------------------------------------------
   -- COMPONENTS
   ----------------------------------------------------------------------------
   component axi4s_bus_interconnect_bd
   generic (
      G_LOG2_AXI4_A_BYTE_DATA       : integer range 0 to 7   := 1;
      G_LOG2_AXI4_B_BYTE_DATA       : integer range 0 to 7   := 3;
      DURATA_SYNC_CK_A              : integer range 1 to 256 := 20;
      DURATA_SYNC_CK_B              : integer range 1 to 256 := 20;
      G_USE_FIFO                    : boolean                := TRUE;
      G_FIFO_LOG2_NUM_WORDS_A2B     : natural                := 4;
      G_LOG2_FIFO_READ_EN_THRES_A2B : natural                := 2;
      G_FIFO_LOG2_NUM_WORDS_B2A     : natural                := 4;
      G_LOG2_FIFO_READ_EN_THRES_B2A : natural                := 2;
      REGENERATOR_ON_IF_A           : boolean                := FALSE;
      REGENERATOR_ON_IF_B           : boolean                := FALSE;
      STATIC_TREADY_A               : boolean                := FALSE;                                                                                                          --Da mettere a TRUE solo se TREADY_A è statico (o quasi-statico, funzione della sola configurazione); semplifica la logica di lettura e registra l'uscita della FIFO
      STATIC_TREADY_B               : boolean                := FALSE;                                                                                                          --Da mettere a TRUE solo se TREADY_B è statico (o quasi-statico, funzione della sola configurazione); semplifica la logica di lettura e registra l'uscita della FIFO
      G_NUM_BIT_EXTRA_INFO          : integer                := 1
   );
   port (
      axi4s_a_ctrl_in                : in  tipo_axi4s_ctrl ;
      axi4s_a_data_in                : in  tipo_axi4s_data 
                                       (2**G_LOG2_AXI4_A_BYTE_DATA-1 downto 0);
      axi4s_a_tready_in              : in  std_logic ;
      axi4s_b_ctrl_in                : in  tipo_axi4s_ctrl ;
      axi4s_b_data_in                : in  tipo_axi4s_data 
                                       (2**G_LOG2_AXI4_B_BYTE_DATA-1 downto 0);
      axi4s_b_tready_in              : in  std_logic ;
      ck_a_m                         : in  std_logic ;
      ck_a_s                         : in  std_logic ;
      ck_b_m                         : in  std_logic ;
      ck_b_s                         : in  std_logic ;
      eth_axi4s_interconnect_from_uc : in  TIPO_ETH_AXI4S_INTERCONNECT_FROM_UC;
      extra_info_a_in                : in  std_logic_vector 
                                       (G_NUM_BIT_EXTRA_INFO-1 downto 0);
      extra_info_b_in                : in  std_logic_vector 
                                       (G_NUM_BIT_EXTRA_INFO-1 downto 0);
      axi4s_a_ctrl_out               : out tipo_axi4s_ctrl ;
      axi4s_a_data_out               : out tipo_axi4s_data 
                                       (2**G_LOG2_AXI4_A_BYTE_DATA-1 downto 0);
      axi4s_a_tready_out             : out std_logic ;
      axi4s_b_ctrl_out               : out tipo_axi4s_ctrl ;
      axi4s_b_data_out               : out tipo_axi4s_data 
                                       (2**G_LOG2_AXI4_B_BYTE_DATA-1 downto 0);
      axi4s_b_tready_out             : out std_logic ;
      eth_axi4s_interconnect_to_uc   : out TIPO_ETH_AXI4S_INTERCONNECT_TO_UC;
      extra_info_a_out               : out std_logic_vector 
                                       (G_NUM_BIT_EXTRA_INFO-1 downto 0);
      extra_info_b_out               : out std_logic_vector 
                                       (G_NUM_BIT_EXTRA_INFO-1 downto 0)
   );
   end component axi4s_bus_interconnect_bd;
   ----------------------------------------------------------------------------
   component gmii_axi4s_interface_top
   generic (
      G_LOG2_GMII_N_BYTE_DATA : integer range 0 to 1  := 0;
      IFG                     : integer range 1 to 15 := 11;
      DUAL_CLOCK              : boolean               := FALSE
   );
   port (
      axi4s_ctrl_in          : in  tipo_axi4s_ctrl ;
      axi4s_data_in          : in  tipo_axi4s_data 
                              (2**G_LOG2_GMII_N_BYTE_DATA-1 downto 0);
      axi4s_tready_in        : in  std_logic ;
      ck_gmii_rx             : in  std_logic ;
      ck_gmii_tx             : in  std_logic ;
      ck_micro               : in  std_logic ;
      eth_axi4s_gmii_from_uc : in  TIPO_ETH_AXI4S_GMII_FROM_UC ;
      force_external_loop    : in  std_logic  := '0';
      gmii_rx_dv             : in  std_logic ;
      gmii_rx_er             : in  std_logic ;
      gmii_rx_mod            : in  std_logic ;
      gmii_rxd               : in  std_logic_vector 
                              (((2**G_LOG2_GMII_N_BYTE_DATA)*8)-1 downto 0);
      sgmii_speed_is_100     : in  std_logic  := '0';
      sgmii_speed_is_10_100  : in  std_logic  := '0';
      xcvr_ready_rx          : in  std_logic  := '0';
      xcvr_ready_tx          : in  std_logic  := '0';
      axi4s_ctrl_out         : out tipo_axi4s_ctrl ;
      axi4s_data_out         : out tipo_axi4s_data 
                              (2**G_LOG2_GMII_N_BYTE_DATA-1 downto 0);
      axi4s_tready_out       : out std_logic ;
      eth_axi4s_gmii_to_uc   : out TIPO_ETH_AXI4S_GMII_TO_UC ;
      extra_info_out         : out std_logic_vector (0 downto 0);
      gmii_tx_en             : out std_logic ;
      gmii_tx_er             : out std_logic ;
      gmii_tx_mod            : out std_logic ;
      gmii_txd               : out std_logic_vector 
                              (((2**G_LOG2_GMII_N_BYTE_DATA)*8)-1 downto 0);
      sync_cmd_out_rx        : out std_logic ;
      sync_cmd_out_tx        : out std_logic 
   );
   end component gmii_axi4s_interface_top;
   ----------------------------------------------------------------------------
   component sync_distrib
   generic (
      DURATA_SYNC_CK_IN : integer range 1 to 256 := 20
   );
   port (
      ck           : in  std_logic;
      en_ck        : in  std_logic;
      rst_h        : in  std_logic;
      sync_cmd_out : out std_logic
   );
   end component sync_distrib;

   ----------------------------------------------------------------------------
   -- NETS
   ----------------------------------------------------------------------------


begin

end rtl;