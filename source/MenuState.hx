package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.bg__png);
	var bg2:FlxBackdrop;

	var gameTitle:FlxText = new FlxText(37, 48, FlxG.width, "Continuance", 128);

	var pressEnterToStart:FlxText = new FlxText(68, 194, FlxG.width, "Press Enter To Start", 64);

	var pressEnterOption:FlxText = new FlxText(50, 255, FlxG.width, "Press Shift For Options", 64);

	override function create()
	{
		super.create();
		add(bg);
		FlxG.sound.playMusic(AssetPaths.mainMenu__ogg, 1, true);

		bg2 = new FlxBackdrop(AssetPaths.map1Decoground__png);
		bg2.velocity.set(-30, 0);
		add(bg2);

		gameTitle.setFormat(AssetPaths.byteBounce__ttf, 128, FlxColor.WHITE);
		add(gameTitle);

		pressEnterToStart.setFormat(AssetPaths.byteBounce__ttf, 64, FlxColor.WHITE);
		add(pressEnterToStart);

		pressEnterOption.setFormat(AssetPaths.byteBounce__ttf, 64, FlxColor.WHITE);
		// add(pressEnterOption);
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
