# ██╗░░██╗██╗███████╗██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗██╗░░░██╗
# ██║░░██║██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░██║╚██╗░██╔╝
# ███████║██║█████╗░░██████╔╝███████║██████╔╝██║░░╚═╝███████║░╚████╔╝░
# ██╔══██║██║██╔══╝░░██╔══██╗██╔══██║██╔══██╗██║░░██╗██╔══██║░░╚██╔╝░░
# ██║░░██║██║███████╗██║░░██║██║░░██║██║░░██║╚█████╔╝██║░░██║░░░██║░░░
# ╚═╝░░╚═╝╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░


# ==============================================================================
import os
import sys
from pathlib import Path


# ------------------------------------------------------------------------------
print ('██╗░░██╗██╗███████╗██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗██╗░░░██╗')
print ('██║░░██║██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░██║╚██╗░██╔╝')
print ('███████║██║█████╗░░██████╔╝███████║██████╔╝██║░░╚═╝███████║░╚████╔╝░')
print ('██╔══██║██║██╔══╝░░██╔══██╗██╔══██║██╔══██╗██║░░██╗██╔══██║░░╚██╔╝░░')
print ('██║░░██║██║███████╗██║░░██║██║░░██║██║░░██║╚█████╔╝██║░░██║░░░██║░░░')
print ('╚═╝░░╚═╝╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░')



# ------------------------------------------------------------------------------
# ASSUNTI: 
#     -> lo script viene lanciato dalla cartella: py/local_folder/script.py
#     -> il file scelto si trova in hdl/
FOLDER_DSGN   = ['designer']
FOLDER_VERF   = ['verification_lib']
OUT_FOLDER    = 'output'
# fold_name     = 'halo_top'

# FILE_PATH     = '../../designer'
# PATH_ORIGIN   = os.getcwd()
# PATH_ORIGIN   = '../py/get_filelist'


PATH_ORIGIN   = os.getcwd().replace('\\', '/')

path_splitted = PATH_ORIGIN.split('/')
path_splitted = path_splitted[:-2]
PATH_DESIGN   = '/'.join(path_splitted + FOLDER_DSGN)
PATH_VERIFY   = '/'.join(path_splitted + FOLDER_DSGN + FOLDER_VERF)

os.chdir(PATH_DESIGN)

# ------------------------------------------------------------------------------
# 1. Lista tutte le librerie della cartella DESIGNER
# 2. Scegli la libreria di interesse
# 3. Lista tutti i file nella libreria scelta
# 4. Scegli un file
# ------------------------------------------------------------------------------
libs_list = [name for name in os.listdir() 
                           if os.path.isdir(name)]
print ("==== LISTA LIBRERIE ====")
for i in libs_list:
    print (i)

print ("----------------------------------------------------------------------")
print ("Insert LIBRARY name:")
lib_name_std = sys.stdin.readline()
lib_name_ext = lib_name_std[:-1]
# path_files   = PATH_DESIGN + '/' + lib_name_ext + '/hdl'
path_files   = lib_name_ext + '/hdl'

print ("----------------------------------------------------------------------")
print (F"LISTA FILE NELLA LIBRERIA {lib_name_ext}:")
for path in Path().rglob(path_files + '/*.vhd'):
    print (path)
    
print ("----------------------------------------------------------------------")
print ("Insert ENTITY name:")
entity_name_std = sys.stdin.readline()
entity_name     = entity_name_std[:-1]


# ------------------------------------------------------------------------------
top_name = entity_name
lib_name = lib_name_ext

FILE_NAME_OUT = top_name + '_filelist_tot.txt'
PATH_OFFSET   = '../../designer'
OUT_FOLDER    = 'output'


# ------------------------------------------------------------------------------
lst_files = []
for path in Path().rglob('*.vhd'):
    lst_files.append(str(path))
    
# ------------------------------------------------------------------------------
# Crea una lista di liste. Ogni singola lista è composto da 3 campi:
#   - la libreria
#   - hdl (o il path completo)
#   - nome file
lst_splitted = []
lst_modular  = []
for line in lst_files:
    lst_bkp      = []
    lst_splitted = line.split('\\')
    # print(lst_splitted)
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
                    if line_splitted[1] not in comp_in_file:
                        comp_in_file.append(line_splitted[1].lower())
                        # Esiste un path che contiene questo componente?
                        for y in lst_modular:
                            if line_splitted[1].lower() + '.vhd' == y[-1].lower():
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
os.chdir(PATH_ORIGIN)
# ------------------------------------------------------------------------------
if not os.path.exists(OUT_FOLDER):
    os.makedirs(OUT_FOLDER)
    print('-- Created folder ' + f"{OUT_FOLDER}")
# ------------------------------------------------------------------------------        
fout = open(OUT_FOLDER + '/' + FILE_NAME_OUT, 'w+')
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
    if not os.path.exists(OUT_FOLDER + '/' + i):
        os.makedirs(OUT_FOLDER + '/' + i)
# ------------------------------------------------------------------------------
for i in libs_in_design:
    nome_file = i + '_filelist.txt'
    dest_path = OUT_FOLDER + '/' + i
    fout = open(os.path.join(dest_path, nome_file), 'w+')
    for j in filelist_ord:
        elem = j.split('/')
        if i.lower() == elem[0].lower():
            fout.write(j)
            fout.write('\n')
    fout.close()



# ------------------------------------------------------------------------------
input("Press Enter to continue...")

