package space 
{
	import Box2D.Dynamics.b2World;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.display.Loader;
	import mx.core.ByteArrayAsset;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	import flash.events.Event;
	import flash.display.Loader;
	import space.objects.*;
	/**
	 * ...
	 * @author Codir
	 */
	public class CreateLevel 
	{
		public var instructionsImg:MovieClip;
		public var loader:Loader = new Loader;
		public var world:b2World;
		public var worldScale:int;
		public var state:DEngine;
		
		public function CreateLevel(_world:b2World,  _worldScale:int, _state:DEngine) 
		{
			world = _world;
			worldScale = _worldScale;
			state = _state;

			new Planet(400, 300, 70, 'planet', world,  worldScale, state);
			new Ship(200, 300, 0, 1, world,  worldScale, state);
			new Ship(600, 300, 0, 1, world,  worldScale, state);
		}
		
	}

}