# ██████╗░░█████╗░██████╗░░██████╗███████╗██████╗░
# ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
# ██████╔╝███████║██████╔╝╚█████╗░█████╗░░██████╔╝
# ██╔═══╝░██╔══██║██╔══██╗░╚═══██╗██╔══╝░░██╔══██╗
# ██║░░░░░██║░░██║██║░░██║██████╔╝███████╗██║░░██║
# ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝╚═╝░░╚═╝


# ==============================================================================
import os
import sys
from pathlib import Path


# ------------------------------------------------------------------------------
print ('██████╗░░█████╗░██████╗░░██████╗███████╗██████╗░')
print ('██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗')
print ('██████╔╝███████║██████╔╝╚█████╗░█████╗░░██████╔╝')
print ('██╔═══╝░██╔══██║██╔══██╗░╚═══██╗██╔══╝░░██╔══██╗')
print ('██║░░░░░██║░░██║██║░░██║██████╔╝███████╗██║░░██║')
print ('╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝╚═╝░░╚═╝')



# ------------------------------------------------------------------------------
# ASSUNTO: lo script viene lanciato dalla cartella: 
#  --> py/local_folder/script.py
FOLDER_DSGN = ['designer']
FOLDER_VERF = ['verification_lib']

PATH_ORIGIN = os.getcwd().replace('\\', '/')

path_splitted = PATH_ORIGIN.split('/')
path_splitted = path_splitted[:-2]
PATH_DESIGN   = '/'.join(path_splitted + FOLDER_DSGN)
PATH_VERIFY   = '/'.join(path_splitted + FOLDER_DSGN + FOLDER_VERF)


# ------------------------------------------------------------------------------
# Others constants 
SIM_FOLDER = 'sim'


os.chdir(PATH_DESIGN)


# ------------------------------------------------------------------------------
# 1. Lista tutte le librerie della cartella DESIGNER
# 2. Scegli la libreria di interesse
# 3. Lista tutti i file nella libreria scelta
# 4. Scegli un file
# ------------------------------------------------------------------------------
libs_list = [name for name in os.listdir() 
                           if os.path.isdir(name)]
print (81*'=')
print ("==== LIBRARY LIST ====")
for i in libs_list:
    print (i)
    
print ("Insert LIBRARY name:")
lib_name_std = sys.stdin.readline()
# lib_name_std = 'prime_lib\n'
lib_name_ext = lib_name_std[:-1]
path_files   = lib_name_ext + '/hdl'

print (81*'-')
print (F"FILE LIST OF THE SELECTED LIBRARY {lib_name_ext}:")
for path in Path().rglob(path_files + '/*.vhd'):
    print (path)

print ("Insert ENTITY name:")
entity_name_std = sys.stdin.readline()
# entity_name_std = 'alfa\n'
entity_name     = entity_name_std[:-1]
entity_name_tb  = entity_name_std[:-1] + '_tb'
folder_name     = entity_name_std[:-1]
file_name_src   = entity_name_std[:-1] + '.vhd'
file_name_tb    = entity_name_std[:-1] + '_tb' + '.vhd'
folder_sim      = 'sim'

com_file        = 'compile.tcl'
sim_file        = 'simulate.tcl'
test_file       = 'testcase.do'
path_sources    = PATH_DESIGN + '/' + lib_name_ext + '/' + 'hdl/'


os.chdir(PATH_ORIGIN)


# ------------------------------------------------------------------------------
# Constants Section
# ------------------------------------------------------------------------------
ck_name      = 'ck'
ck_freq      = '10'
ck_freq_half = '5'
part_num     = 'xcku15p-ffve1760-1-i'

TAB_LEN      = 3
LINE_LEN     = 79

# ------------------------------------------------------------------------------
# Assunti:
#   > i generici si trovano su righe separate
# ------------------------------------------------------------------------------
enter_match_lst = ['entity', 'ENTITY']
exit_match_lst  = ['end', 'END']
in_match_lst    = ['in', 'IN']
out_match_lst   = ['out', 'OUT']
pins_match_lst  = ['in', 'out']
comp_match_lst  = ['component', 'COMPONENT']

flag_entity     = 0 
flag_generic    = 0
flag_port       = 0
comp_lst        = []
in_dict         = {}
out_dict        = {}
pins_dict       = {}
sig_lst         = []
typ_lst         = []
file_list       = []

line_splitted   = []
line_splitted_x = []
libs_in_design  = []
pkgs_in_design  = []
generic_llst    = []
port_llst       = []
bkp_lst         = []
delimiters      = [':', '=', ';', '(', ')', '>']
delimiters_x    = [':', ';']
bkp_str         = ''

# ------------------------------------------------------------------------------
# Read Source File
# ------------------------------------------------------------------------------
with open(os.path.join(path_sources, file_name_src)) as file:
    for line in file:
        bkp_lst = []
        line_splitted = line.split()
        # salta le linee vuote
        if not line_splitted:
            continue
        # print(line_splitted)
        # salta le linee commentate
        if '--' in line_splitted[0]:
            continue
        if 'library' in line_splitted[0].lower():
            libs_in_design.append(line_splitted[0])
            continue
        if 'use ' in line_splitted[0].lower():
            line_splitted_x = line_splitted[1].split('.')
            pkgs_in_design.append(line_splitted_x[1])
            continue
        # ------------------------------------------------------------------
        if 'entity' in line_splitted[0].lower():
            flag_entity = 1
            continue
        if flag_entity and 'end' in line_splitted[0].lower():
            flag_entity = 0
            flag_port   = 0
            continue
        if flag_entity and 'generic' in line_splitted[0].lower():
            flag_generic = 1
            continue
        if ')' in line and ';' in line and flag_generic:
            flag_generic = 0
            continue
        if flag_entity and 'port' in line_splitted[0].lower():
            flag_port = 1
            continue
        # ------------------------------------------------------------------
        if flag_generic:
            bkp_str = line
            for delimiter in delimiters:
                bkp_str = " ".join(bkp_str.split(delimiter))
            line_splitted = bkp_str.split()
            generic_llst.append(line_splitted)
            continue
        # ------------------------------------------------------------------
        if flag_port:
            bkp_str = line
            for delimiter in delimiters:
                bkp_str = " ".join(bkp_str.split(delimiter))
            line_splitted = bkp_str.lower().split()
            # line_splitted = line.lower().split('in')
            # skip se vuota 
            if not line_splitted:
                continue
            # print(line_splitted)
            port_llst.append(line_splitted)


# Remove initial values of the ports
port_llst_bkp = port_llst
port_llst = []
for lst in port_llst_bkp:
   if 'downto' in lst or 'to' in lst:
      del lst[6:]
      port_llst.append(lst)
   else:
      del lst[3:]
      port_llst.append(lst)
port_llst

# ------------------------------------------------------------------------------
# Read Header file
# ------------------------------------------------------------------------------
os.chdir(PATH_ORIGIN + '/utilities')
header_lst = []
with open('header.txt') as file:
   for line in file:
      header_lst.append(line)


# ------------------------------------------------------------------------------
# Create Test Bench for the selected module
# ------------------------------------------------------------------------------
TAB_STR = 3*' '
generic_names = []
generic_types = []
beautifier_gnames = 0
beautifier_gtypes = 0

for gens in generic_llst:
   generic_names.append(gens[0])
   generic_types.append(gens[1])
if generic_names:
   beautifier_gnames = len(max(generic_names, key=len)) + 1
if generic_names:
   beautifier_gtypes = len(max(generic_types, key=len)) + 1

port_names = []
port_verso = []
port_types = []
for ports in port_llst:
   port_names.append(ports[0])
   port_verso.append(ports[1])
   port_types.append(ports[2])
if port_names:
   beautifier_pnames = len(max(port_names, key=len)) + 1
if port_verso:
   beautifier_pverso = len(max(port_verso, key=len))
if port_types:
   beautifier_ptypes = len(max(port_types, key=len)) + 1
beautifier_max    = max(beautifier_gnames, beautifier_pnames)

const_lst = []
signs_lst = []

os.chdir(PATH_VERIFY + '/hdl')
f = open(file_name_tb, 'w+')
# -----------------------------------
for lst in header_lst:
   f.write(lst)
f.write('\n\n')
f.write(f'library {lib_name_ext};\n')
f.write('\n\n')
# -----------------------------------
f.write('-- ' + 77 * '=' + '\n')
f.write('-- ENTITY\n')
f.write('-- ' + 77 * '=' + '\n')
f.write(f'entity {entity_name_tb} is\n')
f.write(f'end {entity_name_tb};\n')
f.write('\n')
f.write('\n')
# ---------------------------------------------------
f.write('-- ' + 77 * '=' + '\n')
f.write('-- ARCHITECTURE\n')
f.write('-- ' + 77 * '=' + '\n')
f.write('\n')
f.write(f'architecture beh of {entity_name_tb} is\n')
f.write('\n')
# COMPONENTS DECLARATIONS
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + '-- COMPONENTS DECLARATIONS\n')
f.write(TAB_STR + 77 * '-' + '\n')
f.write(f'   component {entity_name}\n')
# GENERICS
if generic_llst:
   f.write(TAB_STR + 'generic (\n')
   for gens in generic_llst:
      #f.write(f"{gens[0]}{:<{beautifier_gens}}")
      line = "{:<{x}}: {:<{y}} := {};".format(gens[0],
                                              gens[1],
                                              gens[2],
                                              x=beautifier_max,
                                              y=beautifier_gtypes)
      const_lst.append('constant ' + line)
      if gens == generic_llst[-1]:
         line = line.replace(';', '')
      f.write(2*TAB_STR + line)
      f.write('\n')
   f.write(3*' ' + ');\n')
# PORTS
if port_llst:
   f.write(TAB_STR + 'port (\n')
   for ports in port_llst:
      line = "{:<{x}}: {:<{y}} {};".format(ports[0],
                                           ports[1],
                                           ports[2],
                                           x=beautifier_max,
                                           y=beautifier_pverso)
      if len(ports) > 3:
         line = line.replace(';', '')
         line = line + ' (' + " ".join(ports[3:]) + ');'
      if ports == port_llst[-1]:
         line = line.replace(';', '')
      f.write(2*TAB_STR + line)
      f.write('\n')
   f.write(TAB_STR + ');\n')
   f.write(f'   end component {entity_name};\n')
# -------------------------------------------
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + '-- CONSTANTS\n')
f.write(TAB_STR + 77 * '-' + '\n')
for line in const_lst:
   f.write(TAB_STR + line)
   f.write('\n')
f.write('\n')
line = "{:<{x}}: {:<{y}} := {};".format('PER_CK',
                                        'time',
                                        '10 ns',
                                        x=beautifier_max,
                                        y=beautifier_gtypes)
f.write(TAB_STR + 'constant ' + line + '\n')
line = "{:<{x}}: {:<{y}} := {};".format('RST_LEN',
                                        'time',
                                        '100 ns',
                                        x=beautifier_max,
                                        y=beautifier_gtypes)
f.write(TAB_STR + 'constant ' + line + '\n')
f.write('\n')
# -------------------------------------------
f.write('\n')
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + '-- NETS\n')
f.write(TAB_STR + 77 * '-' + '\n')
for ports in port_llst:
   line = 'signal ' + "{:<{x}}: {};".format(ports[0],
                                            ports[2],
                                            x=beautifier_pnames)
   if len(ports) > 3:
         line = line.replace(';', '')
         line = line + ' (' + " ".join(ports[3:]) + ');'
   f.write(TAB_STR + line)
   f.write('\n')
# -------------------------------------------
f.write('\n')
f.write('begin\n')
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + '-- INSTANTIATION\n')
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + f'{entity_name}_i : {entity_name}\n')
if generic_llst:
   f.write(2*TAB_STR + 'generic map (\n')
   for gens in generic_llst:
      line = "{:<{x}}=> {},".format(gens[0],
                                     gens[0],
                                     x=beautifier_max)
      if gens == generic_llst[-1]:
         line = line.replace(',', '')
      f.write(3*TAB_STR + line)
      f.write('\n')
   f.write(2*TAB_STR + ')\n')
if port_llst:
   f.write(2*TAB_STR + 'port map (\n')
   for ports in port_llst:
      line = "{:<{x}}=> {},".format(ports[0],
                                    ports[0],
                                    x=beautifier_max)
      if ports == port_llst[-1]:
         line = line.replace(',', '')
      f.write(3*TAB_STR + line)
      f.write('\n')
   f.write(2*TAB_STR + ');\n')
# ---------------------------------------------------
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + '-- CLOCK GENERATION\n')
f.write(TAB_STR + 77 * '-' + '\n')
f.write(TAB_STR + 'p_ck: process\n')
f.write(TAB_STR + 'begin\n')
f.write(TAB_STR + '   ck <= \'0\';\n')
f.write(TAB_STR + '   wait for PER_CK/2;\n')
f.write(TAB_STR + '   ck <= \'1\';\n')
f.write(TAB_STR + '   wait for PER_CK/2;\n')
f.write(TAB_STR + 'end process p_ck;\n')
f.write('\n')
f.write(TAB_STR + 76 * '-' + '\n')
f.write(TAB_STR + '-- STIMULUS\n')
f.write(TAB_STR + 76 * '-' + '\n')
f.write(TAB_STR + 'p_stim: process\n')
f.write(TAB_STR + 'begin\n')
f.write(TAB_STR + '   \n')
f.write(TAB_STR + '   wait;\n')
f.write(TAB_STR + 'end process p_stim;\n')
f.write('\n')
f.write('end beh;')
f.close()


# ------------------------------------------------------------------------------
print(81*'-')
print('LOG:')
print(f"Created TB [{entity_name_tb}] in {PATH_VERIFY}/hdl\n")

# ------------------------------------------------------------------------------
input("Press Enter to continue...")

