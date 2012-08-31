package space
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import mx.core.ByteArrayAsset;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class ImageResources extends Sprite
	{
		[Embed(source="../assets/Sprites/replayButton.png")]
		public static const replayButton:Class;
		
		[Embed(source="../assets/Sprites/planet_1.png")]
		public static const planet:Class;
		
		[Embed(source = "../assets/Sprites/aimImg.png")]
		public static const aimImg:Class;
		
		[Embed(source = "../assets/Sprites/spaceship.png")]
		public static const spaceship:Class;
		
		[Embed(source="../assets/Sprites/gun.png")]
		public static const gun:Class;
		
		[Embed(source = "../assets/Sprites/bullet.png")]
		public static const bullet:Class;
		
		[Embed(source = "../assets/Sprites/bustParticle.png")]
		public static const bustParticle:Class;
		
		[Embed(source = "../assets/Sprites/nextButton.png")]
		public static const nextButton:Class;
		[Embed(source = "../assets/Sprites/menuButton.png")]
		public static const menuButtonImg:Class;
		[Embed(source = "../assets/Sprites/musicButton.png")]
		public static const musicButton:Class;
		[Embed(source = "../assets/Sprites/soundButton.png")]
		public static const soundButton:Class;
		
		[Embed(source = "../assets/Sprites/menuBg.png")]
		public static const menuBg:Class;
		
		[Embed(source = "../assets/Sprites/menuButtonBg.png")]
		public static const menuButtonBg:Class;
		
		[Embed(source = "../assets/Sprites/buttonOff.png")]
		public static const buttonOff:Class;
		[Embed(source = "../assets/Sprites/buttonsBg.png")]
		public static const buttonsBg:Class;
		[Embed(source = "../assets/Sprites/shipButtonPopup.png")]
		public static const shipButtonPopup:Class;
		
		[Embed(source = "../assets/Sprites/logo1.png")]
		public static const logo1:Class;
		
		public function ImageResources(name:String, center:Boolean=true, smoothing:Boolean=true, cache:Boolean=true) 
		{
			var classVar:Class = getDefinitionByName("space::ImageResources_" + name) as Class;
			var image:* = new classVar();
			
			addChild(image);
		
			if(smoothing)
			image.smoothing = true;
			
			if(cache)
			image.cacheAsBitmap = true;
		
			if (center)
			{
				image.x= -image.width/2;
				image.y = -image.height / 2;
			}
		}
	}

}