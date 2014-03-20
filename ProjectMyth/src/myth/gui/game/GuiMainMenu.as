package myth.gui.game 
{
	import myth.gui.background.GuiBackground;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.data.GameData;
	
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	import flash.display.Loader;
	import myth.util.MathHelper;
	
	public class GuiMainMenu extends GuiScreen
	{
		public var michealJackson1:SpriterClip;
		public var michealJackson2:SpriterClip;
		
		public var direction:int = 1;
		
		public function GuiMainMenu() 
		{
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var version:GuiText = new GuiText(screenWidth - 220, screenHeight - 15, 200, 60, "right", "center", "Version " + GameData.GAME_VERSION, 24, 0x000000, "Arial");
			addChild(version);
			
			var logo:Image = new Image(TextureList.assets.getTexture("gui_logo"));
			logo.pivotX = 250;
			logo.x = 630;
			logo.y = 40;
			addChild(logo);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiMainMenu", 25, 0x000000);
			addChild(t);

			michealJackson1 = TextureList.spriterLoader.getSpriterClip("animLion");
			michealJackson1.x = -650;
			michealJackson1.y = 770;
			michealJackson1.playbackSpeed = 1;
			michealJackson1.scaleX = 1;
			michealJackson1.scaleY = 1;
			michealJackson1.play("ren animatie");
			addChild(michealJackson1);
			Starling.juggler.add(michealJackson1);
			
			michealJackson2 = TextureList.spriterLoader.getSpriterClip("animSwine");
			michealJackson2.x = -450;
			michealJackson2.y = 770;
			michealJackson2.playbackSpeed = 1;
			michealJackson2.scaleX = 1;
			michealJackson2.scaleY = 1;
			michealJackson2.play("sprint");
			addChild(michealJackson2);
			Starling.juggler.add(michealJackson2);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 50, 450, 100, "Play", 25, 0x31407F));
			var b3:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Editor", 25, 0x000000));
			var b4:GuiButton = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 170, 450, 100, "Options", 25, 0x000000));
			var b5:GuiButton = addButton(new GuiButton(3, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 280, 450, 100, "Credits", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			background.tick();
			
			michealJackson1.x += direction * 10;
			michealJackson2.x += direction * 10;
			
			if (michealJackson1.x > 1700 && direction == 1)
			{
				direction = -direction;
				michealJackson1.scaleX = direction;
				michealJackson2.scaleX = direction;
				michealJackson2.play("Run");
			}
			if (michealJackson1.x < -550 && direction == -1)
			{
				direction = -direction;
				michealJackson1.scaleX = direction;
				michealJackson2.scaleX = direction;
				michealJackson2.play("sprint");
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelSelect());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiEditor());
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiOptions());
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiCredits());
			}
		}
		
		override public function destroy():void 
		{ 
			Starling.juggler.remove(michealJackson1);
			Starling.juggler.remove(michealJackson2);
		}
	}
}