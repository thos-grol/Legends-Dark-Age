import os

# automates generation of boilerplate code
PATH_STR = 'module 01.03 - perks/01_03/src/__WEAPON/!STR/'
PATH_ADD = 'module 01.03 - perks/01_03/src/__WEAPON/ADD/'
PATH_PERKS = 'module 01.03 - perks/scripts/skills/perks/'

TREE_NAME = None

tree_def = []

OUTPUT = {
    'STR' : '',
    'ADD' : '',
    'FILES' : {
        
    }
}

# generate chunks

with open('python/generate_info_perk_weapon.cfg', "r") as f:
    temp = f.readlines()

lines = []
sublines = []

# chunk file
for i, line in enumerate(temp):
    if (i == 0): 
        TREE_NAME = line.strip()
        continue
    if line.strip() == '':
        lines.append(sublines)
        sublines = []
    else:
        sublines.append(line.strip())
lines.append(sublines)

OUTPUT['ADD'] += 'local pt = [];\n'


# build files
for i, row in enumerate(lines):
    
    if len(row) == 1 and row[0] == 'X': continue
    
    row_template = f"""
// =================================================================================================
// {i + 1}
// =================================================================================================
    """
    OUTPUT['STR'] += row_template
    OUTPUT['ADD'] += row_template
    for x in row:
        x_id = x.lower().replace(' ', '_')
        x_up = x.replace(' ', '')
        tree_def.append(x_up)
        
        perkdef_template = f"""
::Legends.Perk.{x_up} <- null;
pt.push({{
    ID = "perk.{x_id}",
    Script = "scripts/skills/perks/perk_{x_id}",
    Name = ::Const.Strings.PerkName.{x_up},
    Tooltip = ::Const.Strings.PerkDescription.{x_up},
    Icon = "ui/perks/{x_id}.png",
    IconDisabled = "ui/perks/{x_id}_sw.png",
    Const = "{x_up}"
}});
        """
        OUTPUT['ADD'] += perkdef_template

        str_template = f"""
::Const.Strings.PerkName.{x_up} <- "{x}";
::Const.Strings.PerkDescription.{x_up} <- "TODO"
+ "\\n\\n" + ::blue("« Passive »")
+ "\\n" + ::green("+1") + " Fat Recovery";
        """
        OUTPUT['STR'] += str_template
        
        perk_template = f"""
this.perk_{x_id} <- this.inherit("scripts/skills/skill", {{
	m = {{
		BUFF = 1
	}},
	function create()
	{{
		this.m.ID = "perk.{x_id}";
		this.m.Name = ::Const.Strings.PerkName.{x_up};
		this.m.Description = ::Const.Strings.PerkDescription.{x_up};
		this.m.Icon = "ui/perks/{x_id}.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{{
		
		_properties.DamageRegularMin += this.m.BUFF;
		_properties.DamageRegularMax += this.m.BUFF;
	}}
 
	function onUpdate( _properties )
	{{
		_properties.DamageTotalMult *= 2.0;
	}}
 
	function onAdded()
	{{
		if (!this.m.Container.hasActive(::Legends.Active.StunStrike))
		{{
			::Legends.Actives.grant(this, ::Legends.Active.StunStrike);
		}}
	}}
 
	function onRemoved()
	{{
		::Legends.Actives.remove(this, ::Legends.Active.StunStrike);
	}}
}});"""

        OUTPUT['FILES'][f'perk_{x_id}'] = perk_template
 

OUTPUT['ADD'] += '\n::Const.Perks.addPerkDefObjects(pt);'
       
# print(perkdef_template)
with open(PATH_STR + f'{TREE_NAME}.nut', "w", encoding='utf-8') as f_out:
    f_out.write(OUTPUT['STR'])
    
with open(PATH_ADD + f'{TREE_NAME}.nut', "w", encoding='utf-8') as f_out2:
    f_out2.write(OUTPUT['ADD'])
    
for fname, output_file in OUTPUT['FILES'].items():
    if os.path.exists(PATH_PERKS + f'{fname}.nut'): continue
    with open(PATH_PERKS + f'{fname}.nut', "w", encoding='utf-8') as f_out3:
        f_out3.write(output_file)



tree_info = f"""
::Const.Perks.{TREE_NAME.capitalize()}Tree <- {{
	ID = "{TREE_NAME.capitalize()}",
	Name = "{TREE_NAME.capitalize()}",
	Descriptions = [
		"{TREE_NAME}s"
	],
	Tree = [
		[],
		[
			::Const.Perks.PerkDefs.{tree_def[0]},
		],
		[],
		[
			::Const.Perks.PerkDefs.{tree_def[1]},
		],
		[],
		[
			::Const.Perks.PerkDefs.{tree_def[2]},
		],
		[]
	]
}};
"""
with open(f'tree_info.nut', "w+", encoding='utf-8') as f_out4:
    f_out4.write(tree_info)