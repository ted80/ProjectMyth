package myth.gui.game 
{
	import myth.gui.background.GuiBackground;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.graphics.TextureList;

	public class GuiMainMenu extends GuiScreen
	{
		public function GuiMainMenu() 
		{
		}
		
		override public function init():void 
		{ 
			var bg:GuiBackground = new GuiBackground();
			addChild(bg);
			
			var t:GuiText = new GuiText(20, 20, 400, 60, "left", "top", "GuiMainMenu", 25, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 - 110, 450, 100, "Play", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2, 450, 100, "Customize", 25, 0x000000));
			var b3:GuiButton = addButton(new GuiButton(2, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 110, 450, 100, "Editor", 25, 0x000000));
			var b4:GuiButton = addButton(new GuiButton(3, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 220, 450, 100, "Options", 25, 0x000000));
			var b5:GuiButton = addButton(new GuiButton(4, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Credits", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelSelect());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiCustomize());
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiEditor());
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiOptions());
			}
			else if (b.buttonID == 4)
			{
				main.switchGui(new GuiCredits());
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}