package space.objects 
{
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.Controllers.b2ControllerEdge;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Codir
	 */
	public class Asteroid extends CoreObject
	{
		private var size:Number;
		
		public function Asteroid(pX:Number, pY:Number, rotation:Number, image:String,  _world:b2World,  _worldScale:int, _state:Main, _size:Number) 
		{
			size = _size;
			super(pX, pY, rotation, image,  _world,  _worldScale, _state);
		}
		
		override public function createBody(pX:Number, pY:Number):void
		{
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.restitution=0;
			fixtureDef.density=1;
			var circleShape:b2CircleShape=new b2CircleShape(size/worldScale);
			fixtureDef.shape = circleShape;
			fixtureDef.friction = 0.1;
			fixtureDef.restitution = 0;
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.userData = this;
			bodyDef.type = b2Body.b2_dynamicBody;
			body = world.CreateBody(bodyDef);
			state.planetVector.push(body);
			body.CreateFixture(fixtureDef);
			
			state.asteroidsVector.push(this);
		}
		
	}

}