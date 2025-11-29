::mods_hookExactClass("skills/traits/bright_trait", function (o)
{
	o.create <- function()
	{
		this.character_trait.create();
		this.m.ID = "trait.bright";
		this.m.Name = "Bright";
		this.m.Icon = "ui/traits/trait_icon_11.png";
		this.m.Description = "This character has an easier time than most with grasping new concepts and adapting to the situation.";
		this.m.Titles = [
			"the Quick",
			"the Fox",
			"Quickmind",
			"the Bright",
			"the Wise"
		];
		this.m.Excluded = [
			"trait.dumb",
			"trait.predictable",
			"trait.brute",
			"trait.teamplayer",
		];
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Intelligent")) return;

		local tier = 1;
		local roll = ::Math.rand(1, 100);
		if (roll <= 10) tier = 4; //Genius
		else if (roll <= 30) tier = 3; //Gifted
		else if (roll <= 70) tier = 2; //Above Average
		actor.getFlags().set("Intelligent", tier);
	}

	o.upgrade <- function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Intelligent", ::Math.min(5, actor.getFlags().getAsInt("Intelligent") + 1));
	}

	o.getBonus <- function()
	{
		local actor = this.getContainer().getActor();
		switch(actor.getFlags().getAsInt("Intelligent"))
		{
			case 1:
				return 3;
			case 2:
				return 5;
			case 3:
				return 7;
			case 4:
				return 10;
			case 5:
				return 20;
		}
	}

	// Tick
	o.onNewDay <- function()
	{
		local actor = this.getContainer().getActor();
		if (getBonus() >= 10 && actor.m.Level == 10 && ::Math.rand(1, 100) <= 10)
		{
			actor.updateLevel_limit_break();
			actor.resetPerks();
		}
		if (get_data() == null) return;
		// tick();
	}

	//Helper fns

	o.get_data <- function()
	{
		local actor = this.getContainer().getActor();
		local items = actor.getItems().getAllItems();

		local tome_data = null;
		foreach(i in items)
		{
			if (i.m.ID != "misc.tome") continue;
			tome_data = i.getData();
			break;
		}
		return tome_data;
	}

	o.get_current_project <- function()
	{
		local ret = {
			Project = null,
			Complete = false
		};

		local tome_data = get_data();
		if (tome_data == null) return;

		local actor = this.getContainer().getActor();
		foreach(project in tome_data.Projects)
		{
			if (actor.getFlags().has(project.Name)) continue;
			ret.Project = project;
			break;
		}

		if (ret.Project == null) //Get meditation perk
		{
			foreach(project in tome_data.Projects)
			{
				ret.Project = project;
				ret.Complete = true;
				break;
			}
		}

		return ret
	}

	o.tick <- function()
	{
		local ret = get_current_project();
		local actor = this.getContainer().getActor();

		if (ret.Complete) //when all projects are completed
		{
			//remove the current meditation
			if (actor.getFlags().get("current_meditation") == ret.Project.Reward) return; //if it's the same meditation, why change it?

			if (actor.getSkills().hasSkill(::Const.Perks.PerkDefObjects[actor.getFlags().get("current_meditation")].ID))
				actor.getSkills().removeByID(::Const.Perks.PerkDefObjects[actor.getFlags().get("current_meditation")].ID);

			if (actor.getBackground().hasPerk(actor.getFlags().get("current_meditation")))
				actor.getBackground().removePerk(actor.getFlags().get("current_meditation"));

			::Z.S.Perks_add(actor, ret.Project.Reward, 0); //add the meditation in the book
			actor.getFlags().set("current_meditation", ret.Project.Reward); //add id for future removal
		}
		else
		{
			if (::Math.rand(1, 100) <= ::Math.max(getBonus() - ret.Project.BonusDifficulty, 1))
			{
				actor.getFlags().set(ret.Project.Name, true); //Mark the project as completed

				if (ret.Project.Type == "Meditation")
				{
					//if you have a meditation already, can only learn it after book is completed
					if (actor.getFlags().has("current_meditation")) return;
					::Z.S.Perks_add(actor, ret.Project.Reward, ret.Project.Row); //add the meditation perk bought
					actor.getFlags().set("current_meditation", ret.Project.Reward); //add id for future removal
					return;
				}
				::Z.S.Perks_add(actor, ret.Project.Reward, ret.Project.Row, false); //add the perk unbought
			}
		}
	}

	////UI
	o.getName <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Intelligent")) return "Average Intelligence";
		switch(actor.getFlags().getAsInt("Intelligent"))
		{
			case 1:
				return "Average Intelligence"
			case 2:
				return "Above Average Intelligence"
			case 3:
				return "Gifted"
			case 4:
				return "Genius"
			case 5:
				return "Super-Genius"
		}
	}

	o.getTooltip <- function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants the Intelligent perk tree."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a " + getBonus() + "% chance to decipher magical knowledge each day. A tome must be in this unit's bag slot for this to trigger"
			}
		];

		if (getBonus() >= 10)
		{
			ret.push({
				id = 3,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::green("+10%") + " limit-breaking chance (each day)"
			});
		}
		ret = getTooltip_project(ret);
		return ret;
	}

	o.getTooltip_project <- function(ret)
	{
		local data = get_data();
		if (data == null) return ret;

		ret.push({
			id = 3,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::red("Decoding " + data.Name)
		});


		foreach(project in data.Projects)
		{
			ret.push({
				id = 3,
				type = "text",
				icon = ::Const.Perks.PerkDefObjects[project.Reward].Icon,
				text = project.Name
			});
		}

		local current_project = get_current_project();
		local actor = this.getContainer().getActor();

		if (current_project.Complete) //when all projects are completed
		{
			//remove the current meditation
			if (actor.getFlags().get("current_meditation") == current_project.Project.Reward)
				ret.push({
					id = 3,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Already has this meditation, nothing will occur"
				});
			ret.push({
				id = 3,
				type = "text",
				icon = ::Const.Perks.PerkDefObjects[current_project.Project.Reward].Icon,
				text = "Replacing meditation perk with: " + current_project.Project.Name
			});

		}
		else
		{
			if (current_project.Project.Type == "Meditation")
			{
				//if you have a meditation already, can only learn it after book is completed
				if (actor.getFlags().has("current_meditation"))
					ret.push({
						id = 3,
						type = "text",
						icon = ::Const.Perks.PerkDefObjects[current_project.Project.Reward].Icon,
						text = "Researching " + current_project.Project.Name + ", but will not swap meditation. Keep the tome in bag after finishing all projects to do this!"
					});
				else ret.push({
					id = 3,
					type = "text",
					icon = ::Const.Perks.PerkDefObjects[current_project.Project.Reward].Icon,
					text = "Current Project: " + current_project.Project.Name
				});
			}
			else ret.push({
				id = 3,
				type = "text",
				icon = ::Const.Perks.PerkDefObjects[current_project.Project.Reward].Icon,
				text = "Current Project: " + current_project.Project.Name
			});
		}

		return ret;
	}



});

