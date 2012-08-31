package space
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Codir
	 */
	public class SoundResources
	{
		[Embed(source = "../assets/SFX/bust.mp3")]
		public static const Bust:Class;
		
		[Embed(source = "../assets/SFX/cargo.mp3")]
		public static const Cargo:Class;
		
		[Embed(source = "../assets/SFX/coins.mp3")]
		public static const Coins:Class;
		
		[Embed(source = "../assets/SFX/crash.mp3")]
		public static const Crash:Class;
		
		[Embed(source = "../assets/SFX/frozen.mp3")]
		public static const Frozen:Class;
		
		[Embed(source = "../assets/SFX/unfrozen.mp3")]
		public static const Unfrozen:Class;
		
		[Embed(source = "../assets/SFX/vulcano.mp3")]
		public static const Vulcano:Class;
		
		[Embed(source = "../assets/SFX/collaide.mp3")]
		public static const Collaide:Class;
		
		[Embed(source = "../assets/music/game.mp3")]
		public static const GameMusic:Class;
		[Embed(source = "../assets/music/menu.mp3")]
		public static const MenuMusic:Class;
		
		public var _sound:Sound;
		public var name:String;
		public var sndChannel:SoundChannel;
		public var loop:Boolean = false;
		
		public function SoundResources(_name:String, volume:Number=0.3, loop:Boolean=false) 
		{
			name = _name;
			var classVar:Class = getDefinitionByName("space::SoundResources_" + _name) as Class;
			_sound = new classVar();
			
			play(volume, loop);
		}
		
		public function play(_volume:Number=0.3, _loop:Boolean=false):void
		{
			loop = _loop;
			var sndTransform:SoundTransform = new SoundTransform();
			var sound:Sound = _sound;
			sndChannel = sound.play();
			sndTransform.volume = _volume;
			sndChannel.soundTransform = sndTransform;
			
			if (loop)
			{
				sndChannel.addEventListener(Event.SOUND_COMPLETE,  PlayComplete);
			}
			else
			{
				sndChannel.addEventListener(Event.SOUND_COMPLETE,  PlayCompleteStop);
			}
		}
		
		private function PlayCompleteStop(e:Event):void 
		{
			name = "";
		}
		
		public function stop():void
		{
			sndChannel.stop();
		}
		
		private function PlayComplete(e:Event):void 
		{
			sndChannel.removeEventListener(Event.SOUND_COMPLETE,  PlayComplete);
			play(0.3, true);
		}
	}

}