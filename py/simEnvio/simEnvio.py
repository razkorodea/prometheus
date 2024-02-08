# ==============================================================================
import os
import sys
from pathlib import Path


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
# lib_name_std = 'verification_lib\n'
lib_name_ext = lib_name_std[:-1]
path_files   = lib_name_ext + '/hdl'

print (81*'-')
print (F"FILE LIST OF THE SELECTED LIBRARY {lib_name_ext}:")
for path in Path().rglob(path_files + '/*.vhd'):
    print (path)

print ("Insert ENTITY name:")
entity_name_std = sys.stdin.readline()
# entity_name_std = 'alfa_tb\n'
entity_name     = entity_name_std[:-1]
entity_name_tb  = entity_name_std[:-1] + '_tb'


# ------------------------------------------------------------------------------
top_name  = entity_name
lib_name  = lib_name_ext
fold_name = entity_name
fout_name = entity_name + '_filelist_tot.txt'


# ------------------------------------------------------------------------------
lst_files = []
for path in Path().rglob('*.vhd'):
    lst_files.append(str(path))

# ------------------------------------------------------------------------------
lst_splitted = []
dic_splitted = {}
lst_modular  = []
for line in lst_files:
    lst_bkp      = []
    lst_splitted = line.split('\\')
    # print(lst_splitted)
    #dic_splitted[lst_splitted[-1]] = lst_splitted[3]
    lst_bkp.append(lst_splitted[0])
    lst_bkp.append('/'.join(lst_splitted[1:-1]))
    lst_bkp.append(lst_splitted[-1])
    lst_modular.append(lst_bkp)

# ------------------------------------------------------------------------------
libs_in_prog = []
for i in lst_modular:
    if i[0].lower() not in libs_in_prog:
        libs_in_prog.append(i[0].lower())


# ==============================================================================
# CORE
# ==============================================================================
comp_match_lst = ['component', 'COMPONENT']
lib_match_lst  = ['library', 'LIBRARY', 'Library']
use_match_lst  = ['use', 'USE', 'Use']
files_to_loop  = []
libs_in_file   = []
libs_in_design = []
comp_in_file   = []
pkg_in_file    = []
filelist       = []
filelist_ord   = []
filelist_pkg   = []
line_splitted  = []
# ------------------------------------------------------------------------------
filelist.append(lib_name + '/hdl/' + top_name + '.vhd')
libs_in_design.append(lib_name)

for elem in filelist:
    libs_in_file = []
    comp_in_file = []
    pkg_in_file  = []
    elem_sp = elem.split('/')
    libs_in_file.append(elem_sp[0].lower())
    with open(elem) as file:
        for line in file:
            line = line.strip('\n')
            line = line.strip(';')
            line_splitted = line.split()
            if len(line_splitted) > 0:
                if '--' in line_splitted[0]:
                    continue
            # LIBRERIE
            if any([x in line_splitted for x in lib_match_lst]):
                if line_splitted[1] not in libs_in_file:
                    libs_in_file.append(line_splitted[1].lower())
                if line_splitted[1].lower() not in libs_in_design:
                    libs_in_design.append(line_splitted[1].lower())
            # PACKAGE
            if any([x in line_splitted for x in use_match_lst]):
                if '.' not in line_splitted[1]:
                    continue
                line_splitted = line_splitted[1].split('.')
                if line_splitted[1] not in pkg_in_file:
                    pkg_in_file.append(line_splitted[1])
                    for y in lst_modular:
                        if line_splitted[1].lower() + '.vhd' == y[-1].lower():
                            if y[0].lower() in libs_in_file:
                                cache_str = '/'.join(y)
                                if cache_str not in filelist:
                                    filelist.append(cache_str)
                                    filelist_pkg.append(cache_str)
            # COMPONENTI
            if any([x in line_splitted for x in comp_match_lst]):
                if line_splitted[0] in comp_match_lst:
                    if line_splitted[-1] not in comp_in_file:
                        comp_in_file.append(line_splitted[-1].lower())
                        # Esiste un path che contiene questo componente?
                        for y in lst_modular:
                            if line_splitted[-1].lower() + '.vhd' == y[-1].lower():
                                # filelist.append('/'.join(y))
                                if y[0].lower() in libs_in_file:
                                    cache_str = '/'.join(y)
                                    if cache_str not in filelist:
                                        filelist.append(cache_str)


# ------------------------------------------------------------------------------
for i in filelist_pkg:
    filelist.remove(i)

# ------------------------------------------------------------------------------
for i in libs_in_design:
    if i not in libs_in_prog:
        libs_in_design.remove(i)

# ------------------------------------------------------------------------------
for i in libs_in_design:
    if not os.path.exists(i + '/sim'):
        os.makedirs(i + '/sim')
    if not os.path.exists(i + '/work'):
        os.makedirs(i + '/work')
if not os.path.exists(PATH_VERIFY + '/sim/' + entity_name):
    os.makedirs(PATH_VERIFY + '/sim/' + entity_name)

# ------------------------------------------------------------------------------
fout = open(fout_name, 'w+')
fout.write(80*'-')
fout.write('\n')
for i in reversed(filelist_pkg):
    fout.write(i)
    filelist_ord.append(i)
    fout.write('\n')
for i in reversed(filelist):
    fout.write(i)
    filelist_ord.append(i)
    fout.write('\n')
fout.close()

# ------------------------------------------------------------------------------
for i in libs_in_design:
    if i not in libs_in_prog:
        libs_in_design.remove(i)

# ==============================================================================
# PERIPH
# ==============================================================================
TAB_LEN  = 3
LINE_LEN = 79

filelist_ord_red = []
for j in filelist_ord:
    elem = j.split('/')
    elem_red = elem.copy()
    elem_red.pop(0)
    filelist_ord_red.append('/'.join(elem_red))

beauty_filelist = len(max(filelist_ord_red, key=len)) + TAB_LEN + 1
beauty_libs     = len(max(libs_in_design, key=len)) + 4 + TAB_LEN
beauty_sim      = len(max(libs_in_design, key=len)) + len(entity_name) + TAB_LEN

for i in libs_in_design:
    nome_file = 'compile.tcl'
    dest_path = i + '/sim'
    base_path = '../'
    if i == 'verification_lib':
        dest_path = i + '/sim/' + fold_name
        base_path = '../../'
    libs_in_design_bkp = libs_in_design.copy()
    libs_in_design_bkp.remove(i)
    fout = open(os.path.join(dest_path, nome_file), 'w+')
    fout.write('# ' + 78*'-' + '\n')
    # ------------------------------------------------------------
    line = "{:<{x}} {}".format('vlib',
                               base_path+'work'+ '\n',
                               x=beauty_libs)
    fout.write(line)
    line = "{:<{x}} {}".format('vmap ' + i,
                               base_path+'work'+ '\n',
                               x=beauty_libs)
    fout.write(line)
    for j in libs_in_design_bkp:
        line = "{:<{x}} {}".format('vmap ' + j,
                                   '../'+base_path+j+'/work'+'\n',
                                   x=beauty_libs)
        fout.write(line)
    fout.write('# ' + 78*'-' + '\n')
    # ------------------------------------------------------------
    line = "{:<{x}} {}".format('vcom',
                               '\\' + '\n',
                               x=beauty_filelist+5)
    fout.write(line)
    line = "{:<{x}} {}".format(TAB_LEN*' '+'-work '+base_path+'work',
                               '\\' + '\n',
                               x=beauty_filelist+5)
    fout.write(line)
    # ------------------------------------------------------------
    for j in filelist_ord:
        elem = j.split('/')
        elem_red = elem.copy()
        elem_red.pop(0)
        if i.lower() == elem[0].lower():
            line = "{:<{x}} {}".format(TAB_LEN*' '+base_path+'/'.join(elem_red),
                               '\\' + '\n',
                               x=beauty_filelist+3)
            fout.write(line)
    fout.write(TAB_LEN*' ' + '+acc\n')
    fout.close()


# ------------------------------------------------------------------------------
modsim_file = 'modelsim.ini'
tscase_file = 'testcase.do'
simula_file = 'simulate.tcl'
dest_path   = PATH_VERIFY + '/sim/' + fold_name
base_path   = '../../'
# ------------------------------------------------------------
fout = open(os.path.join(dest_path, modsim_file), 'w+')
fout.close()
# ------------------------------------------------------------
fout = open(os.path.join(dest_path, tscase_file), 'w+')
fout.write('# ' + 78*'-' + '\n')
fout.write(f"add wave sim:/{entity_name}/*\n")
fout.write('run 10 us\n')
fout.close()
# ------------------------------------------------------------
fout = open(os.path.join(dest_path, simula_file), 'w+')
fout.write('# ' + 78*'-' + '\n')
line = "{:<{x}} {}".format('vsim',
                           '\\' + '\n',
                           x=beauty_sim+1)
fout.write(line)
line = "{:<{x}} {}".format(TAB_LEN*' '+FOLDER_VERF[0]+'.'+entity_name,
                           '\\' + '\n',
                           x=beauty_sim+1)
fout.write(line)
line = "{:<{x}} {}".format(TAB_LEN*' '+'-fsmdebug',
                           '\\' + '\n',
                           x=beauty_sim+1)
fout.write(line)
fout.write(TAB_LEN*' '+'-do '+tscase_file)
fout.close()

# ------------------------------------------------------------------------------
input("Press Enter to continue...")

