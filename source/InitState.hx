package;

import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	override function create()
	{
		super.create();
		FlxG.sound.playMusic(AssetPaths.mainMenu__ogg, 1, true);
		FlxG.switchState(new MenuState());
	}
}
