# automates generation of boilerplate code
PATH_STR = 'module 01.03 - perks/01_03/src/__CLASS/!STR/'
PATH_ADD = 'module 01.03 - perks/01_03/src/__CLASS/ADD/'
PATH_PERKS = 'module 01.03 - perks/scripts/skills/perks/'

TREE_NAME = 'vanguard'

OUTPUT = {
    'STR' : '',
    'ADD' : '',
    'FILES' : {
        
    }
}

# generate chunks

with open('python/generate_info_perk.cfg', "r") as f:
    temp = f.readlines()

lines = []
sublines = []

# chunk file
for line in temp:
    if line.strip() == '':
        lines.append(sublines)
        sublines = []
    else:
        sublines.append(line.strip())
lines.append(sublines)

OUTPUT['ADD'] += 'local pt = [];\n'


# build files
for i, row in enumerate(lines):
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
		//FEATURE_8: add this.m.IsPhysical = true default to skill class. Then set false for valid
		// skills
		// then add check here to disable increase
		_properties.DamageRegularMin += BUFF;
		_properties.DamageRegularMax += BUFF;
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
    with open(PATH_PERKS + f'{fname}.nut', "w", encoding='utf-8') as f_out3:
        f_out3.write(output_file)
