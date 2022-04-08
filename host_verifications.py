#!/usr/bin/env python
# coding: utf-8

# In[22]:


import pandas as pd
import numpy as np
import matplotlib as plt


# In[11]:


pwd


# In[50]:


data=pd.read_csv("../Downloads/airbnb_london_cleaned.csv" , delimiter=",", dtype={"date":str})
data.head()


# In[52]:


data["host_verifications"]


# In[55]:


data["host_verifications"] = data["host_verifications"].apply(eval)
data["host_verifications"]


# In[76]:


arr = data["host_verifications"].explode().unique() 
hostver = arr.tolist()
hostver


# In[80]:


hostver


# In[87]:


for i in hostver:
    if i == None:
        hostver.remove(i)
hostver = [x for x in hostver if pd.isnull(x) == False]
hostver


# In[ ]:




