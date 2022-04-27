from rdkit import Chem

mol=Chem.MolFromMol2File('4AUA_ligand_n.mol2')
#mol = Chem.MolFromSmiles('Cc1ccccc1')
xx= Chem.rdmolops.GetFormalCharge(mol)


print (xx)
