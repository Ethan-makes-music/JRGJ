package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.bg__png);
	var bg2:FlxBackdrop;

	var gameTitle:FlxText = new FlxText(37, 136, FlxG.width, "Continuance", 128);

	var pressEnterToStart:FlxText = new FlxText(68, 282, FlxG.width, "Press Enter To Start", 64);

	var pressEnterOption:FlxText = new FlxText(50, 255, FlxG.width, "Press Shift For Options", 64);

	var creditsShit:FlxText = new FlxText(2, 465, FlxG.width, "'C' For Credits", 16);

	var selectSound:FlxSound;

	override function create()
	{
		super.create();
		FlxG.mouse.visible = false;
		add(bg);
		FlxG.sound.playMusic(AssetPaths.mainMenu__ogg, 1, true);

		FlxG.camera.filters = null;
		FlxG.camera.filtersEnabled = false;
		selectSound = FlxG.sound.load(AssetPaths.select__ogg, 1, false);

		bg2 = new FlxBackdrop(AssetPaths.map1Decoground__png);
		bg2.velocity.set(-30, 0);
		add(bg2);

		gameTitle.setFormat(AssetPaths.byteBounce__ttf, 128, FlxColor.WHITE);
		add(gameTitle);

		creditsShit.setFormat(AssetPaths.byteBounce__ttf, 16, FlxColor.WHITE);
		// add(creditsShit);

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
			selectSound.play();
		}
	}
}
