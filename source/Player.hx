package;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public var movable:Bool = true;

	var walkTime:Float = 0;

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
		this.solid = true;

		var moving:Bool = false;

		if (movable == true)
		{
			if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP)
			{
				this.y = this.y - 4;
				moving = true;
			}
			if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)
			{
				this.y = this.y + 4;
				moving = true;
			}
			if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)
			{
				this.x = this.x - 4;
				moving = true;
			}
			if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT)
			{
				this.x = this.x + 4;
				moving = true;
			}

			if (moving)
			{
				walkTime += elapsed * 10;
				angle = Math.sin(walkTime) * 6;
			}
			else
			{
				walkTime = 0;
				angle = 0;
			}
		}
	}
}
