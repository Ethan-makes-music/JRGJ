package;

import dialogue.Dialogue;
import dialogue.DialogueData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Timer;

class PlayState extends FlxState // Maybe story is like where the plr spawns somewhere not knowing where he is
{
	var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.bg__png);

	// stuff for lake quest
	var lake:FlxSprite = new FlxSprite(822, 205, AssetPaths.lake__png);
	var lakeSign:FlxSprite = new FlxSprite(837, 307, AssetPaths.sign__png);
	var lakeRobber:Npc = new Npc(860, 307, 2);
	var lakeBag:FlxSprite = new FlxSprite(900, 323, AssetPaths.bag__png);
	var lakeBagPickedUp:Bool = false;
	var lakeQuestComplete:Bool = false;
	var timesSignInteracted:Int = 0;
	var timeSinceRobberLeft:Int = 0;

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
	var chooseTimeSkip:FlxText = new FlxText(40, 359, FlxG.width, "How many hours to go back: ", 50);
	var inChooseTimeState:Bool = false;

	// Random stuff
	var dialouge:Dialogue;

	var testNPC:Npc = new Npc(300, 300, 1);

	override public function create()
	{
		super.create();
		// plr.movable = true;

		chooseTimeSkip.setFormat(AssetPaths.byteBounce__ttf, 50, FlxColor.WHITE);
		time.setFormat(AssetPaths.byteBounce__ttf, 32, FlxColor.WHITE);

		FlxG.worldBounds.set(0, 0, 2560, 1440);

		bg.scrollFactor.set(0, 0);
		add(bg);

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

		add(clock);

		dialouge = new Dialogue();
		dialouge.box.scrollFactor.set(0, 0);
		dialouge.text.scrollFactor.set(0, 0);

		timer = new FlxTimer();
		timer.start(30, onTimer);

		chooseTimeSkip.scrollFactor.set(0, 0);
		chooseTimeSkip.color = FlxColor.WHITE;

		add(dialouge);
		dialouge.startDialogue(DialogueData.introPlrText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.camera.follow(plr);

		var secondTextDialouge:Array<String> = ["I left: " + Std.string(timeSinceRobberLeft) + " hours ago"];

		FlxG.collide(plr, lake);
		// FlxG.collide(plr, lakeSign);

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
			add(dialouge);
			dialouge.startDialogue(DialogueData.pickedUpClockText);
		}

		if (FlxG.keys.justPressed.Q && clockHeld == true) // temp for testing
		{
			inChooseTimeState = true;
			plr.movable = false;
		}

		if (inChooseTimeState == true)
		{
			chooseTimeSkip.text = "How many hours to go back: " + skipTimeAmnt;
			add(chooseTimeSkip);

			if (FlxG.keys.justPressed.LEFT)
			{
				skipTimeAmnt = skipTimeAmnt - 1;
			}
			else if (FlxG.keys.justPressed.RIGHT)
			{
				skipTimeAmnt = skipTimeAmnt + 1;
			}

			if (FlxG.keys.justPressed.ENTER && skipTimeAmnt != 0)
			{
				timeValue = timeValue - skipTimeAmnt;
				plr.x = savedPlrX;
				plr.y = savedPlrY;
				inChooseTimeState = false;
				plr.movable = true;
				remove(chooseTimeSkip);
			}
			else if (FlxG.keys.justPressed.ENTER && skipTimeAmnt == 0)
			{
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

		if (timeValue >= 1)
		{
			lakeRobber.kill();
			lakeBag.kill();
			lakeSign.revive();

			if (plr.overlaps(lakeSign) && FlxG.keys.justPressed.E)
			{
				if (timesSignInteracted == 0)
				{
					add(dialouge);
					dialouge.startDialogue(DialogueData.lakeSignText);
					timesSignInteracted = 1;
				}
				else if (timesSignInteracted == 1)
				{
					add(dialouge);
					dialouge.startDialogue(secondTextDialouge);
				}
			}
		}
		else
		{
			lakeRobber.revive();
			lakeBag.revive();
			lakeSign.kill();

			if (plr.overlaps(lakeBag) && lakeBagPickedUp == false)
			{
				lakeBagPickedUp = true;
				add(dialouge);
				dialouge.startDialogue(DialogueData.lakeRobberText);
			}
		}

		if (lakeBagPickedUp == true && lakeQuestComplete == false)
		{
			lakeBag.x = plr.x;
			lakeBag.y = plr.y;
		}

		if (plr.overlaps(testNPC) && lakeBagPickedUp == true && lakeQuestComplete == false && FlxG.keys.justPressed.E)
		{
			lakeQuestComplete = true;
			lakeBag.x = testNPC.x + 15;
			lakeBag.y = testNPC.y + 14;
			add(dialouge);
			dialouge.startDialogue(DialogueData.lakeQuestText2);
			plr.movable = false;
			wait(11000, endQuest);
		}
	}

	function onTimer(tmr:FlxTimer)
	{
		timeValue++;
		savedPlrX = plr.x;
		savedPlrY = plr.y;

		if (timeValue >= 1)
		{
			timeSinceRobberLeft = timeSinceRobberLeft + 1;
		}

		tmr.start(30, onTimer);
	}

	public static function wait(milliseconds:Int, callback:Void->Void)
	{
		Timer.delay(callback, milliseconds);
	}

	function endQuest() // I have to figure out how to do multiple quests in one file unless the first quest is the only one in playstate..
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
		{
			FlxG.switchState(new MenuState());
		});
	}
}
