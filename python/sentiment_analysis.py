# -*- coding: utf-8 -*-
"""
Created on Fri Sep 30 00:28:26 2016

@author: cmoreno
"""

import urllib

# define URLs
test_data_url = "https://kaggle2.blob.core.windows.net/competitions-data/inclass/2558/testdata.txt?sv=2012-02-12&se=2015-08-06T10%3A32%3A23Z&sr=b&sp=r&sig=a8lqVKO0%2FLjN4hMrFo71sPcnMzltKk1HN8m7OPolArw%3D"
train_data_url = "https://kaggle2.blob.core.windows.net/competitions-data/inclass/2558/training.txt?sv=2012-02-12&se=2015-08-06T10%3A34%3A08Z&sr=b&sp=r&sig=meGjVzfSsvayeJiDdKY9S6C9ep7qW8v74M6XzON0YQk%3D"

# define local file names
test_data_file_name = 'test_data.csv'
train_data_file_name = 'train_data.csv'

# download files using urlib
test_data_f = urllib.urlretrieve(test_data_url, test_data_file_name)
train_data_f = urllib.urlretrieve(train_data_url, train_data_file_name)

