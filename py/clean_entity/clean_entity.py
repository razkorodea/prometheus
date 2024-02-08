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
match_vects      = ['downto', 'to']

file_name_i      = 'iput_file.txt'
file_name_x      = 'xput_file.txt'
file_name_y      = 'yput_file.txt'
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


file_out = open(file_name_y, 'w+')
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
# Sistema lo stile delle porte vettoriali
# ------------------------------------------------------------------------------
file_out = open(file_name_o, 'w+')
with open(file_name_y) as file_in:
    for line in file_in:
        #--------------------------------------------------------------------
        if any([x in line for x in match_vects]):
           words = line.split('(')
           if ' to ' in words[1]:
               tokens = words[1].split(' to ')
               tokens[0] = tokens[0].replace(" ","")
               tokens[1] = tokens[1].replace(' ', '')
               tokens[1] = tokens[1].replace(')', '')
               tokens[1] = tokens[1].replace(';', '')
               tokens[1] = tokens[1].replace('\n', '')
               file_out.write(f"{words[0]}({tokens[0] : >2} to {tokens[1]});\n")
           if ' downto ' in words[1]:
               tokens = words[1].split(' downto ')
               tokens[0] = tokens[0].replace(" ","")
               tokens[1] = tokens[1].replace(' ', '')
               tokens[1] = tokens[1].replace(')', '')
               tokens[1] = tokens[1].replace(';', '')
               tokens[1] = tokens[1].replace('\n', '')
               file_out.write(f"{words[0]}({tokens[0] : >2} downto {tokens[1]});\n")
        else:
            file_out.write(line)
file_out.close()


# ------------------------------------------------------------------------------
input("Press Enter to continue...")

