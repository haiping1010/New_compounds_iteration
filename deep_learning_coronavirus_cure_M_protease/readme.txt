README:
The generate_smi_fast2_batch.py was used to fast generate de novo smiles


The retrain.py  was used to retrain the model with given simile sets, and then generated de novo simile based on the generated new models.


The retrain2.py , retrain3.py, retrain4.py are code of  the iteration 2, 3, and 4  for  retraining and gerenteration process.


The generated_data*/work3_VS_novel_3Cproteas_n  are folders for DFCNN screening.  data_process_all.py was used for preparing the data, and deep_dense_FC_load.py was used to do the prediction, details can reference to our previous paper(IVS2vec: A tool of Inverse Virtual Screening based on word2vec and deep learning techniques). 


After DFCNN screening, autodock vina docking was followed, about autodock Vina, please check their tutorial and the parameter seting in our paper.


The collection folder contains the final obtained candidate files for later stage MD simulation and metadynamics simulation.


The details of how to run MD simulation and metadynamics simulation can follow the  gromacs tuturial related to protein-ligand simulation(http://www.mdtutorials.com/gmx/complex/index.html) and Plumed tutorial related to metadynamics section (https://www.plumed.org/doc-v2.7/user-doc/html/masterclass-21-4.html).




