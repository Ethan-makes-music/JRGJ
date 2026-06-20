package dialogue;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Dialogue extends FlxGroup
{
	public var box:FlxSprite;
	public var text:FlxText;
	public var lines:Array<String>;
	public var currentLine:Int = 0;
	public var fullText:String = "";
	public var displayedText:String = "";
	public var textSpeed:Float = 0.02;
	public var timer:Float = 0;
	public var isActive:Bool = false;
	public var done:Bool = false;

	public var choices:Array<String> = null;
	public var choiceTexts:Array<FlxText> = [];
	public var selected:Int = 0;
	public var choiceMade:Bool = false;
	public var selectedChoice:String = "";
	public var onChoiceMade:String->Void = null;

	public function new()
	{
		super();

		var boxWidth:Int = 1000;
		var boxHeight:Int = 100;
		var boxX:Float = (FlxG.width - boxWidth) / 2;
		var boxY:Float = FlxG.height - boxHeight - 40;

		box = new FlxSprite(boxX, boxY);
		box.makeGraphic(boxWidth, boxHeight, FlxColor.BLACK);
		box.alpha = 0.85;
		add(box);

		text = new FlxText(boxX + 24, boxY + 20, boxWidth - 48, "");
		text.setFormat(null, 18, FlxColor.WHITE, "center");
		add(text);
	}

	public function startDialogue(dialogueLines:Array<String>, ?choiceOptions:Array<String>)
	{
		lines = dialogueLines;
		currentLine = 0;
		displayedText = "";
		fullText = lines[currentLine];
		timer = 0;
		isActive = true;
		done = false;
		visible = true;
		text.visible = true;
		box.visible = true;
		text.text = "";
		choiceMade = false;
		selectedChoice = "";
		choices = choiceOptions;

		for (option in choiceTexts)
			remove(option);
		choiceTexts = [];
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!isActive || done)
		{
			if (choices != null && !choiceMade)
			{
				updateChoices();
			}
			return;
		}

		if (displayedText.length < fullText.length)
		{
			timer += elapsed;
			if (timer >= textSpeed)
			{
				displayedText += fullText.charAt(displayedText.length);
				text.text = displayedText;
				timer = 0;
			}
		}
		else
		{
			if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
			{
				currentLine++;
				if (currentLine >= lines.length)
				{
					isActive = false;
					done = true;

					if (choices != null)
					{
						showChoices();
					}
					else
					{
						hideDialogue();
					}
				}
				else
				{
					fullText = lines[currentLine];
					displayedText = "";
					text.text = "";
				}
			}
		}
	}

	function showChoices()
	{
		if (choices == null || choices.length == 0)
			return;

		var spacing = 300;
		var y = box.y + box.height - 35;
		var startX = (FlxG.width - (choices.length * spacing)) / 2;

		for (i in 0...choices.length)
		{
			var choice = new FlxText(startX + i * spacing, y, 280, choices[i]);
			choice.setFormat(null, 18, FlxColor.WHITE, "center");
			add(choice);
			choiceTexts.push(choice);
		}

		highlightChoice();
	}

	function updateChoices()
	{
		if (FlxG.keys.justPressed.LEFT)
		{
			selected = (selected - 1 + choices.length) % choices.length;
			highlightChoice();
		}
		else if (FlxG.keys.justPressed.RIGHT)
		{
			selected = (selected + 1) % choices.length;
			highlightChoice();
		}
		else if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
		{
			choiceMade = true;
			selectedChoice = choices[selected];

			for (option in choiceTexts)
				remove(option);
			choiceTexts = [];

			hideDialogue();

			if (onChoiceMade != null)
				onChoiceMade(selectedChoice);

			trace("You selected: " + selectedChoice);
		}
	}

	function highlightChoice()
	{
		for (i in 0...choiceTexts.length)
		{
			if (i == selected)
				choiceTexts[i].color = FlxColor.GRAY;
			else
				choiceTexts[i].color = FlxColor.WHITE;
		}
	}

	function hideDialogue()
	{
		text.visible = false;
		box.visible = false;
		visible = false;
	}
}
