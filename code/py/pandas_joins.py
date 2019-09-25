# -*- coding: utf-8 -*-
"""
Created on Wed Sep 25 05:09:41 2019

@author: jsmith
"""
#%%
import numpy as np
import pandas as pd
np.__version__, pd.__version__

#%%
A = pd.DataFrame({"A":[1, 2, 3], "B":[4, 5, 6]})
B = pd.DataFrame({"C":[1, 2, 3], "D":[4, 5, 6]})
#%%
pd.concat([A, B])

#%%
# Assume that we have a dataframe with a list of orders.
orders = pd.DataFrame({
          'order' : [   123,    456,      789,    823,     950,       1024], 
            'sku' : [ 'A109', 'A227',  'A876', 'A109',  'A227',     'B552'], 
       'customer' : [ 'Jeff',  'Bob', 'Annie', 'Jeff', 'Chuck', 'Michelle']})

items = pd.DataFrame({
        'order' : [   123,    123,    123,    456,    456,    789,    823,    950,    950,   1024],
          'sku' : ['A109', 'A100', 'A200', 'A109', 'A227', 'A109', 'A100', 'A300', 'A904', 'A200'],
        'price' : [765.55, 227.83,  12.50, 165.55,  10.68, 760.00, 225.55,   6.55,   5.22,  12.25]})

skus = pd.DataFrame({
     'sku' : [   'A100',    'A109',    'A200',    'A227',    'A300',    'A876',    'A904'],
    'name' : ['Widget1', 'Widget2', 'Widget3', 'Widget4', 'Widget5', 'Widget6', 'Widget7'],
    'cost' : [    12.50,    423.50,     96.50,     86.34,   1850.45,      3.23,      7.50]
})

#%%
sales = pd.merge(orders, skus, how="right")
sales

