--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
--Date        : Wed Aug 30 09:56:37 2023
--Host        : PC2666 running 64-bit major release  (build 9200)
--Command     : generate_target halo_wrapper.bd
--Design      : halo_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity halo_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_rst : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    DEBUG_capture : in STD_LOGIC;
    DEBUG_clk : in STD_LOGIC;
    DEBUG_disable : in STD_LOGIC;
    DEBUG_reg_en : in STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_rst : in STD_LOGIC;
    DEBUG_shift : in STD_LOGIC;
    DEBUG_tdi : in STD_LOGIC;
    DEBUG_tdo : out STD_LOGIC;
    DEBUG_trig_ack_in : in STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_trig_ack_out : out STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_trig_in : out STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_trig_out : in STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_update : in STD_LOGIC;
    M_AHB_haddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AHB_hburst : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AHB_hmastlock : out STD_LOGIC;
    M_AHB_hprot : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AHB_hrdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AHB_hready : in STD_LOGIC;
    M_AHB_hresp : in STD_LOGIC;
    M_AHB_hsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AHB_htrans : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AHB_hwdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AHB_hwrite : out STD_LOGIC;
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_100 : in STD_LOGIC;
    rst_n : in STD_LOGIC
  );
end halo_wrapper;

architecture STRUCTURE of halo_wrapper is
  component halo is
  port (
    clk_100 : in STD_LOGIC;
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_rst : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rst_n : in STD_LOGIC;
    DEBUG_capture : in STD_LOGIC;
    DEBUG_clk : in STD_LOGIC;
    DEBUG_disable : in STD_LOGIC;
    DEBUG_reg_en : in STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_rst : in STD_LOGIC;
    DEBUG_shift : in STD_LOGIC;
    DEBUG_tdi : in STD_LOGIC;
    DEBUG_tdo : out STD_LOGIC;
    DEBUG_trig_ack_in : in STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_trig_ack_out : out STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_trig_in : out STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_trig_out : in STD_LOGIC_VECTOR ( 0 to 7 );
    DEBUG_update : in STD_LOGIC;
    M_AHB_haddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AHB_hburst : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AHB_hmastlock : out STD_LOGIC;
    M_AHB_hprot : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AHB_hrdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AHB_hready : in STD_LOGIC;
    M_AHB_hresp : in STD_LOGIC;
    M_AHB_hsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AHB_htrans : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AHB_hwdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AHB_hwrite : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component halo;
begin
halo_i: component halo
     port map (
      BRAM_PORTA_addr(31 downto 0) => BRAM_PORTA_addr(31 downto 0),
      BRAM_PORTA_clk => BRAM_PORTA_clk,
      BRAM_PORTA_din(31 downto 0) => BRAM_PORTA_din(31 downto 0),
      BRAM_PORTA_dout(31 downto 0) => BRAM_PORTA_dout(31 downto 0),
      BRAM_PORTA_en => BRAM_PORTA_en,
      BRAM_PORTA_rst => BRAM_PORTA_rst,
      BRAM_PORTA_we(3 downto 0) => BRAM_PORTA_we(3 downto 0),
      DEBUG_capture => DEBUG_capture,
      DEBUG_clk => DEBUG_clk,
      DEBUG_disable => DEBUG_disable,
      DEBUG_reg_en(0 to 7) => DEBUG_reg_en(0 to 7),
      DEBUG_rst => DEBUG_rst,
      DEBUG_shift => DEBUG_shift,
      DEBUG_tdi => DEBUG_tdi,
      DEBUG_tdo => DEBUG_tdo,
      DEBUG_trig_ack_in(0 to 7) => DEBUG_trig_ack_in(0 to 7),
      DEBUG_trig_ack_out(0 to 7) => DEBUG_trig_ack_out(0 to 7),
      DEBUG_trig_in(0 to 7) => DEBUG_trig_in(0 to 7),
      DEBUG_trig_out(0 to 7) => DEBUG_trig_out(0 to 7),
      DEBUG_update => DEBUG_update,
      M_AHB_haddr(31 downto 0) => M_AHB_haddr(31 downto 0),
      M_AHB_hburst(2 downto 0) => M_AHB_hburst(2 downto 0),
      M_AHB_hmastlock => M_AHB_hmastlock,
      M_AHB_hprot(3 downto 0) => M_AHB_hprot(3 downto 0),
      M_AHB_hrdata(31 downto 0) => M_AHB_hrdata(31 downto 0),
      M_AHB_hready => M_AHB_hready,
      M_AHB_hresp => M_AHB_hresp,
      M_AHB_hsize(2 downto 0) => M_AHB_hsize(2 downto 0),
      M_AHB_htrans(1 downto 0) => M_AHB_htrans(1 downto 0),
      M_AHB_hwdata(31 downto 0) => M_AHB_hwdata(31 downto 0),
      M_AHB_hwrite => M_AHB_hwrite,
      M_AXI_araddr(31 downto 0) => M_AXI_araddr(31 downto 0),
      M_AXI_arburst(1 downto 0) => M_AXI_arburst(1 downto 0),
      M_AXI_arcache(3 downto 0) => M_AXI_arcache(3 downto 0),
      M_AXI_arlen(7 downto 0) => M_AXI_arlen(7 downto 0),
      M_AXI_arlock(0) => M_AXI_arlock(0),
      M_AXI_arprot(2 downto 0) => M_AXI_arprot(2 downto 0),
      M_AXI_arqos(3 downto 0) => M_AXI_arqos(3 downto 0),
      M_AXI_arready(0) => M_AXI_arready(0),
      M_AXI_arregion(3 downto 0) => M_AXI_arregion(3 downto 0),
      M_AXI_arsize(2 downto 0) => M_AXI_arsize(2 downto 0),
      M_AXI_arvalid(0) => M_AXI_arvalid(0),
      M_AXI_awaddr(31 downto 0) => M_AXI_awaddr(31 downto 0),
      M_AXI_awburst(1 downto 0) => M_AXI_awburst(1 downto 0),
      M_AXI_awcache(3 downto 0) => M_AXI_awcache(3 downto 0),
      M_AXI_awlen(7 downto 0) => M_AXI_awlen(7 downto 0),
      M_AXI_awlock(0) => M_AXI_awlock(0),
      M_AXI_awprot(2 downto 0) => M_AXI_awprot(2 downto 0),
      M_AXI_awqos(3 downto 0) => M_AXI_awqos(3 downto 0),
      M_AXI_awready(0) => M_AXI_awready(0),
      M_AXI_awregion(3 downto 0) => M_AXI_awregion(3 downto 0),
      M_AXI_awsize(2 downto 0) => M_AXI_awsize(2 downto 0),
      M_AXI_awvalid(0) => M_AXI_awvalid(0),
      M_AXI_bready(0) => M_AXI_bready(0),
      M_AXI_bresp(1 downto 0) => M_AXI_bresp(1 downto 0),
      M_AXI_bvalid(0) => M_AXI_bvalid(0),
      M_AXI_rdata(31 downto 0) => M_AXI_rdata(31 downto 0),
      M_AXI_rlast(0) => M_AXI_rlast(0),
      M_AXI_rready(0) => M_AXI_rready(0),
      M_AXI_rresp(1 downto 0) => M_AXI_rresp(1 downto 0),
      M_AXI_rvalid(0) => M_AXI_rvalid(0),
      M_AXI_wdata(31 downto 0) => M_AXI_wdata(31 downto 0),
      M_AXI_wlast(0) => M_AXI_wlast(0),
      M_AXI_wready(0) => M_AXI_wready(0),
      M_AXI_wstrb(3 downto 0) => M_AXI_wstrb(3 downto 0),
      M_AXI_wvalid(0) => M_AXI_wvalid(0),
      clk_100 => clk_100,
      rst_n => rst_n
    );
end STRUCTURE;
