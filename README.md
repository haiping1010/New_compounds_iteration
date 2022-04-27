The deep_learning_coronavirus_cure_M_protease  folder contains the script for retraining (retrain.py) , also codes for iterative retraining. Details see the deep_learning_coronavirus_cure_M_protease/readme.txt


The  deep_learning_PDE5D_n  deep_learning_TIPE2_n  deep_learning_coronavirus_cure_RdRp_n  deep_learning_PDL1-PDL1_n  deep_learning_Xanthine_Oxidase_n contains the protein information(receptor/), and final selected candidates(results/)

Readme:
Install:
conda create --name your_env_name
conda activate your_env_name
pip install -r requires.txt

cd  deep_learning_coronavirus_cure_M_protease 
####Training and Usage about LSTM_Chem  
###The pretrained LSTM_Chem model are located at  ./experiments/2019-12-23/LSTM_Chem/checkpoints/LSTM_Chem-baseline-model-full.hdf5
###if the user want to train the model by themself:
####training#####
###preparing the training data, using cleanup_smiles.py scrip to clear SMILES.  Manually modifed the base_config.json file
python  train.py
####geraration####
python generate_smi_fast2_batch.py
#####finetune training with given data(e.g.   ./generated_data/retrain.smi)#####
python retrain.py

################################
################################
####the whole iterative training pipeline take Main protease as example
round 1:
step 1: generating de novo compounds for screening:
python generate_smi_fast2_batch.py  

###or using the already generated de novo compounds
###

step 2: DFCNN screening
cd generated_data

cp -r  ../work3_VS_novel_template   work3_VS_novel_3Cproteas_n
python add_name.py
cp -r  gen_20.smi   work3_VS_novel_3Cproteas_n/all_file
cd  work3_VS_novel_3Cproteas_n/all_file
### need intall mol2vec from  https://github.com/samoturk/mol2vec , and put the mol2vec location in environment PATH#####
bash convert_smi_all.bash

####
conda activate  DFCNN-environment
cd pocket  ##(this folder already contain ????_w.pdb and ????_poc.pdb file, but for your own target, you need to prepare the protein and pocket yourself

grep    "^ATOM\|^TER\|^END"   6y2f.pdb >  6y2f_w.pdb
grep    "O6K A"  6y2f.pdb >  6y2f_ligand_n.pdb
babel   -ipdb   6y2f_ligand_n.pdb  -omol2   6y2f_ligand_n.mol2

python extract_pocket.py 6y2f    ####### to extract pocket
cp -r  ????_poc.pdb  ????_pocket.pdb
conda activate xxxx              #### (xxxx which environment you have install rdkit and mol2vec)
python  test_poc.py  6y2f    #####  to obtain the pocket molecule vector; need to change "/home/zhanghaiping/model_300dim.pkl" in the test_pocket.py in your own folder
)
conda deactivate 
cd ../
######
conda activate  yyyy   #### (yyyy which environment you have install keras, skearn, numpy, python2.7, details check the github xxxx)
bash run_all_n.bash
bash  run_all_prediction.bash   #####need change "/home/zhanghaiping/work/FCdense.h5" to the place where FCdense.h5 located

#after finished runing
bash score_sort.bash
cd  all_file
cp -r ../all_out_select.sort  .

##convert smi to sdf
### linpins's five
bash run_all.bash

###obtain sdf files for autodock vina docking
bash cp_file.bash

cp -r  final_sel/*.sdf  ../VINA3/ligand/
step 3: Autodock vina docking and linspik rule screening
### before you do this please intall MGLTools-1.5.6,pdbTools_0.2.1 and AutoDock Vina 1.1.2, and changed the environment seting in the run_run.bash corespondingly.
cd ../VINA3
cd receptor
cp -r ../../pocket/*  .
cp -r  6y2f_w.pdb    protein.pdb
cd ..

bash run_run.bash
###after finished autodocking vina running, extract and rank the scores
bash score.bash
cp -r all_energies.sort  ../all_file/
cd ../all_file/
head -n 110   all_energies.sort > all_energies_7.5.sort    #####extract compounds that have higher score than cutoff(e.g. -7.5kcal/mol)
cd select_final
cp -r ../all_energies_7.5.sort  ../gen_all.smi  .
python choose_sel.py  all_energies_7.5.sort  gen_all.smi
####################
#####obtain the candidates for next round iteration#######
####################
Step 4: collect final condidate for next round iterative fine-tune training and screening
cp  -r  retrain.smi     ../../../generated_data/retrain.smi



Round 2

python retrain.py
###after retraining finished, we got the generated de novo compounds, then all the following steps are same as above
mkdir generated_data2
cd generated_data2
step 1
similar to  round1
step 2
same as round1
step 3
same as  round1
Step 4: collect final condidate for next round iterative fine-tune training and screening
cp  -r  retrain.smi     ../../../generated_data/retrain2.smi


Round 3
python retrain2.py

###after retraining finished, we got the generated de novo compounds, then all the following steps are same as above
mkdir generated_data3
cd generated_data3
step 1
similar to step 1 in round1
step 2
similar as step 2  in  round1
step 3
similar as  step 3  in  round1
Step 4: collect final condidate for next round iterative fine-tune training and screening
cp  -r  retrain.smi     ../../../generated_data/retrain3.smi

Round 4
python retrain3.py

###after retraining finished, we got the generated de novo compounds, then all the following steps are same as above
mkdir generated_data3
cd generated_data3
step 1
similar to step 1 in round1
step 2
similar as step 2  in  round1
step 3
similar as  step 3  in  round1
Step 4: collect final condidate for next round iterative fine-tune training and screening
cp  -r  retrain.smi     ../../../generated_data/retrain4.smi




######################
###pocket MD simulation###
######################

cd  collection
bash cp_all.bash

###manually collect the docked complex that fullfiled the conditions to carried MD simulation. extract the ligands, and using pymol to munually added hydrogens and correct its structures(such as bond).

mkdir  pMD_run_redo_3Cprotease
cp   -r   pMD_template/*     pMD_run_redo_3Cprotease/

cd  pMD_run_redo_3Cprotease
cd pocket ###(before use, need install ambertools, acpype, prepare the charge.txt  file, which contains compound name and charge )
###The mol2 files are ligands from the docking, and manually corrected and adding hydrogen by pymol , obtain ligand like CHEMID_?_*_lig_n.mol2
###upload CHEMID_?_*_lig_n.mol2 file to this pocket/ folder, make sure the charge state are correct

bash creat_lig_n.bash

bash run_poc_a.bash
bash run_tleap.bash

cp -r  *_poc_ter_out.pdb   ../
cd ../
bash run_all_files.bash (it will run the simulation one by one, and using the script in run_folder)

### if used want to run metadyanmics further, the plumed supported GROMACS should installed
cd meta_file
bash  run_run.bash
###note, if a system not contain ion, it will fail, you can go to its runing folder, and modifed the gromac_meta.sh file accordingly, then rerun by : bash gromac_meta.sh


##if user not familiar with gromacs MD simulation, please learn the tutorial in xxx first, also can check their manual files for details, the analysis_redo contains some script to run MD analysis.
