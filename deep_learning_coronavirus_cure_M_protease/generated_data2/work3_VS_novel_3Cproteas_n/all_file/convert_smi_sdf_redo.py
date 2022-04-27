import pandas as pd
from rdkit import Chem, DataStructs
import random
import numpy as np
import rdkit.Chem.PropertyMol
from rdkit.Chem import AllChem

gen0_table = pd.read_csv('selected_redo.smi',sep='\t', header=None)

gen0 = list(gen0_table[0])
name=list(gen0_table[1])
arr_all=zip(gen0,name)

for name in arr_all:
    print (name[0])
    m=Chem.MolFromSmiles(name[0])
    if m != None:
       pm= Chem.PropertyMol.PropertyMol(m)
       pm.SetProp("Title",name[1])
       print (pm.GetProp('Title'))
       m = Chem.AddHs(m) #
       inf=AllChem.EmbedMolecule(m) # 2D->3D
       print (inf)
       if inf != -1:
          AllChem.MMFFOptimizeMolecule(m)
          w = Chem.SDWriter(pm.GetProp('Title')+'.sdf')
          w.write(m)
'''

w = Chem.SDWriter('out.sdf')
for m in mols_for_export:
            w.write(m)


'''
