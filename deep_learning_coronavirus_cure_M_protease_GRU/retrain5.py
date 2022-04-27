import tensorflow
tensorflow.test.is_gpu_available()
import numpy as np
from copy import copy

#import keras

from GRU_chem.utils.config import process_config
from GRU_chem.model import GRUChem
from GRU_chem.generator import GRUChemGenerator
from GRU_chem.trainer import GRUChemTrainer
from GRU_chem.data_loader import DataLoader
'''
# Generate some with the base original model
CONFIG_FILE = 'experiments/2019-12-23/GRU_Chem/config.json'
config = process_config(CONFIG_FILE)
modeler = GRUChem(config, session='generate')
generator = GRUChemGenerator(modeler)

sample_number = 20
'''

from GRU_chem.finetuner import GRUChemFinetuner

config = process_config('experiments/2019-12-23/GRU_Chem/config.json')
config['model_weight_filename'] = 'experiments/2019-12-23/GRU_Chem/checkpoints/finetuned_gen' +'5.hdf5'
config['finetune_data_filename'] = './generated_data/retrain5.smi'
#print(config)

modeler = GRUChem(config, session='finetune')
finetune_dl = DataLoader(config, data_type='finetune')

finetuner = GRUChemFinetuner(modeler, finetune_dl)
finetuner.finetune()
finetuner.model.save_weights('experiments/2019-12-23/GRU_Chem/checkpoints/finetuned_gen5.hdf5')

config = process_config('experiments/2019-12-23/GRU_Chem/config.json')
#config['finetune_data_filename'] = './generated_data/retrain.smi'

config['model_weight_filename'] = 'experiments/2019-12-23/GRU_Chem/checkpoints/finetuned_gen5.hdf5'
modeler = GRUChem(config, session='generate')
generator = GRUChemGenerator(modeler)
#print(config)

sample_number = 50000
#sampled_smiles = generator.sample(num=sample_number)


import time
from tqdm import tqdm
import numpy as np
from GRU_chem.utils.smiles_tokenizer import SmilesTokenizer
from rdkit import Chem, RDLogger
RDLogger.DisableLog('rdApp.*')

def _generate( sequence):
        while (sequence[-1] != 'E') and (len(SmilesTokenizer().tokenize(sequence)) <=
                                         modeler.config.smiles_max_length):
            #print (sequence)
            x = SmilesTokenizer().one_hot_encode(SmilesTokenizer().tokenize(sequence))
            print (x)
            
            preds = modeler.model.predict_on_batch(x)[0][-1]
            #next_idx = self.sample_with_temp(preds)
            streched = np.log(preds) / modeler.config.sampling_temp
            streched_probs = np.exp(streched) / np.sum(np.exp(streched))
            next_idx=np.random.choice(range(len(streched)), p=streched_probs)
            sequence += SmilesTokenizer().table[next_idx]
        sequence = sequence[1:].rstrip('E')
        return sequence

import time
start = time.clock()
allarr=[]
sampled = []
if modeler.session == 'generate':
    batch=10000
    iterations = int(sample_number/batch)
    print (iterations)
    for id in range(iterations):
      print (id)
      starts = ['G' for x in range(batch)]
      sequences=starts
      #print (len(sequences[0]))
      while  (len(sequences[0]) <=  modeler.config.smiles_max_length):
      #while  (len(SmilesTokenizer().tokenize(sequence)) <=  modeler.config.smiles_max_length):
            #starts = ['G' for x in range(sample_number)]
            #print (SmilesTokenizer().tokenize_matrix(sequences))
            x = SmilesTokenizer().one_hot_encode_matrix(SmilesTokenizer().tokenize_matrix(sequences))        
            #print (x.shape)
            preds = modeler.model.predict_on_batch(x)[:,-1,:]
            #print (preds.shape)
            streched = np.log(preds) / modeler.config.sampling_temp
            #print (streched)
            #streched_probs = np.exp(streched) / np.sum(np.exp(streched))
            for i in range(streched.shape[0]):
               streched_probs = np.exp(streched[i]) / np.sum(np.exp(streched[i]))
               next_idx=np.random.choice(range(len(streched[i])), p=streched_probs)
               sequences[i] += SmilesTokenizer().table[next_idx]
            #print (sequences)
            #print (next_idx.shape)
            #for _ in range(num):
            #    sampled.append(self._generate(start))
      allarr.extend(sequences)
#print (sequences)


elapsed = (time.clock() - start)
print("Time used:",elapsed)

import time
start = time.clock()
#sampled_smiles = generator.sample(num=sample_number)
sampled_smiles = []
for name in allarr:
    temarr=name.split('E')
    sampled_smiles.append(temarr[0][1:])

from rdkit import RDLogger, Chem, DataStructs
from rdkit.Chem import AllChem, Draw, Descriptors
from rdkit.Chem.Draw import IPythonConsole
RDLogger.DisableLog('rdApp.*')

valid_mols = []
for smi in sampled_smiles:
    #print(smi)
    mol = Chem.MolFromSmiles(smi)
    
    if mol is not None:
        #print (mol)
        valid_mols.append(mol)
# low validity
print('Validity: ', f'{len(valid_mols) / sample_number:.2%}')

valid_smiles = [Chem.MolToSmiles(mol) for mol in valid_mols]
# high uniqueness
print('Uniqueness: ', f'{len(set(valid_smiles)) / len(valid_smiles):.2%}')

# Of valid smiles generated, how many are truly original vs ocurring in the training data
import pandas as pd
training_data = pd.read_csv('./generated_data/retrain5.smi', header=None)
training_set = set(list(training_data[0]))
original = []
for smile in valid_smiles:
    if not smile in training_set:
        original.append(smile)
print('Originality: ', f'{len(set(original)) / len(set(valid_smiles)):.2%}')


with open('./generations/gen_05.smi', 'w') as f:
    for item in list(set(valid_smiles)):
        f.write("%s\n" % item)

f.close()









