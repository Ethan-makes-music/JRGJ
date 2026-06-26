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
		else if (spriteNum == 3)
		{
			this.loadGraphic(AssetPaths.chillGuy__png, true, 16, 16);
		}
		else if (spriteNum == 4)
		{
			this.loadGraphic(AssetPaths.fatCat__png, true, 16, 16);
		}
		else if (spriteNum == 5)
		{
			this.loadGraphic(AssetPaths.knight__png, true, 16, 16);
		}
		else if (spriteNum == 6)
		{
			this.loadGraphic(AssetPaths.goblin__png, true, 16, 16);
		}
		else if (spriteNum == 7)
		{
			this.loadGraphic(AssetPaths.andorfYellow__png, true, 16, 16);
		}
		else if (spriteNum == 8)
		{
			this.loadGraphic(AssetPaths.andorfBlue__png, true, 16, 16);
		}
		else if (spriteNum == 9)
		{
			this.loadGraphic(AssetPaths.andorfGreen__png, true, 16, 16);
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
