
import sys

input=sys.argv[1]


fr=open(input,'r')

input_l=input.replace('_poc_ter_out.pdb','_lig.pdb')

output=input.replace('_poc_ter_out.pdb','_n.pdb')
print output
fr_l=open(input_l,'r')


arr=fr.readlines()
arr_l=fr_l.readlines()

fw=open(output,'w')

for name in arr:
     if name.strip() =='END':
         for line in arr_l:
             fw.write(line)
         fw.write(name)
     else:
         fw.write(name)
