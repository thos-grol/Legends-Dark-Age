::mods_hookExactClass("entity/world/attached_location/harbor_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("fisherman_background");

		if (_gender)
		{
			
			
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
	}

	o.getNewResources = function()
	{
		return 2;
	}

	o.onSerialize = function( _out )
	{
		_out.writeString(this.m.Sprite);
		_out.writeString(this.m.SpriteDestroyed);
		this.attached_location.onSerialize(_out);
	}

	o.onDeserialize = function( _in )
	{
		this.m.Sprite = _in.readString();
		this.m.SpriteDestroyed = _in.readString();
		this.attached_location.onDeserialize(_in);
	}

});

