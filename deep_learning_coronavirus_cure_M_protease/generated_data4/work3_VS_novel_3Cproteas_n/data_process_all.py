import pandas as pd
import numpy as np
from pandas import DataFrame
from glob import glob
import sys
from time import time
path = sys.argv[1]
mp_data=sys.argv[2]

l_files = glob(path +  '/*.csv')

t = pd.read_csv(l_files[0])
lc = t.columns[2:]
##l_files = glob(path +  '/*.csv')
l_files = glob(path +  '/'+ mp_data.replace('mp_data_','')  +'*.csv')
l_len = len(l_files)
ligands = DataFrame(columns = lc)

for l in l_files:
    t = pd.read_csv(l)
    ligands = ligands.append(t.ix[:, 2:], ignore_index = True)
    print(t.shape, t.ix[0, 2], l)

#print(ligands.shape)
#print(l_len)
p_files = glob(path +'/*_pocVec.txt')
p_len = len(p_files)
proteins = DataFrame()
for i, p in enumerate(p_files):
    print(i * 1.0 / p_len)
    f = open(p)
    t = f.read()
    t = t[:-1].replace('[ ', '').replace('[', '').replace('\n', '').split()
    t.insert(0, p.split('/')[-1].split('.')[0])
    t = DataFrame(np.array(t).reshape(1, -1))
    if t.shape == (1, 301):
        proteins = proteins.append(t, ignore_index=True)
    else:
        print(t.shape, p)

#print(proteins.shape)
#print(p_len)
#np.sum(np.sum(proteins.isna()))

ligands.to_hdf(mp_data+'/ligands.h5', 'df')

proteins.to_hdf(mp_data+'/proteins.h5', 'df')

ligands = pd.read_hdf(mp_data+'/ligands.h5', 'df')
proteins = pd.read_hdf(mp_data+'/proteins.h5', 'df')

print(ligands.shape)
#print(l_len)
print(proteins.shape)
#print(p_len)
############################################
############################################
#proteins.head()
#proteins.head()
##t = np.hstack((tp, tl))
##pos = DataFrame()
##pos = pos.append(DataFrame(t))
pos = DataFrame()
pos_list_used = []

sta = time()
protein = pd.DataFrame(np.repeat(proteins.values, ligands.shape[0], axis=0))
ligand = ligands.ix[:, 1:]
protein = protein.ix[:, 1:]
for i in range(ligands.shape[0]):
    ligname = ligands.ix[i, 0].replace(' ','_')
    pos_list_used.append(ligname)
compound = DataFrame(np.hstack((protein, ligand)))
pos = pos.append(compound, ignore_index = True)

#pos_list_used.append(ligname)
print(compound.shape)
end = time()
print((end - sta) / 60.0)

#pos.shape
#print(np.sum(ligands.ix[:, 0] == '3P3J_LIGAND'))
#print(np.sum(proteins.ix[:, 0] == '3p3j_pocVec'))
'''
def bind(pname, lname):
    protein = proteins[proteins.ix[:, 0] == pname].ix[:, 1:]
    ligand = ligands[ligands.ix[:, 0] == lname].ix[:, 1:]
    compound = DataFrame(np.hstack((protein, ligand)))
    return compound
'''
#proteins[proteins.ix[:, 0] == '2ql5_pocVec'].ix[:, 1:]
#ligands[ligands.ix[:, 0] == '2QL5_LIGAND'].ix[:, 1:]

#aligandname=sys.argv[2]
#s = pos.append(bind('_pocVec', '3P3J_LIGAND'), ignore_index=True)
#pos_list_used.append('3p3j')
#pos.shape
#pos.head()

sta = time()
pos.to_hdf(mp_data+'/pos.h5', 'df')

pos_read = pd.read_hdf(mp_data+'/pos.h5', 'df')
pos_list_used = DataFrame(pos_list_used)
pos_list_used.to_csv(mp_data+'/pos_list.csv', index = False, header = ['name'])
pos_list_used.head()

end = time()
print((end - sta) / 60.0)




