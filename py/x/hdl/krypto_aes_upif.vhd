--siae--AHB--register--generator--label-- LSYNC_1588
--siae--AHB--register--generator--MaxAddrSize--  0x20
--siae--AHB--register--generator--version--   1   4   3   0
--siae--AHB--register--generator--params-- --source krypto_aes.upif --dest ..\hdl\krypto_aes_upif.vhd -d 32 
--siae--AHB--register--generator--datime--  Wed Aug 30 17:04:46 2023
	--********* Generazione ENTITY ******************************************************** ("src/c/main.c", line 1232)

-- NON MODIFICARE -- {{{
-- File generato automaticamente!!!
-- NON MODIFICARE --

-- Programma di generazione automatica di interfaccia uP

--   (c)2014-2018 All Rights Reserved
--   siae microelettronica S.p.A.
--   Via M. Buonarroti, 21
--   20090 - Cologno M.se (MI)
--   ITALY (EU)
--   
--   Versione: 1.4.3 Build 0

--          -- NON MODIFICARE -- 
--          -- NON MODIFICARE -- 
--          -- NON MODIFICARE -- 
-- $Id: VHDL_Intestazione.h 217 2018-01-19 14:21:18Z PAGLIA $
--
-- Sorgente programma in "C" 
--		Alla domanda: "C++?" la risposta è: "C. Più o meno..."
--
--    ---  www.siaemic.com  ---
--
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--
-- Descrizione: 
--      Interfaccia FPGA/MicroProcessore generata automaticamente.
--      Rispetta le specifiche AMBA/AHBlite
--
--          -- NON MODIFICARE -- (per chi non avesse ancora capito...)
--      
--   GENERIC:
--    DEFAULT_READVAL_FOR_DB_UNUSED_BIT
--          Definisce il valore che viene scritto sul DataBus uscente per tutti gli 
--          address non utilizzati, così come per tutti i bit non usati all'interno di
--          un indirizzo. Ovviamente è di tipo “std_logic”, di DEFAULT è inizializzata a 'Z'.
--
--      Il file di testo da cui è stata generata deve avere il seguente formato:
--
-- //BASE,    ADDR,SIZE, BIT, BITNR, TYPE, NAME											   ,DEF, SW_CMP, DESCRIPTION
-- 0x0000, 0x0005, 0, 	0,		 8, 	RW, RW_TestReg			 							,	0,       , Registro di test
-- 0x0000, 0x0100,64,	0,		 8, 	RO, BPDU_DataBus_read       					,	0,       , Pacchetti BPDU Ricevuti
-- 0x0000, 0x0165, 0,	0,     1, 	RO, BPDU_PacketReadyForRead 					,	0,       , Segnala la disponibilità di un pacchetto PBDU da leggere
--
-- TUTTI I CAMPI SONO OBBLIGATORI (SW_CMP e DESCRIPTION possono essere lasciati vuoti)
-- Il separatore fra i vari campi deve essere la ","
--
-- I vari campi hanno i seguenti significati:
-- BASE        Spiazzamento (viene sommato all'indirizzo) può tranquillamente 
--                  essere sempre 0... messo xè..magari serve
-- ADDR        Indirizzo
-- SIZE        Serve a definire se al segnale in realtà corrispondono una serie 
--                  di indirizzi (es: una RAM)
-- BIT         Posizione dell'LSB del segnale nel Byte del registro
-- BITNR       Nr. di bit di ampiezza del segnale
-- TYPE        Type del registro... vedi tabella TIPI di seguito
-- NAME        Nome del Segnale di IN/OUT
--                  max 30 caratteri.
-- DEF         Valore di default assegnato (se RW, IR, FW)
-- SW_CMP      Nome del componente SoftWare che viene anteposto al nome del segnale
--                  nella creazione del file .h (può essere lasciato vuoto)
-- DESCRIPTION Campo di testo per la descrizione del registro. Max 100 caratteri, non
--                  deve contenere virgole
-- 
-- 
-- Tabella dei TIPI:
-- RW --> Read-Write
-- RO --> Read-Only 
-- WO --> Write-Only
-- SC --> Self-Clearing (si muove con i fronti di salita del clock micro e dura quanto il ciclo di Write)
-- AL --> ALarm (memorizzato se attivo (0) fino alla prima lettura. Se non serve
--          una memorizzazione basta definirli RO (Gestito fino al BYTE nello stesso indirizzo)
--          Memorizzati in maniera ASINCRONA. il DEFAULT indica il valore allo startup
-- IR --> Interrupt Request. Messi tutti in AND logica
--          Il parametro DEF indica se il segnale è attivo basso (0) o attivo alto (1)
--				Nell'Address successivo viene messo il rispettivo bit di ENABLE (def=0 -> Disabilita IRQ)
-- CS --> ... NON UN REGISTRO MA SOLO I VARI RANGE IN CUI DEVE ESSERE ATTIVO IL 
--           SEGNALE  "ReadActiveHigh"  per questa I/F uP (non necessita di NAME).
--           Mantenuto per retrocompatibilità, NON HA ALCUN EFFETTO su AHB.
-- FW --> Fixed Value. Crea il segnale nella Entity a cui assegna un valore FISSO. Tale valore
--           NON può essere letto dal uP. Dal punto di vista logico il registro risulta impegnato.
--           Nasce per fissare il valore di un registro RW o WO terminata la fase di debug
-- MI --> Per connettere una "sotto-interfaccia" AHBlite che condivide lo stesso dominio di clock
--           Abbastanza ovviamente deve essere un range
--
--
--    DEBUG ALLARMI
--       Esiste la possibilità di gestire (nasce per il debug, ovviamente) le letture degli allarmi
--       in maniera che possano essere CONGELATI ed eventualmente AZZERATI TUTTI. 
--       Per fare ciò è necessario definire all'interno del SORGENTE la/e seguente/i line/a:
--
-- <base>, <addr>, 0, <bit position>, 1, SC, DebugClearAllAlarms, 0, , 
-- <base>, <addr>, 0, <bit position>, 1, RW, DebugFreezeAllAlarms, 0, , 
--
--       Possono essere inseriti uno E/O l'altro. Entrambi OPZIONALI. Sono FISSATI i NOMI e i TIPI.
--       i NOMI sono "Case Sensitive".
--       Indirizzo e posizione sono a scelta.
--          DebugClearAllAlarms  -> La scrittura a '1' di questo bit SelfClearing cancella TUTTI gli 
--                                  allarmi come se il uP avesse effettutato la lettura.
--          DebugFreezeAllAlarms -> Se a '0' il comportamento degli allarmi è quello standard,
--                                  se a '1' allora gli ALLARMI NON vengono RESETTATI a seguito 
--                                  della lettura del uP.
--
--
--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!         OPZIONALI:         !!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--
-- Sono gestiti i segnali incapsulati dentro dei RECORD. Per utilizzarli è necessario inserire a 
-- termine riga (dopo la descrizione) i seguenti campi informativi:
-- 1) Prefisso contenuto nel NAME che deve essere eliminato in quanto non presente enlla defizione del record
-- 2) Nome del Record (quello che diventa il segnale di IN o OUT dell'entity)
-- 3) Record Type (type xxxxxx  is record....) di riferimento
-- 4) library.package (dove è contenuta la definizione del Record)
-- 5) Indice, deve corrispondere alla parte terminale del nome_xx che verrà sostituito da record.nome(xx)
-- Il separatore di campo è =|=
-- esempio:
-- 0x023, 12, 0, 0, 8, RW, PrefNomeCampo_13, 0, Descrizione =|= Pref =|= Nome_Record =|= type_Record =|= LiBrArY.PaCkaGe =|= 13
--
-- in questo caso, prima della definizione della entity nel file vhdl (questo da cui stai leggendo...), verrà inserito:
--   library LiBrArY
--   use LiBrArY.PaCkaGe.all;
--   
--   e nel record Nome_Record definito come OUT nella entity il segnale verrà connesso come NomeCampo(13)
--
-- NOTA: la gestione è esattamente identica a quella già utilizzata dallo script di MORETF
--       qui "semplicemente" inglobata per eliminare un passaggio
-- 
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------
-- Quanto sopra è definito nel file "VHDL_Intestazione.H_ori" --
----------------------------------------------------------------
-- }}}
-- Di seguito viene inserito (commentato) il file di origine... {{{
--------------------------------------------------------------------------------
---|||---|||--- 
--------------------------------------------------------------------------------
-- 
-- #label LSYNC_1588
-- 
-- // --------------------------------------------------------------------------------
-- // INIT
-- 0x0000,  0x0000,   0,      0,    1,    RW,   sync,                0,  , sync
-- 0x0000,  0x0004,   0,      0,    1,    RW,   arstn_upif,          1,  , upif_arstn
-- 
-- // GENERAL
-- 0x0010,  0x0000,   0,      0,    32,    RW,   ph_ctrl       ,  0,  , ---   =|= =|= ctrl_bus     =|= class_krypto_ctrl   =|= halo_lib.krypto_pkg =|=
-- 0x0020,  0x0000,   0,      0,    32,    RW,   ph_init       ,  0,  , ---   =|= =|= ctrl_bus     =|= class_krypto_ctrl   =|= halo_lib.krypto_pkg =|=
-- 
--------------------------------------------------------------------------------
---|||---|||--- 
-------------------------------------------------------------------------------- }}}
-- Fine del file di origine
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all; -- conv_std_logic_vector()
use ieee.std_logic_unsigned.all; -- conv_integer()

LIBRARY siae_packet_pkg_lib;
USE siae_packet_pkg_lib.siae_uP_IF_pack.all;
LIBRARY halo_lib;
USE halo_lib.krypto_pkg.ALL;

-- ("src/c/VHDL_Entity.c" Line 119)
entity krypto_aes_upif is
	generic(
		INSERT_DOUBLE_FF_ON_OUT           : boolean   := false; -- se TRUE inserisce riletture per tutte le uscite dei registri
		INSERT_RD_MI_FF                   : boolean   := false; -- se TRUE inserisce riletture nei path dati dei registri tipo MI
		SPLIT_RD_MI_MUX                   : boolean   := false; -- se TRUE spezza il mux di lettura per i registri MI (vale solo se INSERT_RD_MI_FF=true)
		NUMB_OF_DELAY_ON_OPEN_CYCLE       : integer range 0 to 7 := 0; -- numero di delay in apertura interna dei cicli di accesso
		DEFAULT_READVAL_FOR_DB_UNUSED_BIT : std_logic := '0'
	);
	port(

		 -- RECORD (src/c/VHDL_Entity.c Line 133)
	ctrl_bus : out class_krypto_ctrl;

		 -- INPUT (src/c/VHDL_Entity.c Line 137)

		 -- OUTPUT (src/c/VHDL_Entity.c Line 201)
		      sync                                              	: out std_logic;                     --  sync
		      arstn_upif                                        	: out std_logic;                     --  upif_arstn

		-- Signals of microProcessor's I/F ("src/c/VHDL_Entity.c" line 262)
		-- ("src/c/VHDL_Entity.c" Line 263)
		BusMicro_AHBlite_Down       : in  AMBA_AHBlite32_Down;
		BusMicro_AHBlite_Up         : out AMBA_AHBlite32_Up;
		HRESETn     : in	std_logic;
		HCLK        : in	std_logic
	);
end entity;
-------------------
-- End Of ENTITY --
-------------------
-------------------
	--************************************************************************************* ("src/c/main.c", line 1234)

---------------------------
---------------------------
-- Start of ARCHITECTURE --
---------------------------
-- ("src/c/VHDL_Architecture.c", line 88)

architecture AutomaticGeneration of krypto_aes_upif is

	-- Costanti ("src/c/VHDL_Architecture.c", line 94)
	constant	AHB_HTRANS_IDLE		: std_logic_vector(1 downto 0) := "00";
	constant	AHB_HTRANS_BUSY		: std_logic_vector(1 downto 0) := "01";
	constant	AHB_HTRANS_NONSEQ		: std_logic_vector(1 downto 0) := "10";
	constant	AHB_HTRANS_SEQ			: std_logic_vector(1 downto 0) := "11";

	constant	AHB_HBURST_SINGLE		: std_logic_vector(2 downto 0) := "000";
	constant	AHB_HBURST_INCR		: std_logic_vector(2 downto 0) := "001";
	constant	AHB_HBURST_WRAP4   	: std_logic_vector(2 downto 0) := "010";
	constant	AHB_HBURST_INCR4   	: std_logic_vector(2 downto 0) := "011";
	constant	AHB_HBURST_WRAP8   	: std_logic_vector(2 downto 0) := "100";
	constant	AHB_HBURST_INCR8   	: std_logic_vector(2 downto 0) := "101";
	constant	AHB_HBURST_WRAP16  	: std_logic_vector(2 downto 0) := "110";
	constant	AHB_HBURST_INCR16  	: std_logic_vector(2 downto 0) := "111";

	constant	AHB_HRESP_OKAY	   	: std_logic_vector(1 downto 0) := "00"	;
	constant	AHB_HRESP_RETRY    	: std_logic_vector(1 downto 0) := "10" ;
	constant	AHB_HRESP_SPLIT    	: std_logic_vector(1 downto 0) := "11" ;
	constant	AHB_HRESP_ERROR    	: std_logic_vector(1 downto 0) := "01" ;

	constant	AHB_HSIZE_BYTE	   	: std_logic_vector(2 downto 0) := "000";
	constant	AHB_HSIZE_HALFWORD	: std_logic_vector(2 downto 0) := "001";
	constant	AHB_HSIZE_WORD	   	: std_logic_vector(2 downto 0) := "010";

	constant   DATABUSSIZE : integer := 32;

	constant   ADDRBUSSIZE : integer := 6;

	-- Inizio della dichiarazione dei segnali interni ("src/c/VHDL_Architecture.c", line 124)
	signal     enByte          : std_logic_vector(3 downto 0);

	-- ("src/c/VHDL_Architecture.c", line 130)
	-- for AMBA AHB-lite 32bit standard I/F signals
	signal	int_HREADY		: std_logic; 
	signal	int_HWRITE		: std_logic; 
	signal	int_HADDR      : std_logic_vector(ADDRBUSSIZE-1 downto 0);
-- ATTRIBUTI per int_HADDR INSERITI PER ESTRAZIONE AUTOMATICA DEI MULTICYCLE IN SINTESI
	attribute UpIntLabel                            : string ;
	attribute numbOfDelayOnOpenCycle                : integer;
	attribute UpIntLabel of int_HADDR               : signal  is "LSYNC_1588";
	attribute numbOfDelayOnOpenCycle of int_HADDR   : signal  is NUMB_OF_DELAY_ON_OPEN_CYCLE;

	signal	int_HSIZE      : std_logic_vector( 2 downto 0);
	-- AL, RW, RO, WO, IR, FV ("src/c/VHDL_Architecture.c", line 149)
	signal	int_sync                                              	: std_logic := '0';
	signal	int_arstn_upif                                        	: std_logic := '1';
	signal	int_ph_ctrl                                           	: std_logic_vector(31 downto 0) := (others => '0');
	signal	int_ph_init                                           	: std_logic_vector(31 downto 0) := (others => '0');
	-- segnali 'accessori' per MI ("src/c/VHDL_Architecture.c", line 264)
	-- segnali 'accessori' per AL ("src/c/VHDL_Architecture.c", line 297)

	-- inserting signal for Databus Read/Write ("src/c/VHDL_Architecture.c", line 340)
	type	t_ByteDataBus	is array (0 to 3) of std_logic_vector(7 downto 0);
	type	t_HalfWordDataBus	is array (0 to 1) of std_logic_vector(15 downto 0);
	signal	int_ByteDataBusWrite				: t_ByteDataBus;
	signal	int_ByteDataBusRead				: t_ByteDataBus;
	signal	int_4RAM_ByteDataBusRead		: t_ByteDataBus;
	signal	int_HalfWordDataBusWrite		: t_HalfWordDataBus;
	signal	int_WordDataBusWrite	   : std_logic_vector(31 downto 0);
	signal	int_4RAM_HalfWordDataBusRead		: t_HalfWordDataBus;
	signal	int_4RAM_WordDataBusRead  		: std_logic_vector(31 downto 0);
	signal	int_ContaStatoAccesso			: integer range 0 to 15; -- inizializzato sotto HRESETn
	signal	int_ContaStatoReadWithAck		: integer range 0 to 7;
	signal	FlagTerminataReadAck          : boolean;

	-- inserting signals for RAMs ("src/c/VHDL_Architecture.c", line 394)
	signal   int_Read_sync                                              	: std_logic_vector( 0 downto 0); --  sync Data for Read
	signal   int_Read_arstn_upif                                        	: std_logic_vector( 0 downto 0); --  upif_arstn Data for Read
   -- Gestione del DataBus
   signal   int_DataBusRead         : std_logic_vector(DATABUSSIZE-1 downto 0);
   signal   int_DataBusWrite        : std_logic_vector(DATABUSSIZE-1 downto 0);
   signal   FlagTriplicaRead        : integer range 0 to 2;
   signal   int_ContaDelay          : integer range 0 to 7;
	-- Inizio dell'ARCHITETTURA ("src/c/VHDL_Architecture.c", line 472)

begin

-------------------------
-- file Architecture.h --
-------------------------




------------------------
-- EOF Architecture.h --
------------------------
	--********* Generazione ARCHITECTURE ************************************************** ("src/c/main.c", line 1245)
	-- ("src/c/VHDL_Architecture.c", line 494)


	-- ("src/c/VHDL_Architecture.c", line 496)
	int_ByteDataBusWrite(0) <= BusMicro_AHBlite_Down.HWDATA(7 downto 0);
	int_ByteDataBusWrite(1) <= BusMicro_AHBlite_Down.HWDATA(15 downto 8);
	int_ByteDataBusWrite(2) <= BusMicro_AHBlite_Down.HWDATA(23 downto 16);
	int_ByteDataBusWrite(3) <= BusMicro_AHBlite_Down.HWDATA(31 downto 24);
	int_HalfWordDataBusWrite(0) <= BusMicro_AHBlite_Down.HWDATA(15 downto 0);
	int_HalfWordDataBusWrite(1) <= BusMicro_AHBlite_Down.HWDATA(31 downto 16);
	int_WordDataBusWrite <= BusMicro_AHBlite_Down.HWDATA;


	process(enByte, BusMicro_AHBlite_Down, int_ByteDataBusWrite)
	begin
		case enByte is
			when	"0001"	=>	int_DataBusWrite <= int_ByteDataBusWrite(0) & int_ByteDataBusWrite(0) & int_ByteDataBusWrite(0) & int_ByteDataBusWrite(0);
			when	"0010"	=>	int_DataBusWrite <= int_ByteDataBusWrite(1) & int_ByteDataBusWrite(1) & int_ByteDataBusWrite(1) & int_ByteDataBusWrite(1);
			when	"0100"	=>	int_DataBusWrite <= int_ByteDataBusWrite(2) & int_ByteDataBusWrite(2) & int_ByteDataBusWrite(2) & int_ByteDataBusWrite(2);
			when	"1000"	=>	int_DataBusWrite <= int_ByteDataBusWrite(3) & int_ByteDataBusWrite(3) & int_ByteDataBusWrite(3) & int_ByteDataBusWrite(3);
			when	"0011"	=>	int_DataBusWrite <= int_ByteDataBusWrite(1) & int_ByteDataBusWrite(0) & int_ByteDataBusWrite(1) & int_ByteDataBusWrite(0);
			when	"1100"	=>	int_DataBusWrite <= int_ByteDataBusWrite(3) & int_ByteDataBusWrite(2) & int_ByteDataBusWrite(3) & int_ByteDataBusWrite(2);
			when	others	=> int_DataBusWrite <= BusMicro_AHBlite_Down.HWDATA;
		end case;
	end process;
	-- ("src/c/VHDL_Architecture.c", line 543)
	BusMicro_AHBlite_Up.HREADY <= int_HREADY;
	process(HRESETn, HCLK)
		variable	v_ByteDataBusRead		  : t_ByteDataBus;
		variable v_HalfWordDataBusRead  : t_HalfWordDataBus;
		variable v_WordDataBusRead      : std_logic_vector(31 downto 0);
		variable v_temp_ADDR            : std_logic_vector(ADDRBUSSIZE-1 downto 0);
		variable v_HSIZE                : std_logic_vector(2 downto 0);
		variable v_HADDR2               : std_logic_vector(1 downto 0);
		variable v_AccessError          : boolean := false;
	begin
	   if(HRESETn='0') then
	   	enByte <= (others => '0'); -- ALL DISabled
			int_HREADY <= '1';
			int_HWRITE <= '0';
			int_HSIZE  <= (others => '0');
			int_HADDR  <= (others => '0');
			int_ContaStatoAccesso <= 13;
			BusMicro_AHBlite_Up.HRESP    <= AHB_HRESP_OKAY;
			int_ContaStatoReadWithAck <= 0;
			int_4RAM_ByteDataBusRead <= (others => (others => '0'));
			int_4RAM_HalfWordDataBusRead <= (others => (others => '0'));
			int_4RAM_WordDataBusRead     <= (others => '0');
			FlagTerminataReadAck <= false;
			FlagTriplicaRead <= 0;
			int_ContaDelay   <= 0;
			-- reset segnali per RAM esterne ("src/c/VHDL_Architecture.c", line 590)

		elsif(HCLK'event and HCLK = '1') then

	
			int_HREADY <= '1';

			if(BusMicro_AHBlite_Down.HSELx = '1' and int_HREADY = '1') then
				if(BusMicro_AHBlite_Down.HTRANS = AHB_HTRANS_NONSEQ or BusMicro_AHBlite_Down.HTRANS = AHB_HTRANS_SEQ) then
					enByte <= (others => '0');
					-- NONSEQ or SEQ access type
					-- VALID CYCLE
					v_HSIZE := BusMicro_AHBlite_Down.HSIZE;
					int_HREADY <= '0'; -- segnalo la necessità di almeno un WAIT
					BusMicro_AHBlite_Up.HRESP <= AHB_HRESP_OKAY;
					int_ContaStatoAccesso <= 15;
					v_AccessError := false;
					case v_HSIZE is
						when	"000"	=>	--8bit  Byte
											v_HADDR2 := BusMicro_AHBlite_Down.HADDR(1 downto 0);
											case v_HADDR2 is
												when "00"	=>	enByte <= "0001";
												when "01"	=>	enByte <= "0010";
												when "10"	=>	enByte <= "0100";
												when others	=>	enByte <= "1000";
											end case;

						when	"001"	=>	--16bit Halfword
											if(BusMicro_AHBlite_Down.HADDR(1 downto 0) = "00") then
												enBYTE <= "0011";
											elsif(BusMicro_AHBlite_Down.HADDR(1 downto 0) = "10") then
												enBYTE <= "1100";
											else
												-- ERRORE AHB
												-- Address NON allineati al tipo di accesso!!
												int_HREADY <= '1'; -- TERMINE CICLO!!
												BusMicro_AHBlite_Up.HRESP <= AHB_HRESP_ERROR;
												int_ContaStatoAccesso <= 13;
												v_AccessError := true;
											end if;

						when	"010"	=>	--32bit Word
											if(BusMicro_AHBlite_Down.HADDR(1 downto 0) = "00") then
												enBYTE <= "1111";
											else
												-- ERRORE AHB
												-- Address NON allineati al tipo di accesso!!
												int_HREADY <= '1'; -- TERMINE CICLO!!
												BusMicro_AHBlite_Up.HRESP <= AHB_HRESP_ERROR;
												int_ContaStatoAccesso <= 13;
												v_AccessError := true;
											end if;
						when	others =>	null;  -- il MASTER AHB non DEVE mai fare questa operazione. me ne frego di gestirla
					end case; --HSIZE
					-- MEMO the address for this cycle
					int_HADDR  <= BusMicro_AHBlite_Down.HADDR(ADDRBUSSIZE-1 downto 0);
					-- and memo the access type
					int_HWRITE <= BusMicro_AHBlite_Down.HWRITE;
					int_HSIZE  <= BusMicro_AHBlite_Down.HSIZE;
				else
					-- NON valid CYCLE
				end if;
			else -- HSELx and int_HREADY
				if(int_ContaStatoAccesso=13) then
					enByte <= (others => '0');
					int_ContaDelay<= 0;
				end if;
			end if; -- HSELx and int_HREADY
	-- ("src/c/VHDL_Architecture.c", line 793)
			if(int_ContaStatoAccesso = 15 and v_AccessError=false) then
				if(int_ContaDelay=NUMB_OF_DELAY_ON_OPEN_CYCLE) then
					int_ContaDelay<=0;
				   int_ContaStatoAccesso <= 14;
					-- default values for control signals:
					-- end of defaults

					case conv_integer(int_HADDR) is
	-- ("src/c/VHDL_Architecture.c", line 826)
						when others => null;
					end case;
					BusMicro_AHBlite_Up.HRDATA <=  int_ByteDataBusRead(3) & int_ByteDataBusRead(2) & int_ByteDataBusRead(1) & int_ByteDataBusRead(0);
				else
					int_ContaDelay<=int_ContaDelay+1;
				   int_HREADY <= '0';
				end if;
			end if; -- ContaStatoAccesso=1


	-- ("src/c/VHDL_Architecture.c", line 887)
			if(int_ContaStatoAccesso = 12) then
				int_ContaStatoAccesso <= 0;
				-- default values for control signals:
				-- end of defaults

				case conv_integer(int_HADDR) is
	-- ("src/c/VHDL_Architecture.c", line 917)
					when others => null;
				end case;
			end if; -- ContaStatoAccesso=1


-- ("src/c/VHDL_Architecture.c" Line 1067)
			if(int_ContaStatoAccesso < 9) then
				case conv_integer(int_HADDR) is -- int_HADDR è l'ADDR memorizzato precedentemente
					when others => null;
				end case;
			end if;

	-- ("src/c/VHDL_Architecture.c", line 1343)
			if(int_ContaStatoAccesso = 14) then
				int_ContaStatoAccesso <= 13;
				enByte <= (others => '0');

				-- NOTA: se precedente era un ciclo di WR, solo ORA trovo sul HWDATA il valore da scrivere!!
				--       altrimenti dalle ram mi trovo il dato da leggere disponibile.
				case conv_integer(int_HADDR) is -- int_HADDR è l'ADDR memorizzato dal ck precedente
					when others => null;
				end case;

			end if;
		end if; -- ck'rise
	end process;


	-- ("src/c/VHDL_Architecture.c", line 1456)
	--********* Generazione parti di gestione degli ALLARMI ******************************* ("src/c/main.c", line 1251)

	--********* Generazione del codice relativo alle WRITE ******************************** ("src/c/main.c", line 1257)

------------------------------
------------------------------
-- START OF WRITE SECTION!! --
------------------------------

	-- ("src/c/VHDL_for_RW_WO_SC.c" line 28)

	process(HRESETn, HCLK)
	begin
		if(HCLK'event and HCLK = '1') then
			-- Automatic clearing of   SC   Register(s) ("src/c/VHDL_for_RW_WO_SC.c" line 90)

			-- start of register(s) Write ("src/c/VHDL_for_RW_WO_SC.c" line 126)
			if(int_HWRITE = '1' and enByte(0) = '1') then
				case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "00") is
					-- ("src/c/VHDL_for_RW_WO_SC.c" line 133)
			when          0 => int_sync <= int_ByteDataBusWrite(0)(0);
			when          4 => int_arstn_upif <= int_ByteDataBusWrite(0)(0);
			when         16 => int_ph_ctrl( 7 downto  0) <= int_ByteDataBusWrite(0)( 7 downto  0);
			when         32 => int_ph_init( 7 downto  0) <= int_ByteDataBusWrite(0)( 7 downto  0);
					when others => null;
				end case;
			end if;

			-- start of register(s) Write ("src/c/VHDL_for_RW_WO_SC.c" line 126)
			if(int_HWRITE = '1' and enByte(1) = '1') then
				case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "01") is
					-- ("src/c/VHDL_for_RW_WO_SC.c" line 133)
			when         17 => int_ph_ctrl(15 downto  8) <= int_ByteDataBusWrite(1)( 7 downto  0);
			when         33 => int_ph_init(15 downto  8) <= int_ByteDataBusWrite(1)( 7 downto  0);
					when others => null;
				end case;
			end if;

			-- start of register(s) Write ("src/c/VHDL_for_RW_WO_SC.c" line 126)
			if(int_HWRITE = '1' and enByte(2) = '1') then
				case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "10") is
					-- ("src/c/VHDL_for_RW_WO_SC.c" line 133)
			when         18 => int_ph_ctrl(23 downto 16) <= int_ByteDataBusWrite(2)( 7 downto  0);
			when         34 => int_ph_init(23 downto 16) <= int_ByteDataBusWrite(2)( 7 downto  0);
					when others => null;
				end case;
			end if;

			-- start of register(s) Write ("src/c/VHDL_for_RW_WO_SC.c" line 126)
			if(int_HWRITE = '1' and enByte(3) = '1') then
				case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "11") is
					-- ("src/c/VHDL_for_RW_WO_SC.c" line 133)
			when         19 => int_ph_ctrl(31 downto 24) <= int_ByteDataBusWrite(3)( 7 downto  0);
			when         35 => int_ph_init(31 downto 24) <= int_ByteDataBusWrite(3)( 7 downto  0);
					when others => null;
				end case;
			end if;

		end if;
	end process;

--------------------------
-- End Of Write Section --
--------------------------
--------------------------
	--********* Codice per gli accessi di READ ******************************************** ("src/c/main.c", line 1263)

-----------------------------
-----------------------------
-- START OF READ SECTION!! --
-----------------------------


	-- ("src/c/VHDL_for_RW_RO_AL_IR.c" Line 37)
	process(int_HADDR,	int_sync,	int_arstn_upif,	int_ph_ctrl,
			int_ph_init		-- ("src/c/VHDL_for_RW_RO_AL_IR.c" Line 62)
	)
	begin
		int_ByteDataBusRead(0) <= (others => DEFAULT_READVAL_FOR_DB_UNUSED_BIT); -- default di lettura del micro per eventuali BIT NON DEFINITI
		int_ByteDataBusRead(1) <= (others => DEFAULT_READVAL_FOR_DB_UNUSED_BIT); -- default di lettura del micro per eventuali BIT NON DEFINITI
		int_ByteDataBusRead(2) <= (others => DEFAULT_READVAL_FOR_DB_UNUSED_BIT); -- default di lettura del micro per eventuali BIT NON DEFINITI
		int_ByteDataBusRead(3) <= (others => DEFAULT_READVAL_FOR_DB_UNUSED_BIT); -- default di lettura del micro per eventuali BIT NON DEFINITI
		case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "00") is
			-- ("src/c/VHDL_for_RW_RO_AL_IR.c" Line 80)
			when          0 => int_ByteDataBusRead(0)(0) <= int_sync;
			when          4 => int_ByteDataBusRead(0)(0) <= int_arstn_upif;
			when         16 => int_ByteDataBusRead(0)( 7 downto  0) <= int_ph_ctrl( 7 downto  0);
			when         32 => int_ByteDataBusRead(0)( 7 downto  0) <= int_ph_init( 7 downto  0);
			when others => null;
		end case;
		case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "01") is
			-- ("src/c/VHDL_for_RW_RO_AL_IR.c" Line 80)
			when         17 => int_ByteDataBusRead(1)( 7 downto  0) <= int_ph_ctrl(15 downto  8);
			when         33 => int_ByteDataBusRead(1)( 7 downto  0) <= int_ph_init(15 downto  8);
			when others => null;
		end case;
		case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "10") is
			-- ("src/c/VHDL_for_RW_RO_AL_IR.c" Line 80)
			when         18 => int_ByteDataBusRead(2)( 7 downto  0) <= int_ph_ctrl(23 downto 16);
			when         34 => int_ByteDataBusRead(2)( 7 downto  0) <= int_ph_init(23 downto 16);
			when others => null;
		end case;
		case conv_integer(int_HADDR(ADDRBUSSIZE-1 downto 2) & "11") is
			-- ("src/c/VHDL_for_RW_RO_AL_IR.c" Line 80)
			when         19 => int_ByteDataBusRead(3)( 7 downto  0) <= int_ph_ctrl(31 downto 24);
			when         35 => int_ByteDataBusRead(3)( 7 downto  0) <= int_ph_init(31 downto 24);
			when others => null;
		end case;
	end process;

-------------------------
-- End Of Read Section --
-------------------------
-------------------------
	--************************************************************************************* ("src/c/main.c", line 1269)

---------------------------------------------------
---------------------------------------------------
-- START OF ASSIGNING INTERNAL TO ENTITY SIGNALS --
---------------------------------------------------
---------------------------------------------------

	-- ("src/c/VHDL_Architecture.c" line 1486)

	GEN_INSERT_DOUBLE_FF_ON_OUT_false: if not INSERT_DOUBLE_FF_ON_OUT generate
				sync <= int_sync;
				arstn_upif <= int_arstn_upif;
				ctrl_bus.ph_ctrl <= int_ph_ctrl;
				ctrl_bus.ph_init <= int_ph_init;
	end generate;

	GEN_INSERT_DOUBLE_FF_ON_OUT_true: if INSERT_DOUBLE_FF_ON_OUT generate
		process(HCLK)
		begin
			if(HCLK'event and HCLK='1') then
				sync <= int_sync;
				arstn_upif <= int_arstn_upif;
				ctrl_bus.ph_ctrl <= int_ph_ctrl;
				ctrl_bus.ph_init <= int_ph_init;
			end if;
		end process;
	end generate;
	-- ("src/c/VHDL_Architecture.c" Line 1597)
	-- ("src/c/VHDL_Architecture.c" Line 1603)

	GEN_INSERT_DOUBLE_FF_ON_OUT_false_4RO: if not INSERT_DOUBLE_FF_ON_OUT generate
	end generate;
	-- ("src/c/VHDL_Architecture.c" Line 1608)

	GEN_INSERT_DOUBLE_FF_ON_OUT_true_4RO: if INSERT_DOUBLE_FF_ON_OUT generate
		process(HCLK)
		begin
			if(HCLK'event and HCLK='1') then
			end if;
		end process;
	end generate;

	-- inserting signals for RAMs ("src/c/VHDL_Architecture.c", line 1697)
	--************************************************************************************* ("src/c/main.c", line 1271)

end architecture AutomaticGeneration;

