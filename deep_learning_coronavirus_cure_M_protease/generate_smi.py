
import os
#os.environ["CUDA_VISIBLE_DEVICES"]="-1" 

import tensorflow
tensorflow.test.is_gpu_available()
import numpy as np
from copy import copy

#import keras

from lstm_chem.utils.config import process_config
from lstm_chem.model import LSTMChem
from lstm_chem.generator import LSTMChemGenerator
from lstm_chem.trainer import LSTMChemTrainer
from lstm_chem.data_loader import DataLoader

gpus = tensorflow.config.experimental.list_physical_devices(device_type='GPU')
tensorflow.config.experimental.set_visible_devices(devices=gpus[0:2], device_type='GPU')


CONFIG_FILE = 'experiments/2019-12-23/LSTM_Chem/config.json'
config = process_config(CONFIG_FILE)
config['model_weight_filename'] = 'experiments/2019-12-23/LSTM_Chem/checkpoints/LSTM_Chem-baseline-model-full.hdf5'
#print(config)

modeler = LSTMChem(config, session='generate')
generator = LSTMChemGenerator(modeler)
#print(config)

sample_number = 100000
import time
start = time.clock()
sampled_smiles = generator.sample(num=sample_number)


elapsed = (time.clock() - start)
print("Time used:",elapsed)

from rdkit import RDLogger, Chem, DataStructs
from rdkit.Chem import AllChem, Draw, Descriptors
from rdkit.Chem.Draw import IPythonConsole
RDLogger.DisableLog('rdApp.*')

valid_mols = []
for smi in sampled_smiles:
    mol = Chem.MolFromSmiles(smi)
    if mol is not None:
        valid_mols.append(mol)
# low validity
print('Validity: ', f'{len(valid_mols) / sample_number:.2%}')

valid_smiles = [Chem.MolToSmiles(mol) for mol in valid_mols]
# high uniqueness
print('Uniqueness: ', f'{len(set(valid_smiles)) / len(valid_smiles):.2%}')

# Of valid smiles generated, how many are truly original vs ocurring in the training data
import pandas as pd
training_data = pd.read_csv('./datasets/all_smiles_clean.smi', header=None)
training_set = set(list(training_data[0]))
original = []
for smile in valid_smiles:
    if not smile in training_set:
        original.append(smile)
print('Originality: ', f'{len(set(original)) / len(set(valid_smiles)):.2%}')


with open('./generations/gen0.smi', 'w') as f:
    for item in valid_smiles:
        f.write("%s\n" % item)




