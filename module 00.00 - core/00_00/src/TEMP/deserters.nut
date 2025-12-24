::mods_hookExactClass("scenarios/world/deserters_scenario", function (o) {
	o.create = function ()
	{
		this.m.ID = "scenario.young_blood";
		this.m.Name = "Young Blood";
		this.m.Description = "[p=c][img]gfx/ui/events/event_88.png[/img][/p][p]For too long have you been dragged from one bloody battle to another at the whim of lords sitting in high towers. Last night, you absconded from camp together with three others. You\'re dressed like soldiers still, but you\'re deserters, and the noose will be your end if you stay here for too long.\n[color=#bcad8c]Deserters:[/color] Start with three deserters and decent armor, but lower funds, you can only be joined by outlaws or combat backgrounds, and a noble house that wants to hunt you down.\n[color=#bcad8c]First to Run:[/color] Your men always are first to act in the very first round of combat.\n[color=#c90000]Like Minded:[/color] Increased chance of finding craven dastards, deserters and the disowned. [/p]";
		this.m.Difficulty = 2;
		this.m.Order = 100;
		this.m.StartingBusinessReputation = 150;
		this.setRosterReputationTiers(::Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	o.onSpawnAssets = function ()
	{
		::World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		::World.Assets.m.Money = ::World.Assets.m.Money / 2;

		::World.Assets.getStash().add(this.new("scripts/items/weapons/militia_spear"));
		::World.Assets.getStash().add(this.new("scripts/items/weapons/militia_spear"));
		::World.Assets.getStash().add(this.new("scripts/items/weapons/militia_spear"));
		::World.Assets.getStash().add(this.new("scripts/items/weapons/militia_spear"));
		::World.Assets.getStash().add(this.new("scripts/items/weapons/militia_spear"));
		
		::World.Assets.getStash().add(this.new("scripts/items/weapons/arming_sword"));
		::World.Assets.getStash().add(this.new("scripts/items/shields/wooden_shield"));


		for (local i = 0; i < 5; i++)
		{
			::World.Assets.getStash().add(
				::Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.patched_mail_shirt],
					[1, ::Legends.Armor.Standard.padded_leather],
					[1, ::Legends.Armor.Standard.basic_mail_shirt],
					[1, ::Legends.Armor.Standard.worn_mail_shirt]
				])
			);
			::World.Assets.getStash().add(
				::Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.nasal_helmet],
					[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
					[1, ::Legends.Helmet.Standard.mail_coif],
					[1, ::Legends.Helmet.Standard.rusty_mail_coif],
					[1, ::Legends.Helmet.Standard.aketon_cap],
					[1, ::Legends.Helmet.Standard.full_aketon_cap]
				])
			);
		}

		for (local i = 0; i < 5; i++)
		{
			::World.Assets.getStash().add(this.new("scripts/items/misc/potion_of_oblivion2_item"));
		}

	}

	o.onSpawnPlayer = function ()
	{
		// =========================================================================================
		// Spawn
		// =========================================================================================
		local randomVillage;

		for(local i = 0; i != ::World.EntityManager.getSettlements().len(); i = i++)
		{
			randomVillage = ::World.EntityManager.getSettlements()[i];
			if (randomVillage.isIsolatedFromRoads()) continue;
			if (randomVillage.isSouthern()) continue;
			if (randomVillage.m.Size <= 2) continue;
			break;
		}

		local randomVillageTile = randomVillage.getTile();
		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(12);
		::World.getCamera().setPos(::World.State.m.Player.getPos());

		
		// =========================================================================================
		// A - Retired Soldier
		// =========================================================================================

		local roster = ::World.getPlayerRoster();
		local bro;
		local items;
		local loc = ::Z.S.Formation.get_logical_storage_bounds()[0];

		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("Retired Soldier");
		bro.setPlaceInFormation(loc++);
		// bro.setStartValuesEx(["retired_soldier_background"]);
		bro.setStartValuesEx(["deserter_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();

		bro.getBackground().m.RawDescription = "{Prior to conscription into the army, %name% was a failed, illiterate baker. He clawed his way up and survived countless battles.\n\nUpon retiring, he found himself restless and yearned for that old life of fighting again. Now he is the leader of this mercenary group.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 1;
		bro.m.PerkPoints = 0;
		bro.m.LevelUps = 0;
		bro.m.XP = 0;
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

		// items = bro.getItems();
		// items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		// items.unequip(items.getItemAtSlot(::Const.ItemSlot.Ammo));
		

		// =========================================================================================
		// B - Lumberjack
		// =========================================================================================
		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("Lumberjack");
		bro.setPlaceInFormation(loc++);
		bro.setStartValuesEx(["lumberjack_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();

		bro.getBackground().m.RawDescription = "{A lumberjack, %fullname% was always was a quiet man that prefered the serenity of the woods to the company of people. Yet over the years, it dawned on him that he wanted to see more from the world than the same woods every day. After thinking long and hard, he made up his mind to become a mercenary.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 5;
		bro.m.PerkPoints = bro.m.Level - 1;
		
		bro.m.XP = ::Const.LevelXP[bro.m.Level - 1];
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

		// items = bro.getItems();
		// items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		// items.unequip(items.getItemAtSlot(::Const.ItemSlot.Ammo));


		// =========================================================================================
		// C - Brawler
		// =========================================================================================
		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("Brawler");
		bro.setPlaceInFormation(loc++);
		bro.setStartValuesEx(["brawler_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();

		bro.getBackground().m.RawDescription = "{%name% only ever had one real talent: using his fists to bloody the noses of other men and not going down no matter what. Although he became an undefeated prizefighter, he was hardly earning enough to get by. This is when he decided to take up mercenary work.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 5;
		bro.m.PerkPoints = bro.m.Level - 1;
		
		bro.m.XP = ::Const.LevelXP[bro.m.Level - 1];
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

		// =========================================================================================
		// D - Hunter
		// =========================================================================================
		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("Hunter");
		bro.setPlaceInFormation(loc++);
		bro.setStartValuesEx(["hunter_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();

		bro.getBackground().m.RawDescription = "{%name% hid the thought well, but for the longest time he wondered what it would be like to hunt the ultimate game: man. That is what lead him to become a mercenary.\n\nDespite his flaws, %name% is a valuable companion.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 5;
		bro.m.PerkPoints = bro.m.Level - 1;
		
		bro.m.XP = ::Const.LevelXP[bro.m.Level - 1];
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

		// =========================================================================================
		// E - You
		// =========================================================================================
		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("You");
		bro.setPlaceInFormation(loc++);
		bro.setStartValuesEx(["apprentice_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();
		::Legends.Traits.grant(bro, ::Legends.Trait.Player);

		bro.getBackground().m.RawDescription = "{%name% were rescued by this mercenary party. And to pay this debt of life and to hope for a better future, you joined them, trading service for training.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 2;
		bro.m.PerkPoints = bro.m.Level - 1;
		
		bro.m.XP = ::Const.LevelXP[bro.m.Level - 1];
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

		// items = bro.getItems();
		// items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		// items.unequip(items.getItemAtSlot(::Const.ItemSlot.Ammo));
		

		// =========================================================================================
		// D - Hunter
		// =========================================================================================
		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("Hunter");
		bro.setPlaceInFormation(loc++);
		bro.setStartValuesEx(["hunter_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();

		bro.getBackground().m.RawDescription = "{%name% hid the thought well, but for the longest time he wondered what it would be like to hunt the ultimate game: man. That is what lead him to become a mercenary.\n\nDespite his flaws, %name% is a valuable companion.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 5;
		bro.m.PerkPoints = bro.m.Level - 1;
		
		bro.m.XP = ::Const.LevelXP[bro.m.Level - 1];
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

		// =========================================================================================
		// D - Hunter
		// =========================================================================================
		bro = roster.create("scripts/entity/tactical/player");
		bro.setName("Hunter");
		bro.setPlaceInFormation(loc++);
		bro.setStartValuesEx(["hunter_background"]);
		bro.m.HireTime = this.Time.getVirtualTimeF();

		bro.getBackground().m.RawDescription = "{%name% hid the thought well, but for the longest time he wondered what it would be like to hunt the ultimate game: man. That is what lead him to become a mercenary.\n\nDespite his flaws, %name% is a valuable companion.}";
		bro.getBackground().buildDescription(true);

		bro.m.Level = 5;
		bro.m.PerkPoints = bro.m.Level - 1;
		
		bro.m.XP = ::Const.LevelXP[bro.m.Level - 1];
		// bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		
		
	// 	// =========================================================================================
	// 	// Post process bros
	// 	// =========================================================================================
	// 	local bros = roster.getAll();
	// 	for( local i = 0; i < 3; i = i++ )
	// 	{
	// 		setup_bro(bro);
	// 		i = ++i;
	// 	}

	// 	// =========================================================================================
	// 	// Other
	// 	// =========================================================================================

	// 	// ::World.Flags.set("HasLegendCampScouting", true);

	// 	this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
	// 	{
	// 		this.Music.setTrackList([
	// 			"music/retirement_02.ogg"
	// 		], ::Const.Music.CrossFadeTime);
	// 		::World.Events.fire("event.deserters_scenario_intro");
	// 	}, null);
	// }

	// o.setup_bro <- function(bro)
	// {
	// 	local items = bro.getItems();
	// 	if (::Math.rand(1, 100) <= 33 && items.getItemAtSlot(::Const.ItemSlot.Head) != null)
	// 	{
	// 		items.getItemAtSlot(::Const.ItemSlot.Head).setCondition(items.getItemAtSlot(::Const.ItemSlot.Head).getRepairMax() * 0.75);
	// 	}

	// 	if (::Math.rand(1, 100) <= 33 && items.getItemAtSlot(::Const.ItemSlot.Mainhand) != null)
	// 	{
	// 		items.getItemAtSlot(::Const.ItemSlot.Mainhand).setCondition(items.getItemAtSlot(::Const.ItemSlot.Mainhand).getRepairMax() * 0.75);
	// 	}

	// 	items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
	// 	local armor = ::Const.World.Common.pickArmor([
	// 		[
	// 			1,
	// 			"mail_hauberk",
	// 			28
	// 		],
	// 		[
	// 			1,
	// 			"mail_shirt"
	// 		],
	// 		[
	// 			1,
	// 			"gambeson"
	// 		],
	// 		[
	// 			2,
	// 			"basic_mail_shirt"
	// 		]
	// 	]);
	// 	armor.setCondition(armor.getConditionMax() * ::Math.rand(75, 100) * 0.01);
	// 	items.equip(armor);
	}

	o.onUpdateHiringRoster <- function ( _roster ) { }
	o.onGenerateBro <- function (bro) { }
	o.onGetBackgroundTooltip = function ( _background, _tooltip ) { }
});

