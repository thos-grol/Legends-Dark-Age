::mods_hookExactClass("entity/world/settlements/legends_swamp_fort.nut", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Schwarzwacht",
				"Mooswall",
				"Pfuhlwall",
				"Moorwacht",
				"Furthwacht",
				"Stakenwall",
				"Kolkwacht",
				"Auenturm",
				"Torfwall",
				"Pfuhlwacht",
				"Krautwacht",
				"Moorwacht",
				"Birkwall",
				"Birkturm",
				"Brunnwall",
				"Kaltenwacht",
				"Furthwacht",
				"Grunenturm",
				"Suhlwacht",
				"Schwarzgard",
				"Moorgard",
				"Wehrturm",
				"Furthwehr",
				"Schanzmoor",
				"Wallpfuhl",
				"Wallfurt",
				"Auenwacht",
				"Brookwall",
				"Fennwacht",
				"Fackelwacht",
				"Bruchwacht",
				"Riedwehr",
				"Rohrwall",
				"Dusterwall"
			],
			[
				"Schwarzburg",
				"Moosburg",
				"Pfuhlburg",
				"Moorburg",
				"Furthburg",
				"Stakenburg",
				"Kolkburg",
				"Torfburg",
				"Krautburg",
				"Birkenburg",
				"Brunnburg",
				"Kaltenburg",
				"Grunburg",
				"Suhlburg",
				"Brookburg",
				"Muckenburg",
				"Egelburg",
				"Dunkelburg",
				"Nebelburg",
				"Bruchburg",
				"Morastburg",
				"Froschburg",
				"Schlammburg",
				"Brackenburg",
				"Molchburg",
				"Teichburg",
				"Fennburg",
				"Riedburg",
				"Schlickburg",
				"Senkburg",
				"Rohrburg",
				"Marschburg",
				"Schilfburg"
			],
			[
				"Schwarzburg",
				"Moosburg",
				"Pfuhlburg",
				"Moorburg",
				"Furthburg",
				"Stakenburg",
				"Kolkburg",
				"Torfburg",
				"Krautburg",
				"Birkenburg",
				"Brunnburg",
				"Kaltenburg",
				"Grunburg",
				"Suhlburg",
				"Brookburg",
				"Muckenburg",
				"Egelburg",
				"Dunkelburg",
				"Nebelburg",
				"Bruchburg",
				"Morastburg",
				"Froschburg",
				"Schlammburg",
				"Brackenburg",
				"Molchburg",
				"Teichburg",
				"Fennburg",
				"Riedburg",
				"Schlickburg",
				"Senkburg",
				"Rohrburg",
				"Marschburg",
				"Schilfburg"
			]
		];
		this.m.DraftLists = [
			[
				"cultist_background",
				"houndmaster_background",
				"daytaler_background",
				"hunter_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"wildman_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"retired_soldier_background",
				"cultist_background",
				"houndmaster_background",
				"hunter_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"wildman_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",
				"houndmaster_background",
				"beggar_background",
				"butcher_background",
				"cultist_background",
				"gravedigger_background",
				"hunter_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"monk_background",
				"flagellant_background",
				"ratcatcher_background",
				"wildman_background",
				"witchhunter_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"disowned_noble_background",
				"raider_background",
				"retired_soldier_background",
				"apprentice_background",
				"houndmaster_background",
				"butcher_background",
				"cultist_background",
				"gravedigger_background",
				"hunter_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"monk_background",
				"flagellant_background",
				"ratcatcher_background",
				"wildman_background",
				"witchhunter_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",
				"houndmaster_background",
				"beggar_background",
				"butcher_background",
				"cultist_background",
				"gravedigger_background",
				"hunter_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"monk_background",
				"flagellant_background",
				"ratcatcher_background",
				"wildman_background",
				"witchhunter_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"disowned_noble_background",
				"raider_background",
				"retired_soldier_background",
				"apprentice_background",
				"houndmaster_background",
				"butcher_background",
				"cultist_background",
				"gravedigger_background",
				"hunter_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"monk_background",
				"flagellant_background",
				"ratcatcher_background",
				"wildman_background",
				"witchhunter_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"wildwoman_background",
				"female_daytaler_background"
			],
			[
				"wildwoman_background",
				"female_beggar_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[
				"wildwoman_background",
				"female_beggar_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			]
		];
		this.m.StablesLists = [
			[
				"legend_donkey_background",
				"legend_horse_rouncey"
			],
			[
				"legend_donkey_background",
				"legend_horse_rouncey"
			],
			[
				"legend_donkey_background",
				"legend_horse_rouncey"
			]
		];

		if (this.Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push("beast_hunter_background");
			this.m.DraftLists[1].push("beast_hunter_background");
			this.m.DraftLists[2].push("beast_hunter_background");
			this.m.DraftLists[2].push("beast_hunter_background");
		}

		this.m.Rumors = this.Const.Strings.RumorsSwampSettlement;
	}

});
