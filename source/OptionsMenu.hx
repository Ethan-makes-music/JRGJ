package; // THIS WHOLE THING UNUSED BECAUSE I COULDENT GET SAVE SHIT TO WORK

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsMenu extends FlxState
{
	var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.bg__png);

	var optionHeader:FlxText = new FlxText(12, 0, FlxG.width, "Options Menu", 128);
	var option1:FlxText = new FlxText(12, 107, FlxG.width, "Mute Music:", 64);
	var option1YesNO:FlxText = new FlxText(302, 107, FlxG.width, "Yes", 64);

	var selected:Int = 1;

	override function create()
	{
		super.create();
		add(bg);
		FlxG.sound.playMusic(AssetPaths.mainMenu__ogg, 1, true);

		optionHeader.setFormat(AssetPaths.byteBounce__ttf, 128, FlxColor.WHITE);
		option1.setFormat(AssetPaths.byteBounce__ttf, 64, FlxColor.WHITE);
		option1YesNO.setFormat(AssetPaths.byteBounce__ttf, 64, FlxColor.WHITE);

		if (FlxG.save.data.muteMusic == false || FlxG.save.data.muteMusic == null)
		{
			option1YesNO.text = "No";
			FlxG.save.data.muteMusic = false;
			FlxG.save.flush();
		}
		else if (FlxG.save.data.muteMusic == true)
		{
			option1YesNO.text = "Yes";
			FlxG.save.data.muteMusic = true;
			FlxG.save.flush();
		}

		add(optionHeader);
		add(option1);
		add(option1YesNO);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER && selected == 1 && option1YesNO.text == "Yes")
		{
			option1YesNO.text = "No";
		}
		else if (FlxG.keys.justPressed.ENTER && selected == 1 && option1YesNO.text == "No")
		{
			option1YesNO.text = "Yes";
		}

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			FlxG.switchState(new MenuState());

			if (option1YesNO.text == "Yes")
			{
				FlxG.save.data.muteMusic = true;
				FlxG.save.flush();
			}
			else if (option1YesNO.text == "No")
			{
				FlxG.save.data.muteMusic = false;
				FlxG.save.flush();
			}
		}

		if (selected == 1)
		{
			option1.color = FlxColor.RED;
		}

		if (FlxG.keys.justPressed.UP)
		{
			selected = selected + 1;
		}
		else if (FlxG.keys.justPressed.DOWN)
		{
			selected = selected - 1;
		}

		if (selected >= 1) // just in case I add more options if i decide to update the game after the jam
		{
			selected = 1;
		}
		else if (selected <= 1)
		{
			selected = 1;
		}
	}
}
