package  space.CScreens
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import space.ImageResources;
	import space.UI.TextLabel;
	/**
	 * ...
	 * @author Codir
	 */
	public class LeaderBoard extends Sprite
	{
		private var bg:ImageResources = new ImageResources("levelScreenBg");
		private var state:Game;
		private var menuButtonImg:ImageResources = new ImageResources("nextButton");
		
		public function LeaderBoard(_state:Game, table:Array = null) 
		{
			state = _state;
			var startX:int = 180;
			var startY:int = 100;
			var stepX:int = 0;
			var stepY:int = 50;
			
			bg.x = 325;
			bg.y = 210;
			addChild(bg);
			
			if (table)
			{
				
				var row:TextLabel = new TextLabel("Top Pilots", 0x191100, true, 28, "Arial");
				addChild(row);
				row.x = startX+70;
				row.y = startY-stepY;
				
				for (var i:int = 0; i < table.length; i++ )
				{
					row = new TextLabel(table[i].Name + "             " + table[i].Points, 0x191100, true, 28, "Arial");
					addChild(row);
					row.x = startX;
					row.y = startY + stepY * i;
				}
			}
			
			addChild(menuButtonImg);
			menuButtonImg.x = 50;
			menuButtonImg.y = 50;
			menuButtonImg.rotation = 180;
			menuButtonImg.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			menuButtonImg.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
			menuButtonImg.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
		}
		
		private function mouseClickHandler(e:MouseEvent):void 
		{
			state.hideLeaderBoard();
		}
		
		private function mouseOutHendler(e:MouseEvent):void 
		{
			Mouse.cursor = "auto";
		}
		
		private function mouseOverHendler(e:MouseEvent):void 
		{
			Mouse.cursor = "button";
		}
		
	}

}