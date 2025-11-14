import os
import re

from _const import *
from _helper import *

from generate_weapon_tables_helper import *

F_SRC = r'C:\Files\Projects\bbros\env_reference\scripts\items\weapons'
F_SRC2 = r'C:\Files\Projects\bbros\env_reference\mod_legends\scripts\items\weapons'
out = 'z_out/'
# PTH_HOOK_BASE = build_hook_path(F_SRC)

F_SRC = Path(F_SRC)
F_SRC2 = Path(F_SRC2)
out = Path(out)

files = [p for p in F_SRC.rglob('*') if p.is_file()] + [p for p in F_SRC2.rglob('*') if p.is_file()]

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
    except: 
        categories = ['Bad Sorting, Dev Didn\'t Categorize In Code Correctly']
        info['Categories'] = 'One-Handed'
        
    info['1H'] = 'One-Handed' in info['Categories']
    
    key = ''
    for cat in categories:
        if cat == '': continue
        key = cat
        break
    
    if key == '': continue
    if not key in ledger: ledger[key] = {}
    try:
        ledger[key][info['ID']] = info
    except: continue
    print()
    
cat_order = [
    'Dagger',
    'Sword',
    'Cleaver',
    'Axe',
    'Spear',
    'Polearm',
    'Mace',
    'Hammer',
    'Flail',
    'Bow',
    'Crossbow',
    'ThrowingWeapon',
    'MusicalInstrument',
    'Firearm',
    'Bad Sorting, Dev Didn\'t Categorize In Code Correctly'
]

        
with open('module 02.00 - weapons/02_00/_DEF/_weapon_table.nut', "w", encoding=encoding) as f_out:
    f_out.write(f'// This is an auto-generated table of weapon stats. Please see below files for overrides/corrections\n')
    f_out.write('::DEF.C.Weapons <- {\n')
    
    
    for key in cat_order:
        cat = ledger[key]
        f_out.write(f'//==================================================================================================\n')
        f_out.write(f'//{key} \n')
        f_out.write(f'//==================================================================================================\n\n')
        
        tuples = []
        for x in cat:
            if x == '"shield.legend_parrying_dagger"': continue
            if x == '"shield.legend_named_parrying_dagger"': continue
            if not cat[x]['1H']: continue
            tuples.append((int(cat[x]['RegularDamage']), int(cat[x]['RegularDamageMax']), cat[x]['ID']))
        sorted_tuples = sorted(tuples, key=lambda item: (item[0], item[1]))
        
        
        tuples2 = []
        for x in cat:
            if cat[x]['1H']: continue
            tuples2.append((int(cat[x]['RegularDamage']), int(cat[x]['RegularDamageMax']), cat[x]['ID']))
        sorted_tuples2 = sorted(tuples2)
        
        
        for i, l in enumerate([sorted_tuples, sorted_tuples2]):
            if i == 0: f_out.write(f'\t// 1H \n')
            else: f_out.write(f'\t// 2H \n')
            
            # ::DEF.C.Weapons <- {
            #     "arming sword" : {
                    
            #     }
            # };
            
            for t in l:
                _, _, id = t
                f_out.write(f'\t{id} : ' + '{\n')
                for k, v in cat[id].items():
                    if k == 'ID': continue
                    if k == 'Categories': continue
                    if k == 'Value': continue
                    if k == 'ShieldDamage': continue
                    if k == '1H': continue
                    
                    if k == 'DirectDamageMult':  continue                     
                    if k == 'ArmorDamageMult':  continue                     
                    if k == 'RegularDamage' or k == 'RegularDamageMax':
                        # val = max(int(v) - 10, 1)
                        val = int(v) * 0.75
                        # if float(cat[id]['ArmorDamageMult']) < 1.0:
                        #     val = int(val * float(cat[id]['ArmorDamageMult']))
                        val = round(val / 5.0) * 5
                        f_out.write(f'\t\t"{k}" : {val},\n')
                        continue
                        
                    f_out.write(f'\t\t"{k}" : {v},\n')
                f_out.write('\t},\n')
                
        f_out.write(f'\n\n\n')
    
    f_out.write('};')
    
    
    

print(ledger.keys())