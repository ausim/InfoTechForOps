# -*- coding: utf-8 -*-
"""
Created on Tue Sep 24 21:06:14 2019

@author: jsmit
"""

#%%
import numpy as np
import pandas as pd
np.__version__, pd.__version__

# show
def show(data, show_data = 0):
    print ("  Type: {:}".format (type(data)))
    print (" Index: {:}".format(data.index))
    if type(data) == pd.core.frame.DataFrame:
        print ("Columns: {:}".format(data.columns))
    print (" Shape: {:}".format(data.shape))
    if show_data:
        print("  Data: {:}".format(data.values))

#%%
d1 = pd.Series([0.25, 0.5, 0.75, 1.0])
show(d1, 1)
d1

#%%
area = pd.Series({'California': 423967, 'Texas': 695662,
                  'New York': 141297, 'Florida': 170312,
                  'Illinois': 149995})
pop = pd.Series({'California': 38332521, 'Texas': 26448193,
                 'New York': 19651127, 'Florida': 19552860,
                 'Illinois': 12882135})
color = pd.Series({'California': 'blue', 'Texas': 'red',
                 'New York': 'blue', 'Florida': 'red',
                 'Illinois': 'purple'})
states = pd.DataFrame({'area':area, 'pop':pop, 'color':color})
show(states)
states
#%%
states['density'] = states['pop'] / states['area']
states
