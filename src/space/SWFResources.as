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
	public class SWFResources extends Sprite
	{
		[Embed(source="../assets/MovieClips/arrow.swf", mimeType="application/octet-stream")]
		public static const arrow:Class;
		
		[Embed(source = "../assets/MovieClips/Rocket.swf", mimeType = "application/octet-stream")]
		public static const rocket:Class;
	
		private var state;
		private var center:Boolean=false;

		public var clip:MovieClip;
		public var loader:Loader=new Loader;
		
		public function SWFResources(_state, name:String, _center:Boolean=true, _visible:Boolean=true) 
		{
			state = _state;
			center = _center;
			visible = _visible;
			var classVar:Class = getDefinitionByName( "space::SWFResources_" + name) as Class;
			var swfImg:ByteArrayAsset = new classVar();
			
			loader.contentLoaderInfo.addEventListener(Event.INIT,loadCompleteListener,false,0,true);
			loader.loadBytes(swfImg);
		}
		
		private function loadCompleteListener(e:Event):void {
			clip = MovieClip(loader.content);
			clip.visible = visible;
			
			if (center)
			{
				clip.x= -clip.width/2;
				clip.y = -clip.height / 2;
			}
			
			state.stopLoading();
		}
		
	}

}