#!/usr/bin/env python3

from copy import copy
from GRU_chem.utils.config import process_config
from GRU_chem.utils.dirs import create_dirs
from GRU_chem.data_loader import DataLoader
from GRU_chem.model import GRUChem
from GRU_chem.trainer import GRUChemTrainer

CONFIG_FILE = 'base_config.json'


def main():
    config = process_config(CONFIG_FILE)

    # create the experiments dirs
    create_dirs(
        [config.exp_dir, config.tensorboard_log_dir, config.checkpoint_dir])

    print('Create the data generator.')
    train_dl = DataLoader(config, data_type='train')
    valid_dl = copy(train_dl)
    valid_dl.data_type = 'valid'

    print('Create the model.')
    modeler = GRUChem(config, session='train')

    print('Create the trainer')
    trainer = GRUChemTrainer(modeler, train_dl, valid_dl)

    print('Start training the model.')
    trainer.train()


if __name__ == '__main__':
    main()
