package;

import flixel.FlxG;
import flixel.FlxState;

class MenuState extends FlxState
{
	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.E)
		{
			FlxG.switchState(new PlayState());
		}
	}
}
