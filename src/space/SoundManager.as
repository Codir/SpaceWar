package space 
{
	/**
	 * ...
	 * @author Codir
	 */
	public class SoundManager 
	{
		private var sounds:Vector.<SoundResources> = new Vector.<SoundResources>;
		private var on:Boolean = true;
		private var game:Game;
		
		public function SoundManager(_game:Game) 
		{
			game = _game;
		}
		
		public function play(name:String, volume:Number=0.3, loop:Boolean=false):void
		{
			if (game.data.soundOn)
			{
			if(on){
				var exit:Boolean = false;
				for (var i:int = 0; i < sounds.length; i++)
				{
					if (sounds[i].name == name)
					{
						exit=true;
					}
				}
				
				if (!exit)
				{
					var sound:SoundResources = new SoundResources(name, volume, loop);
					sounds.push(sound);
				}
			}
			}
		}
		
		public function stop(name:String):void
		{
			for (var i:int = 0; i < sounds.length; i++)
			{
				if (sounds[i].name == name)
				{
					sounds[i].stop();
				}
			}
		}
		
		public function stopAll(deleteAll:Boolean=false):void
		{
			on = false;
			for (var i:int = 0; i < sounds.length; i++)
			{
					sounds[i].stop();
					
					if (deleteAll)
					{
						sounds[i] = null;
					}
			}
		}
		
		public function resumeAll():void
		{
			on = true;
			for (var i:int = 0; i < sounds.length; i++)
			{
					sounds[i].play();
			}
		}
		
	}

}