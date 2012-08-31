package space 
{
	/**
	 * ...
	 * @author Codir
	 */
	public class MusicManager 
	{
		private var sound:SoundResources;
		private var game:Game;
		private var _name:String;
		
		public function MusicManager(_game:Game) 
		{
			game = _game;
		}
		
		public function play(name:String, volume:Number=0.3, loop:Boolean=false):void
		{
			//if (game.data.soundOn && game.data.musicOn && _name != name)
			if (game.data.musicOn&&_name!=name)
			{
				if (sound)
				{
					sound.stop();
					sound = null;
				}
				_name = name;
				sound = new SoundResources(name, volume, loop);
			}
		}
		
		public function stop():void
		{
			_name = "";
			sound.stop();
		}
		
		public function stopAll(deleteAll:Boolean=false):void
		{
			sound.stop();
		}
		
		public function resumeAll():void
		{
			if(sound)
			sound.play();
		}
		
	}

}