package myth.entity.effects 
{
	import myth.entity.SimpleEntity
	import starling.display.Sprite;
	import treefortress.spriter.SpriterClip;
	import myth.graphics.TextureList;
	import starling.core.Starling;
	public class deahtRunning extends SimpleEntity
	{
		private var image:SpriterClip;
		public function deahtRunning() 
		{
			//player art
			image = TextureList.spriterLoader.getSpriterClip("enemydeaths");
			image.playbackSpeed = 1;
			//image.scaleX = 0.7;
			//image.scaleY = 0.7;
			image.play("running_death");
			addChild(image);
			Starling.juggler.add(image);
			
			artLayer.addChild(image);
		}
		
	}

}