package space 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Codir
	 */
	public class actionButton extends Sprite 
	{
		private var game:Game;
		private var bg:ImageResources;
		private var offImg:ImageResources = new ImageResources("buttonOff");
		public var on:Boolean = true;
		private var type:int;
		
		public function actionButton(name:String, _type:int, _game:Game) 
		{
			type = _type;
			game = _game;
			bg = new ImageResources(name);
			addChild(bg);
			bg.x = 0;
			bg.y = 0;
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseClickHandler);
		}
		
		private function mouseClickHandler(e:MouseEvent):void 
		{
			if (type>1&&on)
			{
				on = false;
				addChild(offImg);
				offImg.x = 0;
				offImg.y = 0;
			}
			else if(type>1)
			{
				on = true;
				removeChild(offImg);
			}
			
			switch(type)
			{
				case 0:
					game.exitToLevelScreen();
				break;
				case 1:
					game.restart();
				break;
				case 3:
					if (on)
					{
						game.state.soundManager.resumeAll();
						//game.musicManager.resumeAll();
					}
					else
					{
						game.state.soundManager.stopAll();
						//game.musicManager.stopAll();
					}
					
					game.data.soundOn = on;
				break;
				case 2:
				if (on)
					{
						game.musicManager.resumeAll();
					}
					else
					{
						game.musicManager.stopAll();
					}
					game.data.musicOn = on;
				break;
			}
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