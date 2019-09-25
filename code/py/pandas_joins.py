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
# extract row '1' using the explicit indexing.  Since the index
# values aren't unique, you get multiple rows
pd.concat([A, B]).loc[1]
#%%
type(pd.concat([A, B]).loc[1])

#%%
# Now try using the implicit indexing
pd.concat([A, B]).iloc[1]
#%%
type(pd.concat([A, B]).iloc[1])


#%%
# Assume that we have a dataframe with a list of orders.
orders = pd.DataFrame({
          'order' : [   123,    456,      789,    823,     950,       1024],
       'customer' : [ 'Jeff',  'Bob', 'Annie', 'Jeff', 'Chuck', 'Michelle']})

items = pd.DataFrame({
        'order' : [   123,    123,    123,    456,    456,    789,    823,     950,    950,   1024],
          'sku' : ['A109', 'A100', 'A200', 'A109', 'A227', 'A109', 'A100',  'A300', 'A904', 'A200'],
        'price' : [765.55, 227.83,  12.50, 665.55,  10.68, 760.00, 225.55, 2650.55,  15.22,  12.25]})

skus = pd.DataFrame({
      'sku' : [   'A100',    'A109',    'A200',    'A227',    'A300',    'A876',    'A904'],
    'descr' : ['Widget1', 'Widget2', 'Widget3', 'Widget4', 'Widget5', 'Widget6', 'Widget7'],
     'cost' : [    12.50,    423.50,      6.50,      6.34,   1850.45,      3.23,      7.50]
})

#%%
full = pd.merge(skus, pd.merge(items, orders))
full['profit'] = full['price'] - full['cost']
full

