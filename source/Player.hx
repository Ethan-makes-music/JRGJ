package;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public function new(x:Int, y:Int)
	{
		super(x, y);
		this.loadGraphic(AssetPaths.person__png);
		this.scale.x = 2;
		this.scale.y = 2;
		this.updateHitbox();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP)
		{
			this.y = this.y - 4;
		}
		if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)
		{
			this.y = this.y + 4;
		}
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)
		{
			this.x = this.x - 4;
		}
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT)
		{
			this.x = this.x + 4;
		}
	}
}
