#0004 Proof of concept system of modular contract
# this file controls the contracts and actions of each faction
# we're using this for now...

::Const.FactionTrait.Actions[::Const.FactionTrait.NobleHouse].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.NobleHouse].extend([
	// "scripts/factions/contracts/patrol_action",
	// "scripts/factions/contracts/raze_attached_location_action",
	"scripts/factions/contracts/destroy_orc_camp_action",
	// "scripts/factions/contracts/destroy_goblin_camp_action",
	// "scripts/factions/contracts/escort_envoy_action",
	// "scripts/factions/contracts/marauding_greenskins_action",
	// "scripts/factions/contracts/raid_caravan_action",
	// "scripts/factions/contracts/big_game_hunt_action",
	// "scripts/factions/contracts/barbarian_king_action",
	// "scripts/factions/contracts/free_greenskin_prisoners_action",
	// "scripts/factions/contracts/confront_warlord_action",
	// "scripts/factions/contracts/break_siege_action",
	// "scripts/factions/contracts/find_artifact_action",
	// "scripts/factions/contracts/last_stand_action",
	"scripts/factions/contracts/root_out_undead_action",
	// "scripts/factions/contracts/decisive_battle_action",
	// "scripts/factions/contracts/privateering_action",
	// "scripts/factions/contracts/siege_fortification_action",
	// "scripts/factions/contracts/conquer_holy_site_action",
	// "scripts/factions/contracts/defend_holy_site_action",
	// "scripts/factions/contracts/intercept_raiding_parties_action",
	// "scripts/factions/actions/defend_military_action",
	// "scripts/factions/actions/move_troops_action",
	// "scripts/factions/actions/patrol_roads_action",
	// "scripts/factions/actions/send_ship_action",
	// "scripts/factions/actions/receive_ship_action",
	// "scripts/factions/actions/burn_location_action",
	// "scripts/factions/actions/rebuild_location_action",
	// "scripts/factions/actions/send_supplies_action",
	// "scripts/factions/actions/add_random_situation_action",
	// "scripts/factions/actions/send_military_army_action",
	// "scripts/factions/actions/send_military_holysite_action"
]);

::Const.FactionTrait.Actions[::Const.FactionTrait.Settlement].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Settlement].extend([
	"scripts/factions/contracts/drive_away_bandits_action",
	"scripts/factions/contracts/drive_away_barbarians_action",
	"scripts/factions/contracts/investigate_cemetery_action",
	// "scripts/factions/contracts/roaming_beasts_action", 
	// "scripts/factions/contracts/item_delivery_action",
	"scripts/factions/contracts/escort_caravan_action",
	"scripts/factions/contracts/return_item_action",
	"scripts/factions/contracts/defend_settlement_bandits_action",
	"scripts/factions/contracts/defend_settlement_greenskins_action",
	"scripts/factions/contracts/obtain_item_action",
	// "scripts/factions/contracts/restore_location_action",
	// "scripts/factions/contracts/discover_location_action",

	// "scripts/factions/contracts/hunting_webknechts_action", 
	// "scripts/factions/contracts/hunting_alps_action", 
	// "scripts/factions/contracts/hunting_unholds_action", 
	// "scripts/factions/contracts/hunting_hexen_action", 
	// "scripts/factions/contracts/hunting_schrats_action", 
	// "scripts/factions/contracts/hunting_lindwurms_action", 

	// "scripts/factions/actions/send_caravan_action", 
	// "scripts/factions/actions/send_peasants_action", 
	// "scripts/factions/actions/defend_militia_action",
	// "scripts/factions/actions/send_ship_action",
	// "scripts/factions/actions/receive_ship_action",
	// "scripts/factions/actions/burn_location_action",
	// "scripts/factions/actions/rebuild_location_action",
	// "scripts/factions/actions/add_random_situation_action" 
]);

::Const.FactionTrait.Actions[::Const.FactionTrait.OrientalCityState].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.OrientalCityState].extend([
	"scripts/factions/contracts/drive_away_nomads_action",
	// "scripts/factions/contracts/roaming_beasts_desert_action",
	// "scripts/factions/contracts/slave_uprising_action",
	// "scripts/factions/contracts/item_delivery_action",
	// "scripts/factions/contracts/escort_caravan_action",
	// "scripts/factions/contracts/hunting_serpents_action",
	// "scripts/factions/contracts/hunting_sand_golems_action",
	// "scripts/factions/contracts/conquer_holy_site_action",
	// "scripts/factions/contracts/defend_holy_site_action",
	// "scripts/factions/contracts/hold_chokepoint_action",
	// "scripts/factions/actions/defend_citystate_action",
	// "scripts/factions/actions/send_ship_action",
	// "scripts/factions/actions/receive_ship_action",
	// "scripts/factions/actions/add_random_situation_action",
	// "scripts/factions/actions/burn_location_action",
	// "scripts/factions/actions/rebuild_location_action",
	// "scripts/factions/actions/patrol_area_action",
	// "scripts/factions/actions/send_peasants_action",
	// "scripts/factions/actions/send_caravan_action",
	// "scripts/factions/actions/send_citystate_army_action",
	// "scripts/factions/actions/send_citystate_holysite_action"
]);


::Const.FactionTrait.Actions[::Const.FactionTrait.Bandit].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Orc].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Goblin].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Undead].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Zombies].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Beasts].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.Barbarians].clear();
::Const.FactionTrait.Actions[::Const.FactionTrait.OrientalBandits].clear();