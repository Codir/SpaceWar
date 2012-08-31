package  space.CScreens
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import space.ImageResources;
	import space.UI.LevelButton;
	import space.UI.ShipButton;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class levelScreen extends Sprite
	{
		private var game:Game;
		public var rocketButton1:ShipButton;
		public var rocketButton2:ShipButton;
		public var rocketButton3:ShipButton;
		private var menuButtonImg:ImageResources = new ImageResources("nextButton");
		private var startBlock:int = 16;
		
		public function levelScreen(_game:Game) 
		{
			game = _game;
			
			var bgImage:ImageResources = new ImageResources("levelScreenBg");
			bgImage.x = 325;
			bgImage.y = 210;
			addChild(bgImage);
			
			var startX:int = 100;
			var startY:int = 150;
			var stepX:int = 110;
			var stepY:int = 100;
			
			var levelData:Array = game.data.getUserLevelData();
			
			for (var i:int = 0; i < game.data.maxLevel; i++ )
			{
				
				var levelButton:LevelButton = new LevelButton(game, (i+1), "" + (i+1), false);
				addChild(levelButton);
				levelButton.x = startX + stepX * (i%5);
				levelButton.y = startY + stepY * int(i / 5);
				levelButton.setScore(levelData[i]);
				if ((startBlock>-1&&i>=startBlock)||(i > 0 && levelData[i - 1] == 0))
				{
					//TODO: tested mode
					//levelButton.blocked();
				}
			}
			
			startX = 100;
			startY = 57;
			stepX = 110;
			
			for (i = 1; i < 4; i++ )
			{
				switch(i)
				{
					case 1:
						rocketButton1 = new ShipButton("rocket", game, i, "", true); 
						addChild(rocketButton1);
						rocketButton1.x = startX + stepX * i;
						rocketButton1.y = startY;
						
						if (game.data.currentShip == 1)
						{
							rocketButton1.selected();
						}
					break;
					//case 2:rocketButton:ShipButton = new ShipButton("solarSailShip", game, i); break;
					case 2:
						rocketButton2 = new ShipButton("airship", game, i, "You must complete\n5 levels to unlock\nthis ship", true /*(levelData[4]>0)*/);
						addChild(rocketButton2);
						rocketButton2.x = startX + stepX * i;
						rocketButton2.y = startY;
						
						if (game.data.currentShip == 2)
						{
							rocketButton2.selected();
						}
					break;
					case 3:
						rocketButton3 = new ShipButton("ufo", game, i, "You must complete\n10 levels to unlock\nthis ship", true /*(levelData[9]>0)*/);
						addChild(rocketButton3);
						rocketButton3.x = startX + stepX * i;
						rocketButton3.y = startY;
						
						if (game.data.currentShip == 3)
						{
							rocketButton3.selected();
						}
					break;
					
				}
			}
			
			
			addChild(menuButtonImg);
			menuButtonImg.x = 50;
			menuButtonImg.y = 50;
			menuButtonImg.rotation = 180;
			menuButtonImg.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
			menuButtonImg.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
			menuButtonImg.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
		}
		
		private function menuMouseClickHandler(e:MouseEvent):void 
		{
			game.exitToMenu();
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