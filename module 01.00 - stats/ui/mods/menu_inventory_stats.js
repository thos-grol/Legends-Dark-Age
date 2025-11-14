// hk purpose
// - modify the ordering of stats shown on the screen/change stat icons
CharacterScreenStatsModule.prototype.createDIV = function (_parentDiv)
{
	this.mContainer = $('<div class="stats-module"/>');
    _parentDiv.append(this.mContainer);

	// create: stats containers & layouts
	var leftStatsColumn = $('<div class="stats-column"/>');
	this.mContainer.append(leftStatsColumn);
	
	var middleStatsColumn = $('<div class="stats-column"/>');
	this.mContainer.append(middleStatsColumn);

    // hk
    // add the modified row ordering here
    this.mLeftStatsRows = {
		Hitpoints: {
			IconPath: Path.GFX + Asset.ICON_HEALTH,
			StyleName: ProgressbarStyleIdentifier.Hitpoints,
			TooltipId: TooltipIdentifier.CharacterStats.Hitpoints,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Fatigue: {
            IconPath: Path.GFX + Asset.ICON_FATIGUE,
            StyleName: ProgressbarStyleIdentifier.Fatigue,
            TooltipId: TooltipIdentifier.CharacterStats.Fatigue,
            Row: null,
            Progressbar: null,
            Talent: null
        },
		Initiative: {
            IconPath: Path.GFX + Asset.ICON_INITIATIVE,
            StyleName: ProgressbarStyleIdentifier.Initiative,
            TooltipId: TooltipIdentifier.CharacterStats.Initiative,
            Row: null,
            Progressbar: null,
            Talent: null
        },
        Bravery: {
            IconPath: Path.GFX + Asset.ICON_BRAVERY,
            StyleName: ProgressbarStyleIdentifier.Bravery,
            TooltipId: TooltipIdentifier.CharacterStats.Bravery,
            Row: null,
            Progressbar: null,
            Talent: null
        },


		ArmorHead: {
			IconPath: Path.GFX + Asset.ICON_ARMOR_HEAD,
			StyleName: ProgressbarStyleIdentifier.ArmorHead,
			TooltipId: TooltipIdentifier.CharacterStats.ArmorHead,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		ArmorBody: {
			IconPath: Path.GFX + Asset.ICON_ARMOR_BODY,
			StyleName: ProgressbarStyleIdentifier.ArmorBody,
			TooltipId: TooltipIdentifier.CharacterStats.ArmorBody,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		ActionPoints: {
			IconPath: Path.GFX + Asset.ICON_ACTION_POINTS,
			StyleName: ProgressbarStyleIdentifier.ActionPoints,
			TooltipId: TooltipIdentifier.CharacterStats.ActionPoints,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Morale: {
			IconPath: Path.GFX + Asset.ICON_MORALE,
			StyleName: ProgressbarStyleIdentifier.Morale,
			TooltipId: TooltipIdentifier.CharacterStats.Morale,
			Row: null,
			Progressbar: null,
			Talent: null
		},
	};

	this.mMiddleStatsRows = {
        MeleeSkill: {
            IconPath: Path.GFX + Asset.ICON_MELEE_SKILL,
            StyleName: ProgressbarStyleIdentifier.MeleeSkill,
            TooltipId: TooltipIdentifier.CharacterStats.MeleeSkill,
            Row: null,
            Progressbar: null,
            Talent: null
        },
		MeleeDefense: {
			IconPath: Path.GFX + Asset.ICON_MELEE_DEFENCE,
			StyleName: ProgressbarStyleIdentifier.MeleeDefense,
			TooltipId: TooltipIdentifier.CharacterStats.MeleeDefense,
			Row: null,
			Progressbar: null,
			Talent: null
		},
        RangeSkill: {
            IconPath: Path.GFX + 'ui/icons/strength.png',
            StyleName: ProgressbarStyleIdentifier.RangeSkill,
            TooltipId: TooltipIdentifier.CharacterStats.RangeSkill,
            Row: null,
            Progressbar: null,
            Talent: null
        },
		RangeDefense: {
			IconPath: Path.GFX + 'ui/icons/reflex.png',
			StyleName: ProgressbarStyleIdentifier.RangeDefense,
			TooltipId: TooltipIdentifier.CharacterStats.RangeDefense,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		RegularDamage: {
			IconPath: Path.GFX + Asset.ICON_REGULAR_DAMAGE,
			StyleName: ProgressbarStyleIdentifier.RegularDamage,
			TooltipId: TooltipIdentifier.CharacterStats.RegularDamage,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		CrushingDamage: {
			IconPath: Path.GFX + Asset.ICON_CRUSHING_DAMAGE,
			StyleName: ProgressbarStyleIdentifier.CrushingDamage,
			TooltipId: TooltipIdentifier.CharacterStats.CrushingDamage,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		ChanceToHitHead: {
			IconPath: Path.GFX + Asset.ICON_CHANCE_TO_HIT_HEAD,
			StyleName: ProgressbarStyleIdentifier.ChanceToHitHead,
			TooltipId: TooltipIdentifier.CharacterStats.ChanceToHitHead,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		SightDistance: {
			IconPath: Path.GFX + Asset.ICON_SIGHT_DISTANCE,
			StyleName: ProgressbarStyleIdentifier.SightDistance,
			TooltipId: TooltipIdentifier.CharacterStats.SightDistance,
			Row: null,
			Progressbar: null,
			Talent: null
		}
	};
    // hk end
	
	this.createRowsDIV(this.mLeftStatsRows, leftStatsColumn);
	this.createRowsDIV(this.mMiddleStatsRows, middleStatsColumn);
};