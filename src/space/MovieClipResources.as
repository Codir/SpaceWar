package  space
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
	public class MovieClipResources 
	{
		[Embed(source = "../assets/MovieClips/arrow.swf", mimeType = "application/octet-stream")]
		public static const arrow:Class;
		
		public var clip:MovieClip;
		public var loader:Loader=new Loader;
		
		public function MovieClipResources(name:String) 
		{
			var classVar:Class = getDefinitionByName("space::MovieClipResources_" + name) as Class;
			var swfImg:ByteArrayAsset = new classVar();
			
			loader.contentLoaderInfo.addEventListener(Event.INIT,loadCompleteListener,false,0,true);
			loader.loadBytes(swfImg);
		}
		
		private function loadCompleteListener(e:Event):void {
			trace('loadCompleteListener');
			clip = loader.content as MovieClip;
			trace(clip);
			/*addChild(clip);
			
			if (center)
			{
				clip.x= -clip.width/2;
				clip.y = -clip.height / 2;
			}*/
		}
		
	}

}