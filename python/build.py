import shutil
import os

dir_output = 'C:/Files/Games/Battle Brothers/data/'

tups = [(f, os.path.join(os.getcwd(), f)) for f in os.listdir() if 'module ' in f and not 'bak' in f]
for i, tup in enumerate(tups):
    name, path = tup
    shutil.make_archive(name, 'zip', path)
    fname = f'{name}.zip'
    
    path_input = path + '.zip'
    path_output = dir_output + fname
    shutil.move(path_input, path_output)
print()