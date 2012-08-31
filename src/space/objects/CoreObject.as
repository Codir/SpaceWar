package space.objects 
{
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.Controllers.b2ControllerEdge;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	import space.CMath;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.ui.*;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.display.Loader;
	import mx.core.ByteArrayAsset;
	import space.DEngine;
	import space.ImageResources;
	/**
	 * ...
	 * @author Codir
	 */
	dynamic public class CoreObject 
	{
		public var r:Number;
		protected var state:DEngine;
		public var img:*;
		protected var world:b2World;
		protected var worldScale:int;
		public var body:b2Body;
		public var x:Number;
		public var y:Number;
		
		public function CoreObject(pX:Number, pY:Number, _r:Number, image:String,  _world:b2World,  _worldScale:int, _state:DEngine)
		{
			x = pX;
			y = pY;
			state = _state;
			world = _world;
			worldScale = _worldScale;
			r = _r;
			
			createBody(pX, pY);
			addImg(image, pX, pY);
		}
		
		public function createBody(pX:Number, pY:Number):void
		{
		}
		
		public function handleBeginContact(contactObj:*):void 
		{
		}
		
		protected function addImg(image:String, x:Number, y:Number):void
		{
			img = new ImageResources(image) as Sprite;
			state.screen.addChild(img);
			img.x = x;
			img.y = y;
			img.rotation = r;
		}
		
	}

}