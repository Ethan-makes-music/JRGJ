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
	var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.bg__png);

	// stuff for lake quest
	var lake:FlxSprite = new FlxSprite(822, 205, AssetPaths.lake__png);
	var lakeSign:FlxSprite = new FlxSprite(837, 307, AssetPaths.sign__png);
	var lakeRobber:Npc = new Npc(860, 307, 2);
	var lakeBag:FlxSprite = new FlxSprite(900, 323, AssetPaths.bag__png);

	// player vars
	var plr:Player;
	var savedPlrX:Float;
	var savedPlrY:Float;

	// clock and time stuff
	var clock:FlxSprite = new FlxSprite(100, 100, AssetPaths.clock__png);
	var clockHeld:Bool = false;

	var timeValue:Int = 0; // 24 hour clock
	var time:FlxText = new FlxText(0, 0, FlxG.width, "Time: 0:00", 32);
	var timer:FlxTimer;

	var skipTimeAmnt:Int = 0;
	var chooseTimeSkip:FlxText = new FlxText(85, 359, FlxG.width, "How far to go back: ", 32);
	var inChooseTimeState:Bool = false;

	// Random stuff
	var dialouge:Dialogue;

	var testNPC:Npc = new Npc(300, 300, 1);

	override public function create()
	{
		super.create();

		FlxG.worldBounds.set(0, 0, 2560, 1440);

		bg.scrollFactor.set(0, 0);
		add(bg);

		add(clock);

		add(time);

		add(testNPC);

		lake.solid = true;
		lake.immovable = true;
		lake.scale.x = 2;
		lake.scale.y = 2;
		lake.updateHitbox();
		add(lake);
		lakeSign.solid = true;
		lakeSign.immovable = true;
		lakeSign.scale.x = 2;
		lakeSign.scale.y = 2;
		lakeSign.updateHitbox();
		add(lakeSign);
		add(lakeRobber);
		add(lakeBag);

		FlxG.camera.follow(plr);
		plr = new Player(0, 0);
		add(plr);

		dialouge = new Dialogue();
		dialouge.box.scrollFactor.set(0, 0);
		dialouge.text.scrollFactor.set(0, 0);

		timer = new FlxTimer();
		timer.start(30, onTimer);

		chooseTimeSkip.scrollFactor.set(0, 0);
		chooseTimeSkip.color = FlxColor.WHITE;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.camera.follow(plr);

		FlxG.collide(plr, lake);
		FlxG.collide(plr, lakeSign);

		// time stuff
		if (timeValue < 0)
		{
			timeValue = 0;
		}
		else if (timeValue > 24)
		{
			timeValue = 0;
		}

		time.scrollFactor.set(0, 0);
		time.text = "Time: " + timeValue + ":00";

		// code for picking up and using the clock
		if (clockHeld == true)
		{
			clock.x = plr.x + 15;
			clock.y = plr.y + 14;
		}

		if (plr.overlaps(clock) && clockHeld == false)
		{
			clockHeld = true;
		}

		if (clockHeld == true && FlxG.keys.justPressed.Q)
		{
			timeValue = timeValue - 1;
			plr.x = savedPlrX;
			plr.y = savedPlrY;
			// clock.kill();
		}

		if (FlxG.keys.justPressed.Y) // temp for testing
		{
			inChooseTimeState = true;
			plr.movable = false;
		}

		if (inChooseTimeState == true)
		{
			chooseTimeSkip.text = "< How far to go back: " + skipTimeAmnt + " >";
			add(chooseTimeSkip);

			if (FlxG.keys.justPressed.LEFT)
			{
				skipTimeAmnt = skipTimeAmnt - 1;
			}
			else if (FlxG.keys.justPressed.RIGHT)
			{
				skipTimeAmnt = skipTimeAmnt + 1;
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				timeValue = timeValue - skipTimeAmnt;
				plr.x = savedPlrX;
				plr.y = savedPlrY;
				inChooseTimeState = false;
				plr.movable = true;
				remove(chooseTimeSkip);
			}

			if (skipTimeAmnt < 0)
			{
				skipTimeAmnt = 0;
			}
			else if (skipTimeAmnt > 24)
			{
				skipTimeAmnt = 24;
			}
		}

		if (plr.overlaps(testNPC) && FlxG.keys.justPressed.E)
		{
			add(dialouge);
			dialouge.startDialogue(DialogueData.text1);
		}

		if (timeValue == 2)
		{
			// s
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
