package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var gameTitle:FlxText = new FlxText(0, 0, FlxG.width, "Game title", 32);

	var pressEnterToStart:FlxText = new FlxText(0, 96, FlxG.width, "Press Enter To Start", 24);

	override function create()
	{
		super.create();

		gameTitle.setFormat(AssetPaths.byteBounce__ttf, 32, FlxColor.WHITE, FlxTextAlign.CENTER);
		add(gameTitle);

		pressEnterToStart.setFormat(AssetPaths.byteBounce__ttf, 24, FlxColor.WHITE, FlxTextAlign.CENTER);
		add(pressEnterToStart);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new PlayState(1));
		}
	}
}
