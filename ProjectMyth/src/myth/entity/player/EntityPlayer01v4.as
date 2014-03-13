package myth.entity.player 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import myth.graphics.TextureList;
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import starling.events.TouchPhase;
	import myth.Main;
	import myth.util.Debug;
	import myth.util.MathHelper;
	import myth.particle.slashPart;
	import pixelpaton.FindSmoothPathBetweenNodes;
	import com.cartogrammar.drawing.CubicBezier;
	import starling.textures.Texture;
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	//lion
	public class EntityPlayer01v4 extends EntityPlayerBase
	{
		[Embed(source="../../../../lib/textures/Line_1.png")]
		public static var LineTex:Class;
		private static var line_textures:Texture;
		private var lineBatch:QuadBatch = new QuadBatch();
		
		
		public var image:SpriterClip;
		public var startShootRadius:int = 100;
		public var startShootXDisplace:int = -20;
		public var startShootYDisplace:int = -90;
		private var debugShape:Shape = new Shape();
		private var line_image:Image;
		public function EntityPlayer01v4() 
		{
			//line
			//super(true, false, true,128,200,-64,-200 );
			super(false,300);
			line_textures = Texture.fromBitmap(new LineTex());
			line_image = new Image(line_textures);
			line_image.x = 640;
			line_image.y = 383;
			Main.world.attackShape.addChild(lineBatch);
			
			//player art
			image = TextureList.spriterLoader.getSpriterClip("animLion");
			image.playbackSpeed = 1;
			image.scaleX = 0.7;
			image.scaleY = 0.7;
			image.play("ren animatie");
			addChild(image);
			Starling.juggler.add(image);
			
			artLayer.addChild(image);
			artLayer.addChild(debugShape);
			artLayer.addChild(line_image);
			Debug.test(function():void { 
				//draw start attack circle
				debugShape.graphics.lineStyle(10, 0x00ff00, 0.3);
				debugShape.graphics.drawCircle(startShootXDisplace, startShootYDisplace, startShootRadius);
			}, Debug.DrawArracks);
		}
		
		private var beginX:int;
		private var beginY:int;
		private var currentId:int;
		//private var parts:Vector.<Vector.<slashPart>> = new Vector.<Vector.<slashPart>>();
		private var parts:Vector.<slashPart> = new Vector.<slashPart>();
		private var backgroundAssetData:Vector.<Vector.<int>>;
		private var i:int = 0;
		private var j:int = 0;
		private var hit:Boolean;
		private var previousPos:Point = null;
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void {
			//trace("touch");
			//data vector = posX, posY, movedX, movedY
			if (e.touches[0].phase == TouchPhase.BEGAN) {
				//trace("began");
				Debug.test(function():void { 
					//Main.world.debugShape2.graphics.lineStyle(10, 0x00ff00, 0.7);
					//Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 55);
				}, Debug.DrawArracks);
			}else if (e.touches[0].phase == TouchPhase.ENDED) {
				previousPos = null;
				Debug.test(function():void { 
					Main.world.debugShape2.graphics.clear();
				}, Debug.DrawArracks);
			}else if (e.touches[0].phase == TouchPhase.MOVED) {
				var thisPos:Point = new Point(data[0], data[1]);
				var testPoints:Vector.<Point> = new Vector.<Point>();
				if(previousPos!=null){
					var dist:Point = thisPos.subtract(previousPos);
					var distNumber:Number = dist.length;
					var checks:int = Math.floor(distNumber / 5);
					for (var k:int = 0; k < checks; k++) 
					{
						var point:Point = Point.interpolate(thisPos,previousPos,((checks-k)/checks));
						testPoints.push(point);
						Debug.test(function():void { 
							Main.world.debugShape2.graphics.lineStyle(2, 0xff00ff, 0.7);
							Main.world.debugShape2.graphics.drawCircle(point.x, point.y, 5);
						}, Debug.DrawArracks);
					}
				}else {
					testPoints[0] = new Point(data[0], data[1]);
				}
				//trace("[testpoints]: " +testPoints.length);
				Debug.test(function():void { 
					Main.world.debugShape2.graphics.lineStyle(2, 0x990000, 0.7);
					Main.world.debugShape2.graphics.drawCircle(data[0], data[1], 10);
				}, Debug.DrawArracks);
				var part:slashPart = new slashPart(data[0], data[1],12);
				parts.push(part);
				
				for (j = Main.world.entityManager.enemyList.length - 1; j > -1; j--) {
					hit = false;
					for (var l:int = 0; l < testPoints.length; l++) 
					{
						if (Main.world.entityManager.enemyList[j].collider.intersectPoint(testPoints[l])) {
							hit = true;
							break;
						}
					}
					if (hit) {
						Main.world.entityManager.removeChild(Main.world.entityManager.enemyList[j]);
						Main.world.entityManager.enemyList.splice(j , 1);
					}
				}
				previousPos = new Point(data[0], data[1]);
			}
		}
		
		override public function tick():void {
			//line.
			super.tick();
			//Main.world.attackShape.graphics.clear();
			//trace(parts.length);
			var smoothParts:Vector.<slashPart> = FindSmoothPathBetweenNodes.getArrayOfPoints(parts,false,10);
			//var smoothParts:Vector.<slashPart> = parts;
			
			//trace("s L:" + smoothParts.length);
			/////////Grapics moveTo lineTo
			/*for (i = 0; i < smoothParts.length; i++) {
				Main.world.attackShape.graphics.beginTextureFill(line_textures);
				//Main.world.attackShape.graphics.lineStyle(smoothParts[i].t, 0x0022ee, 0.7);
				//Main.world.attackShape.graphics.beginFill(0x0022ee, 0.7);
				if (i == 0) {
					Main.world.attackShape.graphics.moveTo(smoothParts[i].x, smoothParts[i].y);
				}else if (smoothParts.length - 1) {
					Main.world.attackShape.graphics.lineTo(smoothParts[i].x, smoothParts[i].y);
				}else {
					var distPreviousThis:Number = smoothParts[i].subtract(smoothParts[i - 1]).length;
					Main.world.attackShape.graphics.lineTo(smoothParts[i].x, smoothParts[i].y);
				}
			}*/
			
			lineBatch.reset();
			var rotation:Number;
			for (i = 0; i < smoothParts.length; i++) {
				//lineBatch
				//line_image = new Image(line_textures);
				//trace(smoothParts[i].x + "," + smoothParts[i].y + ","+ smoothParts[i].t);
				line_image.x = smoothParts[i].x;
				line_image.y = smoothParts[i].y;
				line_image.pivotX = line_image.width / 2;;
				line_image.pivotY = line_image.height / 2;;
				line_image.scaleX = smoothParts[i].t/10;
				line_image.scaleY = 12/ 10;
				if (i == smoothParts.length - 1) {
					line_image.rotation = rotation+Math.PI/2;
				}else {
					rotation = Vec2.weak(smoothParts[i].x, smoothParts[i].y).sub(Vec2.weak(smoothParts[i + 1].x, smoothParts[i + 1].y)).angle;
					line_image.rotation = rotation+Math.PI/2;
				}
				lineBatch.addImage(line_image);
				
			}
			
			
			for (i = 0; i < parts.length; i++) 
			{	
				//Main.world.attackShape.graphics.drawCircle(parts[i].x, parts[i].y, parts[i].t);
				parts[i].t -= 1.0;
				if (parts[i].t < 0) {
					parts.splice(i, 1);
				}
			}
			
		}
	}
}
