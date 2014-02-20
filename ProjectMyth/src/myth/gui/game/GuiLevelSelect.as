package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;

	public class GuiLevelSelect extends GuiScreen
	{
		
		public function GuiLevelSelect() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiLevelSelect", 25, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 - 120, 450, 100, "Test Level 1", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 -  10, 450, 100, "Test Level 2", 25, 0x000000));
			var b3:GuiButton = addButton(new GuiButton(2, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelInfo("level_1"));
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiLevelInfo("level_2"));
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiMainMenu());
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}