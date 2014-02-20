package myth.entity.player 
{
	import myth.graphics.TextureList;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import myth.input.TouchType;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Kit van de Bunt
	 */
	public class EntityPlayer03 extends EntityPlayerBase
	{
		public var image:Image;
		public var animationWalk:MovieClip;
		public function EntityPlayer03() 
		{
			super(false);
			
			image = new Image(TextureList.atlas_player.getTexture("player_4"));
			image.scaleX = -1;
			image.pivotX = image.width / 2;
			image.pivotY = image.height;
			art.addChild(image);
			
			//animationWalk = new MovieClip(TextureList.atlas_fish.getTextures("vis bouncing and jumping"), 30);
			//animationWalk.pivotY = 378;
			//animationWalk.pivotX = 127;
			//animationWalk.loop = true;
			//animationWalk.play();
			//Starling.juggler.add(animationWalk);
			//addChild(animationWalk);
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			
			//data vector = posX, posY, movedX, movedY
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				if (isOnFeet())
				{
					velY = -27;
					onfeet = false;
				}
			}
		}
		
	}

}