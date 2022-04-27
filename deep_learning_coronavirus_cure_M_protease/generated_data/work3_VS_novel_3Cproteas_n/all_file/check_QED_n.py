from rdkit import rdBase,Chem
from rdkit.Chem  import PandasTools,QED,Descriptors,rdMolDescriptors
#%matplotlib inline
#print (rdBase.rdkitVersion)

import sys

input=sys.argv[1]
df = PandasTools.LoadSDF(input)
#len(df)
df['QED']= df.ROMol.map(QED.qed)

def rule_of_five(m):
    mw = Descriptors.MolWt(m)
    logp = Descriptors.MolLogP(m)
    hba = rdMolDescriptors.CalcNumLipinskiHBA(m)
    hbd = rdMolDescriptors.CalcNumLipinskiHBD(m)
    psa =Descriptors.TPSA(m)
    
    if (mw <= 500 and logp <=5 and hbd <=5 and hba <= 10):
        
              return 1
    
    else:
              return 0


df['Lipinski'] = df.ROMol.map(rule_of_five)
#print (df)
#print  (df['QED'].values[0])
print input,df['QED'].values[0],df['Lipinski'].values[0]
#import  matplotlib as mpl
#import seaborn as sns
#with mpl.style.context('seaborn'):
#    sns.violinplot(x='Lipinski', y='QED', data=df)
