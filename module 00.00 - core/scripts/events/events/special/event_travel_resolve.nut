//#0004 - travel
//This event resolves the day. It is called whenever the game expects a day to pass.
this.event_travel_resolve <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.travel.resolve";
		this.m.Title = "Another Day Passes...";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{And all will buried by the dust of history, and become part of the songs.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{...}",
					function getResult( _event )
					{
						//Increment Day
						::Z.S.increment_day();
						return 0;
					}

				}
			],
			function start( _event )
			{
				// this.Characters.push(_event.m.Deserter.getImagePath());
				// this.List.push({
				// 	id = 13,
				// 	icon = "ui/icons/kills.png",
				// 	text = _event.m.Deserter.getName() + " leaves the " + ::World.Assets.getName()
				// });
				// this.updateAchievement("Deserter", 1, 1);
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});