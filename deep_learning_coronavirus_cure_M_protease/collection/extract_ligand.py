
import sys

inputfile=sys.argv[1]


fr=open(inputfile,'r')


fw=open(inputfile.replace('_complex.pdb','_lig_n.pdb'),'w')
arr=fr.readlines()

index=0
for name in arr:
    if  name.startswith('MODEL'):
          index=200
    if  index==200:
        if name.startswith('ATOM'):
            fw.write(name[0:17]+'UNK'+name[20:])


fr.close()
fw.close()
