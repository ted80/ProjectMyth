package myth.editor.component 
{
	import myth.gui.components.GuiText;
	import starling.display.Sprite;
	import starling.display.Image;
	import myth.editor.EditorFiles;
	import myth.editor.Editor;
	import myth.graphics.TextureList;

	public class Selector extends Sprite
	{
		public var cat_text:GuiText;
		
		public var CAT:int;
		public var ITEM:int;
		
		public static var CAT_OBJECTS:int = 0;
		public static var CAT_BACKGROUND:int = 1;
		public static var CAT_ENEMY:int = 2;
		
		public var current_items:Vector.<String>;
		public var item_art:Image;
		
		public function Selector() 
		{
			
		}
		
		public function build(t:int):void
		{
			cat_text = new GuiText(1105, 355, 200, 50, "center", "center", "CAT_CAT_CAT", 30, 0x000000, "Arial");
			addChild(cat_text);
			
			CAT = 0;
			switch_cat(0);
		}
		
		public function switch_cat(dir:int):void
		{
			CAT += dir;
			if (CAT < CAT_OBJECTS) { CAT = CAT_BACKGROUND; }
			if (CAT > CAT_BACKGROUND) { CAT = CAT_OBJECTS; }
			
			switch(CAT)
			{
				case CAT_OBJECTS: cat_text.text.text = "Objects"; current_items = EditorFiles.getObjectNames(Editor.theme); break;
				case CAT_BACKGROUND: cat_text.text.text = "Background"; current_items = EditorFiles.getBackgroundNames(Editor.theme); break;
				default: break;
			}
			
			ITEM = 0;
			switch_item(0);
		}
		
		public function switch_item(dir:int):void
		{
			ITEM += dir;
			if (ITEM < 0) { ITEM = current_items.length - 1; }
			if (ITEM > current_items.length - 1) { ITEM = 0; }
			
			if (item_art != null)
			{
				removeChild(item_art);
			}
			
			item_art = new Image(TextureList.assets.getTexture(current_items[ITEM]));
			addChild(item_art);
			
			if (item_art.width > item_art.height)
			{
				item_art.width = 200;
				item_art.scaleY = item_art.scaleX;
			}
			else
			{
				item_art.height = 200;
				item_art.scaleX = item_art.scaleY;
			}
			
			item_art.pivotX = item_art.width;
			item_art.pivotY = item_art.height;
			item_art.x = 1105;
			item_art.y = 570;
		}
	}
}