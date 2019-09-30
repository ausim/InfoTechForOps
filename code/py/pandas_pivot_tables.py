# -*- coding: utf-8 -*-
"""
Created on Mon Sep 30 07:56:47 2019

@author: jsmit

From Vanderplas Book
"""
#%%
import numpy as np
import pandas as pd
import seaborn as sns
#%%
titanic = sns.load_dataset('titanic')
titanic.head()

titanic.groupby('sex')[['survived']].mean()

titanic.groupby(['sex', 'class'])['survived'].aggregate('mean').unstack()