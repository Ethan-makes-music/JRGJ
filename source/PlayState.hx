package;

import dialogue.Dialogue;
import dialogue.DialogueData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var plr:Player;
	var savedPlrX:Float;
	var savedPlrY:Float;

	var clock:FlxSprite = new FlxSprite(100, 100, AssetPaths.clock__png);

	var timeValue:Int = 0; // 24 hour clock
	var time:FlxText = new FlxText(0, 0, FlxG.width, "Time: 0:00", 32);

	var timer:FlxTimer;
	var dialouge:Dialogue;

	var testNPC:FlxSprite = new FlxSprite(300, 300, AssetPaths.person__png);

	var clockHeld:Bool = false;

	override public function create()
	{
		super.create();

		plr = new Player(0, 0);
		add(plr);

		add(clock);

		add(time);

		testNPC.scale.x = 2;
		testNPC.scale.y = 2;
		testNPC.updateHitbox();
		add(testNPC);

		dialouge = new Dialogue();

		timer = new FlxTimer();
		timer.start(30, onTimer);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// time stuff
		if (timeValue < 0)
		{
			timeValue = 0;
		}
		else if (timeValue > 24)
		{
			timeValue = 0;
		}

		time.text = "Time: " + timeValue;

		// code for picking up and using the clock
		if (clockHeld == true)
		{
			clock.x = plr.x + 10;
			clock.y = plr.y + 12;
		}

		if (plr.overlaps(clock) && clockHeld == false)
		{
			clockHeld = true;
		}

		if (clockHeld == true && FlxG.keys.justPressed.E)
		{
			timeValue = timeValue - 1;
			plr.x = savedPlrX;
			plr.y = savedPlrY;
			// clock.kill();
		}

		if (timeValue == 2)
		{
			testNPC.color = FlxColor.RED;
			if (plr.overlaps(testNPC) && FlxG.keys.justPressed.E)
			{
				add(dialouge);
				dialouge.startDialogue(DialogueData.text1);
			}
		}
		else
		{
			testNPC.color = FlxColor.GREEN;
			if (plr.overlaps(testNPC) && FlxG.keys.justPressed.E)
			{
				add(dialouge);
				dialouge.startDialogue(DialogueData.text2);
			}
		}
	}

	function onTimer(tmr:FlxTimer)
	{
		timeValue++;
		savedPlrX = plr.x;
		savedPlrY = plr.y;
		tmr.start(30, onTimer);
	}
}
