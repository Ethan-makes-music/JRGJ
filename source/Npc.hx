package;

import flixel.FlxSprite;

class Npc extends FlxSprite
{
	public function new(x:Int, y:Int, spriteNum:Int)
	{
		super(x, y);

		if (spriteNum == 1)
		{
			this.loadGraphic(AssetPaths.oldMan__png, true, 16, 16);
		}
		else if (spriteNum == 2)
		{
			this.loadGraphic(AssetPaths.cloackPerson__png, true, 16, 16);
		}

		this.animation.add("idle", [0, 1], 2, true);

		this.scale.x = 2;
		this.scale.y = 2;
		this.updateHitbox();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		this.animation.play("idle");
	}
}
