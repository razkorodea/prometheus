# ==============================================================================
import os

# ------------------------------------------------------------------------------
# Introduction
# ------------------------------------------------------------------------------
print ("----------------------------------------------------------------")
print ("New Look !!!")
print ("----------------------------------------------------------------")
print ("")


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------
match_entity     = ['entity', 'ENTITY']
match_entity_end = ['end', 'END']
match_pins_in    = [' in ', ' IN ']
match_pins_out   = [' out ', ' OUT ']
match_pins       = [' in ', ' out ', ' IN ', ' OUT ']
match_generic    = ['generic', 'GENERIC']
match_port       = ['port', 'PORT']
match_not_cons   = ['--', ');']
flag_generic     = 0
flag_entity      = 0
comp_lst         = []
in_dict          = {}
out_dict         = {}
pins_dict        = {}
sig_lst          = []
typ_lst          = []
gens_lst         = []

file_name_i      = 'iput_file.txt'
file_name_x      = 'xput_file.txt'
file_name_o      = 'oput_file.txt'
ports_lst        = []


# ------------------------------------------------------------------------------
# Read Source File
# ------------------------------------------------------------------------------
with open(file_name_i) as file_in:
    for line in file_in:
        #--------------------------------------------------------------------
        if any([x in line for x in match_pins]):
           #file_out.write(line)
           words = line.split(':')
           ports_lst.append(words[0])
max_port_len = len(max(ports_lst, key=len))


file_out = open(file_name_x, 'w+')
with open(file_name_i) as file_in:
    for line in file_in:
        #-----------------------------------------------------------------------
        if any([x in line for x in match_pins]):
           #file_out.write(line)
           words = line.split(':')
           file_out.write(f"{words[0] : <{max_port_len}}")
           file_out.write(f": {words[1].strip()}")
           file_out.write('\n')
file_out.close()



file_out = open(file_name_o, 'w+')
with open(file_name_x) as file_in:
    for line in file_in:
        #--------------------------------------------------------------------
        if any([x in line for x in match_pins_in]):
           words = line.split(' in ')
           # words = line.split(' IN ')
           file_out.write(f"{words[0]} in  {words[1].lower()}")
        if any([x in line for x in match_pins_out]):
           words = line.split(' out ')
           # words = line.split(' OUT ')
           file_out.write(f"{words[0]} out {words[1].lower()}")
file_out.close()


# ------------------------------------------------------------------------------
input("Press Enter to continue...")

