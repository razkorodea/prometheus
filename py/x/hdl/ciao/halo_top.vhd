-------------------------------------------------------------------------------
-- SIAE MICROELETTRONICA
-------------------------------------------------------------------------------
--   FILENAME :   halo_top.vhd
--
--     AUTHOR :   Gheorghe Balan        
-- START DATE :   30/08/2023
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

library essa_lib;
use essa_lib.essa_pkg.all;

library siae_packet_pkg_lib;
use siae_packet_pkg_lib.siae_uP_IF_pack.all;

library halo_lib;
use halo_lib.krypto_pkg.all;


-- ============================================================================
-- ENTITY
-- ============================================================================

entity halo_top is
   port (
      clk_100           : in  std_logic;
      rst_n             : in  std_logic;
      HCLK              : in  std_logic;
      HRESETn           : in  std_logic;
      --
      MBDEBUG_Down      : in  XILINX_MBDEBUG_Down;
      MBDEBUG_Up        : out XILINX_MBDEBUG_Up;
      --
      halo_AHBlite_Down : in  AMBA_AHBlite32_Down;
      halo_AHBlite_Up   : out AMBA_AHBlite32_Up;
      sts               : out std_logic
   );
end halo_top;


-- ============================================================================
-- ARCHITECTURE
-- ============================================================================

architecture rtl of halo_top is

   ----------------------------------------------------------------------------
   -- CONSTANTS
   ----------------------------------------------------------------------------


   ----------------------------------------------------------------------------
   -- COMPONENTS
   ----------------------------------------------------------------------------
   component halo_wrapper
      port (
         BRAM_PORTA_addr          : in  std_logic_vector ( 31 downto 0 );
         BRAM_PORTA_clk           : in  std_logic;
         BRAM_PORTA_din           : in  std_logic_vector ( 31 downto 0 );
         BRAM_PORTA_dout          : out std_logic_vector ( 31 downto 0 );
         BRAM_PORTA_en            : in  std_logic;
         BRAM_PORTA_rst           : in  std_logic;
         BRAM_PORTA_we            : in  std_logic_vector ( 3 downto 0 );
         DEBUG_capture            : in  std_logic;
         DEBUG_clk                : in  std_logic;
         DEBUG_disable            : in  std_logic;
         DEBUG_reg_en             : in  std_logic_vector ( 0 to 7 );
         DEBUG_rst                : in  std_logic;
         DEBUG_shift              : in  std_logic;
         DEBUG_tdi                : in  std_logic;
         DEBUG_tdo                : out std_logic;
         DEBUG_trig_ack_in        : in  std_logic_vector ( 0 to 7 );
         DEBUG_trig_ack_out       : out std_logic_vector ( 0 to 7 );
         DEBUG_trig_in            : out std_logic_vector ( 0 to 7 );
         DEBUG_trig_out           : in  std_logic_vector ( 0 to 7 );
         DEBUG_update             : in  std_logic;
         M_AHB_haddr              : out std_logic_vector ( 31 downto 0 );
         M_AHB_hburst             : out std_logic_vector ( 2 downto 0 );
         M_AHB_hmastlock          : out std_logic;
         M_AHB_hprot              : out std_logic_vector ( 3 downto 0 );
         M_AHB_hrdata             : in  std_logic_vector ( 31 downto 0 );
         M_AHB_hready             : in  std_logic;
         M_AHB_hresp              : in  std_logic;
         M_AHB_hsize              : out std_logic_vector ( 2 downto 0 );
         M_AHB_htrans             : out std_logic_vector ( 1 downto 0 );
         M_AHB_hwdata             : out std_logic_vector ( 31 downto 0 );
         M_AHB_hwrite             : out std_logic;
         M_AXI_araddr             : out std_logic_vector ( 31 downto 0 );
         M_AXI_arburst            : out std_logic_vector ( 1 downto 0 );
         M_AXI_arcache            : out std_logic_vector ( 3 downto 0 );
         M_AXI_arlen              : out std_logic_vector ( 7 downto 0 );
         M_AXI_arlock             : out std_logic_vector ( 0 to 0 );
         M_AXI_arprot             : out std_logic_vector ( 2 downto 0 );
         M_AXI_arqos              : out std_logic_vector ( 3 downto 0 );
         M_AXI_arready            : in  std_logic_vector ( 0 to 0 );
         M_AXI_arregion           : out std_logic_vector ( 3 downto 0 );
         M_AXI_arsize             : out std_logic_vector ( 2 downto 0 );
         M_AXI_arvalid            : out std_logic_vector ( 0 to 0 );
         M_AXI_awaddr             : out std_logic_vector ( 31 downto 0 );
         M_AXI_awburst            : out std_logic_vector ( 1 downto 0 );
         M_AXI_awcache            : out std_logic_vector ( 3 downto 0 );
         M_AXI_awlen              : out std_logic_vector ( 7 downto 0 );
         M_AXI_awlock             : out std_logic_vector ( 0 to 0 );
         M_AXI_awprot             : out std_logic_vector ( 2 downto 0 );
         M_AXI_awqos              : out std_logic_vector ( 3 downto 0 );
         M_AXI_awready            : in  std_logic_vector ( 0 to 0 );
         M_AXI_awregion           : out std_logic_vector ( 3 downto 0 );
         M_AXI_awsize             : out std_logic_vector ( 2 downto 0 );
         M_AXI_awvalid            : out std_logic_vector ( 0 to 0 );
         M_AXI_bready             : out std_logic_vector ( 0 to 0 );
         M_AXI_bresp              : in  std_logic_vector ( 1 downto 0 );
         M_AXI_bvalid             : in  std_logic_vector ( 0 to 0 );
         M_AXI_rdata              : in  std_logic_vector ( 31 downto 0 );
         M_AXI_rlast              : in  std_logic_vector ( 0 to 0 );
         M_AXI_rready             : out std_logic_vector ( 0 to 0 );
         M_AXI_rresp              : in  std_logic_vector ( 1 downto 0 );
         M_AXI_rvalid             : in  std_logic_vector ( 0 to 0 );
         M_AXI_wdata              : out std_logic_vector ( 31 downto 0 );
         M_AXI_wlast              : out std_logic_vector ( 0 to 0 );
         M_AXI_wready             : in  std_logic_vector ( 0 to 0 );
         M_AXI_wstrb              : out std_logic_vector ( 3 downto 0 );
         M_AXI_wvalid             : out std_logic_vector ( 0 to 0 );
         clk_100                  : in  std_logic;
         rst_n                    : in  std_logic
      );
   end component;
   ----------------------------------------------------------------------------
   component XILINX_MDEBUG_MasterRec_to_SlaveSplit
   port (
      XILINX_MBDEBUG_Down : in  XILINX_MBDEBUG_Down;
      tdo                 : in  std_logic;
      Sys_Rst             : out std_logic;
      XILINX_MBDEBUG_Up   : out XILINX_MBDEBUG_Up;
      capture             : out std_logic;
      clk                 : out std_logic;
      disable             : out std_logic;
      reg_en              : out std_logic_vector ( 0 to 7 );
      rst                 : out std_logic;
      shift               : out std_logic;
      tdi                 : out std_logic;
      update              : out std_logic
   );
   end component;
   ----------------------------------------------------------------------------
   component XilinxAHBLite2Record
   port (
      -- AMBA AHB-lite 32bit standard I/F signals
      HADDR        : in  std_logic_vector (31 downto 0);
      HBURST       : in  std_logic_vector ( 2 downto 0);
      HMASTLOCK    : in  std_logic ; -- unused
      HPROT        : in  std_logic_vector ( 3 downto 0);
      HSIZE        : in  std_logic_vector ( 2 downto 0);
      HTRANS       : in  std_logic_vector ( 1 downto 0);
      HWDATA       : in  std_logic_vector (31 downto 0);
      HWRITE       : in  std_logic ;
      HRDATA       : out std_logic_vector (31 downto 0);
      HREADY       : out std_logic ;
      HRESP        : out std_logic ;
      -- siae AMBA AHB-lite 32bit record connections
      AHBlite_Down : out AMBA_AHBlite32_Down;
      AHBlite_Up   : in  AMBA_AHBlite32_Up 
   );
   end component;
   ----------------------------------------------------------------------------
   component krypto_aes_upif
   generic (
      INSERT_DOUBLE_FF_ON_OUT           : boolean   := false;
      INSERT_RD_MI_FF                   : boolean   := false;
      SPLIT_RD_MI_MUX                   : boolean   := false;
      NUMB_OF_DELAY_ON_OPEN_CYCLE       : integer range 0 to 7 := 0;
      DEFAULT_READVAL_FOR_DB_UNUSED_BIT : std_logic := '0'
   );
   port (
      ctrl_bus              : out class_krypto_ctrl;
      sync                  : out std_logic;
      arstn_upif            : out std_logic;
      --
      BusMicro_AHBlite_Down : in  AMBA_AHBlite32_Down;
      BusMicro_AHBlite_Up   : out AMBA_AHBlite32_Up;
      HRESETn               : in	 std_logic;
      HCLK                  : in	 std_logic
   );
   end component;



   ----------------------------------------------------------------------------
   -- NETS
   ----------------------------------------------------------------------------
   signal BRAM_PORTA_addr        : std_logic_vector ( 31 downto 0 );
   signal BRAM_PORTA_clk         : std_logic;
   signal BRAM_PORTA_din         : std_logic_vector ( 31 downto 0 );
   signal BRAM_PORTA_dout        : std_logic_vector ( 31 downto 0 );
   signal BRAM_PORTA_en          : std_logic;
   signal BRAM_PORTA_rst         : std_logic;
   signal BRAM_PORTA_we          : std_logic_vector ( 3 downto 0 );
   signal DEBUG_capture          : std_logic;
   signal DEBUG_clk              : std_logic;
   signal DEBUG_disable          : std_logic;
   signal DEBUG_reg_en           : std_logic_vector ( 0 to 7 );
   signal DEBUG_rst              : std_logic;
   signal DEBUG_shift            : std_logic;
   signal DEBUG_tdi              : std_logic;
   signal DEBUG_tdo              : std_logic;
   signal DEBUG_trig_ack_in      : std_logic_vector ( 0 to 7 );
   signal DEBUG_trig_ack_out     : std_logic_vector ( 0 to 7 );
   signal DEBUG_trig_in          : std_logic_vector ( 0 to 7 );
   signal DEBUG_trig_out         : std_logic_vector ( 0 to 7 );
   signal DEBUG_update           : std_logic;
   signal M_AHB_haddr            : std_logic_vector ( 31 downto 0 );
   signal M_AHB_hburst           : std_logic_vector ( 2 downto 0 );
   signal M_AHB_hmastlock        : std_logic;
   signal M_AHB_hprot            : std_logic_vector ( 3 downto 0 );
   signal M_AHB_hrdata           : std_logic_vector ( 31 downto 0 );
   signal M_AHB_hready           : std_logic;
   signal M_AHB_hresp            : std_logic;
   signal M_AHB_hsize            : std_logic_vector ( 2 downto 0 );
   signal M_AHB_htrans           : std_logic_vector ( 1 downto 0 );
   signal M_AHB_hwdata           : std_logic_vector ( 31 downto 0 );
   signal M_AHB_hwrite           : std_logic;
   signal M_AXI_araddr           : std_logic_vector ( 31 downto 0 );
   signal M_AXI_arburst          : std_logic_vector ( 1 downto 0 );
   signal M_AXI_arcache          : std_logic_vector ( 3 downto 0 );
   signal M_AXI_arlen            : std_logic_vector ( 7 downto 0 );
   signal M_AXI_arlock           : std_logic_vector ( 0 to 0 );
   signal M_AXI_arprot           : std_logic_vector ( 2 downto 0 );
   signal M_AXI_arqos            : std_logic_vector ( 3 downto 0 );
   signal M_AXI_arready          : std_logic_vector ( 0 to 0 );
   signal M_AXI_arregion         : std_logic_vector ( 3 downto 0 );
   signal M_AXI_arsize           : std_logic_vector ( 2 downto 0 );
   signal M_AXI_arvalid          : std_logic_vector ( 0 to 0 );
   signal M_AXI_awaddr           : std_logic_vector ( 31 downto 0 );
   signal M_AXI_awburst          : std_logic_vector ( 1 downto 0 );
   signal M_AXI_awcache          : std_logic_vector ( 3 downto 0 );
   signal M_AXI_awlen            : std_logic_vector ( 7 downto 0 );
   signal M_AXI_awlock           : std_logic_vector ( 0 to 0 );
   signal M_AXI_awprot           : std_logic_vector ( 2 downto 0 );
   signal M_AXI_awqos            : std_logic_vector ( 3 downto 0 );
   signal M_AXI_awready          : std_logic_vector ( 0 to 0 );
   signal M_AXI_awregion         : std_logic_vector ( 3 downto 0 );
   signal M_AXI_awsize           : std_logic_vector ( 2 downto 0 );
   signal M_AXI_awvalid          : std_logic_vector ( 0 to 0 );
   signal M_AXI_bready           : std_logic_vector ( 0 to 0 );
   signal M_AXI_bresp            : std_logic_vector ( 1 downto 0 );
   signal M_AXI_bvalid           : std_logic_vector ( 0 to 0 );
   signal M_AXI_rdata            : std_logic_vector ( 31 downto 0 );
   signal M_AXI_rlast            : std_logic_vector ( 0 to 0 );
   signal M_AXI_rready           : std_logic_vector ( 0 to 0 );
   signal M_AXI_rresp            : std_logic_vector ( 1 downto 0 );
   signal M_AXI_rvalid           : std_logic_vector ( 0 to 0 );
   signal M_AXI_wdata            : std_logic_vector ( 31 downto 0 );
   signal M_AXI_wlast            : std_logic_vector ( 0 to 0 );
   signal M_AXI_wready           : std_logic_vector ( 0 to 0 );
   signal M_AXI_wstrb            : std_logic_vector ( 3 downto 0 );
   signal M_AXI_wvalid           : std_logic_vector ( 0 to 0 );
   
   signal XILINX_MBDEBUG_Down    : XILINX_MBDEBUG_Down;
   signal tdo                    : std_logic;
   signal Sys_Rst                : std_logic;
   signal XILINX_MBDEBUG_Up      : XILINX_MBDEBUG_Up;
   signal capture                : std_logic;
   signal clk                    : std_logic;
   signal disable                : std_logic;
   signal reg_en                 : std_logic_vector ( 0 to 7 );
   signal rst                    : std_logic;
   signal shift                  : std_logic;
   signal tdi                    : std_logic;
   signal update                 : std_logic;
   
   signal krypto_ctrl_bus        : class_krypto_ctrl;
   signal sync                   : std_logic;
   signal arstn_upif             : std_logic;
   signal AHBlite_krypto_Down    : AMBA_AHBlite32_Down;
   signal AHBlite_krypto_Up      : AMBA_AHBlite32_Up;
   
   
   
   
   
   
   
   

begin
   -----------------------------------------------------------------------------
   -- 
   -----------------------------------------------------------------------------
   halo_wrapper_i : halo_wrapper
      port map (
         BRAM_PORTA_addr    => BRAM_PORTA_addr   ,
         BRAM_PORTA_clk     => BRAM_PORTA_clk    ,
         BRAM_PORTA_din     => BRAM_PORTA_din    ,
         BRAM_PORTA_dout    => BRAM_PORTA_dout   ,
         BRAM_PORTA_en      => BRAM_PORTA_en     ,
         BRAM_PORTA_rst     => BRAM_PORTA_rst    ,
         BRAM_PORTA_we      => BRAM_PORTA_we     ,
         DEBUG_capture      => DEBUG_capture     ,
         DEBUG_clk          => DEBUG_clk         ,
         DEBUG_disable      => DEBUG_disable     ,
         DEBUG_reg_en       => DEBUG_reg_en      ,
         DEBUG_rst          => DEBUG_rst         ,
         DEBUG_shift        => DEBUG_shift       ,
         DEBUG_tdi          => DEBUG_tdi         ,
         DEBUG_tdo          => DEBUG_tdo         ,
         DEBUG_trig_ack_in  => DEBUG_trig_ack_in ,
         DEBUG_trig_ack_out => DEBUG_trig_ack_out,
         DEBUG_trig_in      => DEBUG_trig_in     ,
         DEBUG_trig_out     => DEBUG_trig_out    ,
         DEBUG_update       => DEBUG_update      ,
         M_AHB_haddr        => M_AHB_haddr       ,
         M_AHB_hburst       => M_AHB_hburst      ,
         M_AHB_hmastlock    => M_AHB_hmastlock   ,
         M_AHB_hprot        => M_AHB_hprot       ,
         M_AHB_hrdata       => M_AHB_hrdata      ,
         M_AHB_hready       => M_AHB_hready      ,
         M_AHB_hresp        => M_AHB_hresp       ,
         M_AHB_hsize        => M_AHB_hsize       ,
         M_AHB_htrans       => M_AHB_htrans      ,
         M_AHB_hwdata       => M_AHB_hwdata      ,
         M_AHB_hwrite       => M_AHB_hwrite      ,
         M_AXI_araddr       => M_AXI_araddr      ,
         M_AXI_arburst      => M_AXI_arburst     ,
         M_AXI_arcache      => M_AXI_arcache     ,
         M_AXI_arlen        => M_AXI_arlen       ,
         M_AXI_arlock       => M_AXI_arlock      ,
         M_AXI_arprot       => M_AXI_arprot      ,
         M_AXI_arqos        => M_AXI_arqos       ,
         M_AXI_arready      => M_AXI_arready     ,
         M_AXI_arregion     => M_AXI_arregion    ,
         M_AXI_arsize       => M_AXI_arsize      ,
         M_AXI_arvalid      => M_AXI_arvalid     ,
         M_AXI_awaddr       => M_AXI_awaddr      ,
         M_AXI_awburst      => M_AXI_awburst     ,
         M_AXI_awcache      => M_AXI_awcache     ,
         M_AXI_awlen        => M_AXI_awlen       ,
         M_AXI_awlock       => M_AXI_awlock      ,
         M_AXI_awprot       => M_AXI_awprot      ,
         M_AXI_awqos        => M_AXI_awqos       ,
         M_AXI_awready      => M_AXI_awready     ,
         M_AXI_awregion     => M_AXI_awregion    ,
         M_AXI_awsize       => M_AXI_awsize      ,
         M_AXI_awvalid      => M_AXI_awvalid     ,
         M_AXI_bready       => M_AXI_bready      ,
         M_AXI_bresp        => M_AXI_bresp       ,
         M_AXI_bvalid       => M_AXI_bvalid      ,
         M_AXI_rdata        => M_AXI_rdata       ,
         M_AXI_rlast        => M_AXI_rlast       ,
         M_AXI_rready       => M_AXI_rready      ,
         M_AXI_rresp        => M_AXI_rresp       ,
         M_AXI_rvalid       => M_AXI_rvalid      ,
         M_AXI_wdata        => M_AXI_wdata       ,
         M_AXI_wlast        => M_AXI_wlast       ,
         M_AXI_wready       => M_AXI_wready      ,
         M_AXI_wstrb        => M_AXI_wstrb       ,
         M_AXI_wvalid       => M_AXI_wvalid      ,
         clk_100            => clk_100           ,
         rst_n              => rst_n             
      );
   -----------------------------------------------------------------------------
   -- 
   -----------------------------------------------------------------------------
   mdm_if_i : XILINX_MDEBUG_MasterRec_to_SlaveSplit
      port map (
         tdo                 => DEBUG_tdo,
         capture             => capture,
         clk                 => clk,
         disable             => disable,
         reg_en              => reg_en,
         rst                 => rst,
         shift               => shift,
         tdi                 => tdi,
         update              => update,
         Sys_Rst             => Sys_Rst,
         XILINX_MBDEBUG_Down => MBDEBUG_Down,
         XILINX_MBDEBUG_Up   => MBDEBUG_Up
      );
   -----------------------------------------------------------------------------
   -- 
   -----------------------------------------------------------------------------
   AHBLite2Record_i : XilinxAHBLite2Record
      port map (
         HADDR        => M_AHB_haddr,
         HBURST       => M_AHB_hburst,
         HMASTLOCK    => M_AHB_hmastlock,
         HPROT        => M_AHB_hprot,
         HSIZE        => M_AHB_hsize,
         HTRANS       => M_AHB_htrans,
         HWDATA       => M_AHB_hwdata,
         HWRITE       => M_AHB_hwrite,
         HRDATA       => M_AHB_hrdata,
         HREADY       => M_AHB_hready,
         HRESP        => M_AHB_hresp,
         AHBlite_Down => AHBlite_krypto_Down,
         AHBlite_Up   => AHBlite_krypto_Up
      );
   -----------------------------------------------------------------------------
   -- 
   -----------------------------------------------------------------------------
   krypto_aes_upif_i : krypto_aes_upif
      generic map (
         INSERT_DOUBLE_FF_ON_OUT           => false,
         INSERT_RD_MI_FF                   => false,
         SPLIT_RD_MI_MUX                   => false,
         NUMB_OF_DELAY_ON_OPEN_CYCLE       => 0,
         DEFAULT_READVAL_FOR_DB_UNUSED_BIT => '0'
      )
      port map (
         ctrl_bus              => krypto_ctrl_bus    ,
         sync                  => sync               ,
         arstn_upif            => arstn_upif         ,
         BusMicro_AHBlite_Down => AHBlite_krypto_Down,
         BusMicro_AHBlite_Up   => AHBlite_krypto_Up  ,
         HRESETn               => HRESETn            ,
         HCLK                  => HCLK
      );
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
end rtl;