import pandas as pd
import tensorflow as tf

import keras
#import keras.backend as K

from keras.models import Model, load_model
from keras.layers import Input, merge, Activation, Dropout, Dense, concatenate, Concatenate, Flatten
from keras.layers.convolutional import Convolution1D
from keras.layers.pooling import AveragePooling1D, GlobalAveragePooling1D, MaxPool1D
from keras.layers.normalization import BatchNormalization
from keras.regularizers import l2

from keras.optimizers import SGD
from keras.callbacks import ModelCheckpoint
from keras.preprocessing.image import ImageDataGenerator

#import xgboost as xgb
from sklearn import metrics

import os
import yaml
import numpy as np

#import h5py
#with h5py.File('pos_aa1000.h5', 'r') as hf:
#    pos_samples = hf['name-of-dataset1'][:]
#with h5py.File('neg_aa1000.h5', 'r') as hf:
#    neg_samples = hf['name-of-dataset2'][:]

import sys
mp_data = sys.argv[1]



pos = np.array(pd.read_hdf(mp_data+'/pos.h5', 'df'), dtype=float)

#pos=pos.astpye(float)
#neg=neg.astpye(float)

pos_label = np.ones(pos.shape[0])
test_X = pos


test_X_conv = test_X.reshape((test_X.shape[0], 600, 1))


def preprocess_data_train(data_set):
    mean = -1.4986
    std = 87.8869

    t = data_set

    t -= mean
    t /= std
    return t



def preprocess_data(data_set):
    mean = np.mean(data_set)
    std = np.std(data_set)
    
    t = data_set

    t -= mean
    t /= std
    return t

def aucJ(true_labels, predictions):
    
    fpr, tpr, thresholds = metrics.roc_curve(true_labels, predictions, pos_label=1)
    auc = metrics.auc(fpr,tpr)

    return auc

def acc(true, pred):
    
    return np.sum(true == pred) * 1.0 / len(true)

def assess(model, X, label, thre = 0.5):
    
    threshold = thre
    
    pred = model.predict(X)
    pred = pred.flatten()
    
    pred[pred > threshold] = 1
    pred[pred <= threshold] = 0
    
    auc = aucJ(label, pred)
    accuracy = acc(label, pred)
    
    print('auc: ', auc)
    print('accuracy: ', accuracy)




test_X = preprocess_data_train(test_X)



def densef(X_prev, X):
    
    return concatenate([X_prev, X], axis = -1)

def dfblock(X, layer_num, dropout = 0.1, shape = 200, l2_reg = 1e-4):
    
    X_prev = Dense(shape, init = 'glorot_normal', activation = 'relu', kernel_regularizer = l2(l2_reg))(X)
    X_prev = BatchNormalization(axis = 1, beta_regularizer = l2(l2_reg), gamma_regularizer = l2(l2_reg))(X_prev)
    X_prev = densef(X, X_prev)
    X_prev = Dropout(dropout)(X_prev)
    
    for i in range(layer_num - 1):
        X = Dense(shape, init = 'glorot_normal', activation = 'relu', kernel_regularizer = l2(l2_reg))(X_prev)
        X = BatchNormalization(axis = 1, beta_regularizer = l2(l2_reg), gamma_regularizer = l2(l2_reg))(X)
        X_prev = densef(X, X_prev)
        X_prev = Dropout(dropout)(X_prev)
    
    return X_prev

def noblock(X, dropout = 0.1, shape = 600, l2_reg = 1e-4):
    
    X = Dense(shape, init = 'glorot_normal', activation = 'relu', kernel_regularizer = l2(l2_reg))(X)
    X = BatchNormalization(axis = 1)(X)
    X = Dropout(dropout)(X)
    
    return X

def Dense_FCNN1(input_shape, dense_layer = 3, layer_num = 3, denshape = 200, dropout = 0.1, l2_reg = 1e-4):
    
    X_input = Input(input_shape)
    
    X = dfblock(X_input, layer_num = layer_num, dropout = dropout, shape = denshape, l2_reg = l2_reg)
    X = noblock(X, dropout, input_shape[0], l2_reg)
    
    for i in range(dense_layer - 1):
        X = dfblock(X, layer_num = layer_num, dropout = dropout, shape = denshape, l2_reg = l2_reg)
        X = noblock(X, dropout, input_shape[0], l2_reg)
    
    out = Dense(1, init = 'glorot_normal', activation = 'sigmoid')(X)
    
    model = Model(inputs = X_input, outputs = out, name = 'FCNN1')
    
    return model

model2 = Dense_FCNN1((600, ), 1, 16, 128, 0.15, 1e-4)
#model2.compile(optimizer = 'Adam', loss = 'binary_crossentropy', metrics = ['accuracy'])

model2.summary()


##model2.fit(x = train_X, y = train_Y, epochs = 15000, batch_size = 8192)

#assess(model2, train_X, train_Y)
#assess(model2, valid_X, valid_Y)
#assess(model2, test_X, test_Y)

##model2.save('FCdenset.h5')

model2 = load_model('/home/zhanghaiping/work/FCdense.h5')

#assess(model2, test_X, test_Y)

pred = model2.predict(test_X)
pred = pred.flatten()

import pandas as pd
df=pd.read_csv(mp_data+'/pos_list.csv', header=None)

name=df.iloc[1:,0].values
listA=zip(list(name),list(pred))
#for i in range(len(pred)):
#     listA[i][0]=pred[i]
#     listA[i][1]=name[i]
y=sorted(listA,key=lambda l:l[1],reverse=True)
fw=open(mp_data+'/sorted_out.txt','w')
for i in range(len(y)):
     print (y[i][0], y[i][1])
     fw.write(str(y[i][0]) +"  "+ str(y[i][1]))
     fw.write('\n')

fw.close()

