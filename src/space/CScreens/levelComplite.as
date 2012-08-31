package  space.CScreens
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import space.ImageResources;
	import space.UI.TextLabel;
	//import Playtomic.*;
	/**
	 * ...
	 * @author Codir
	 */
	public class levelComplite extends Sprite
	{
		
		private var bg:ImageResources = new ImageResources("levelCompliteBG");
		private var replayButton:ImageResources = new ImageResources("replayButton");
		private var nextButton:ImageResources = new ImageResources("nextButton");
		private var menuButtonImg:ImageResources = new ImageResources("menuButtonImg");
		
		private var worldScale:Number;
		private var game:Game;
		private var counter:int = -1;
		private var timer:Timer = new Timer(1);
		private var scores:int;
		private var t:int=0;
		private var scoreLablels:Array = new Array();
		private var totalScoreLabel:TextLabel = new TextLabel("", 0x3C2A00, true, 48, "Arial");
		private var textScoreLabel:TextLabel = new TextLabel("", 0x3C2A00, true, 30, "Arial");
		
		public function levelComplite(_game:Game, _worldScale:int, _scores:int) 
		{		
			game = _game;
			//game.musicManager.stop();
			
			
			//game.hideButtonPanel();
			
			if (_scores > 0)
			{
				game.state.soundManager.play("Coins", 0.5, true);
				textScoreLabel.label.text = "Level complete";
			}
			else
			{
				textScoreLabel.label.text = "    Game Over";
			}
			
			worldScale = _worldScale;
			
			if (_scores)
			{
				scores = _scores;
			}
			else
			{
				scores = 0;
			}
			
			
			addChild(bg);
			bg.x = 0;
			bg.y = 0;
			
			addChild(textScoreLabel);
			textScoreLabel.x = -110;
			textScoreLabel.y = -110;

		
			timer.addEventListener(TimerEvent.TIMER, update);
			timer.start();
			
			addChild(totalScoreLabel);
			totalScoreLabel.x = -70;
			totalScoreLabel.y = -60;
		}
		
		private function update(e:TimerEvent):void
		{
			if (t < scores)
			{
				t += 200;
				totalScoreLabel.label.text = t + " ";
			}
			else
			{
				var medal:ImageResources;
				if (t >= 45000)
				{
					medal=new ImageResources("medal3");
				}
				else if (t >= 30000)
				{
					medal=new ImageResources("medal2");
				}
				else if (t > 0)
				{
					medal=new ImageResources("medal1");
				}
				
				if (medal)
				{
					addChild(medal);
					medal.x = 0;
					medal.y = 50;
				}
				
				
				addChild(replayButton);
				replayButton.x = 0;
				replayButton.y = 120;
				replayButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
				replayButton.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
				replayButton.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
				
				if (scores > 0)
				{
					addChild(nextButton);
					nextButton.x = 50;
					nextButton.y = 120;
					nextButton.addEventListener(MouseEvent.CLICK, nextMouseClickHandler);
					nextButton.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
					nextButton.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
				}
				
				addChild(menuButtonImg);
				menuButtonImg.x = -50;
				menuButtonImg.y = 120;
				menuButtonImg.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
				menuButtonImg.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
				menuButtonImg.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
				
				timer.stop();
				if (scores > 0)
				{	
					game.data.setLevelData(scores);
					
					if(game.state)
					game.state.soundManager.stop("Coins");
				}
			}
		}
		
		private function menuMouseClickHandler(e:MouseEvent):void 
		{
			game.exitToLevelScreen();
		}
		
		private function nextMouseClickHandler(e:MouseEvent):void 
		{
			game.nextLevel();
		}
		
		private function getDate(c:Number):String
		{
			
			var seconds:int = c / 100;
			var miliseconds:int = c % 100;
			return seconds + ":" + miliseconds;
		}
		
		
		/*private function showCounter():void
		{
			
		}*/
		
		private function mouseClickHandler(e:MouseEvent):void 
		{
			game.restart();
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