package;

import dialogue.Dialogue;
import dialogue.DialogueData;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import haxe.Timer;

class EndState extends FlxState
{
	var dialouge:Dialogue;

	override function create()
	{
		super.create();
		FlxG.mouse.visible = false;

		dialouge = new Dialogue();
		dialouge.box.scrollFactor.set(0, 0);
		dialouge.text.scrollFactor.set(0, 0);

		add(dialouge);
		dialouge.startDialogue(DialogueData.endText);

		wait(15000, backToMenu);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public static function wait(milliseconds:Int, callback:Void->Void)
	{
		Timer.delay(callback, milliseconds);
	}

	function backToMenu()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
		{
			FlxG.switchState(new MenuState()); // switch to endState
		});
	}
}
