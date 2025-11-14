import os
import re

from _const import *
from _helper import *

F_SRC = r'C:\Files\Projects\bbros\env_reference\scripts\items\weapons'
out = 'z_out/'
# PTH_HOOK_BASE = build_hook_path(F_SRC)

F_SRC = Path(F_SRC)
out = Path(out)

files = [p for p in F_SRC.rglob('*') if p.is_file()]

FIELDS = {
    'ID',
    'Categories',
    'Value',
    'ShieldDamage',
    'StaminaModifier',
    'RangeMin',
    'RangeMax',
    'RangeIdeal',
    'RegularDamage',
    'RegularDamageMax',
    'ArmorDamageMult',
    'DirectDamageMult',
    'ChanceToHitHead',
}

ledger = {}
for file in files:
    name = file.name
    encoding = get_file_encoding(file)
    
    # load files
    info = {}
    with open(file, "r", encoding=encoding) as f:
        lines = f.readlines()
        for line in lines:
            if not 'this.m' in line: continue
            try:
                m = re.search(r'this\.m\.(.+?) = (.+?);', line)
                if not m.group(1) in FIELDS: continue
                info[m.group(1)] = m.group(2)
            except:
                pass
     
    # process fields
    try:
        categories = []
        ts = info['Categories'].replace('"', '').replace(' ', '').replace('Two-Handed', '').replace('One-Handed', '').split(',')
        for t in ts:
            if '/' in t:
                t_strs = t.split('/')
                for t_str in t_strs:
                    categories.append(t_str)
                continue
            categories.append(t)
    except: continue
    
    key = ''
    for cat in categories:
        if cat == '': continue
        key = cat
        break
    
    if key == '': continue
    if not key in ledger: ledger[key] = {}
    ledger[key][info['ID']] = info
    print()
    

        
with open('test.nut', "w", encoding=encoding) as f_out:
    for key, cat in ledger.items():
        tuples = [(int(cat[x]['RegularDamageMax']), cat[x]['ID']) for x in cat]
        
        sorted_tuples = sorted(tuples)
        
        for t in sorted_tuples:
            _, id = t
            for k, v in cat[id].items():
                if k == 'Categories': continue
                if k == 'Value': continue
                if k == 'ShieldDamage': continue
                
                if k == 'StaminaModifier':
                    f_out.write(f'{k} : {int(v) // 5}\n')
                    continue
                
                if k == 'RegularDamage' or k == 'RegularDamageMax':
                    f_out.write(f'{k} : {int(v) // 10}\n')
                    continue
                f_out.write(f'{k} : {v}\n')
            f_out.write(f'\n')
                
        f_out.write(f'\n\n\n')
    
    

print()