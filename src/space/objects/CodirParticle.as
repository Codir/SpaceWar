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
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import space.DEngine;
	import space.ImageResources;
	/**
	 * ...
	 * @author Codir
	 */
	public class CodirParticle extends CoreObject
	{
		public var life:int;
		public var speed:b2Vec2 = new b2Vec2(0,0);
		
		public function CodirParticle(pX:Number, pY:Number, r:Number, image:String,  _world:b2World,  _worldScale:int, _state:DEngine, _speed:b2Vec2, _life:int) 
		{
			super(pX, pY, r, image,  _world,  _worldScale, _state);
			
			speed = _speed;
			life = _life;
		}
		
		override public function createBody(pX:Number, pY:Number):void
		{
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.restitution=0;
			fixtureDef.density=1;
			var circleShape:b2CircleShape=new b2CircleShape(r/worldScale);
			fixtureDef.shape = circleShape;
			fixtureDef.friction = 0.1;
			fixtureDef.restitution = 0;
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.userData = this;
			body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			body.ApplyImpulse(speed, body.GetWorldCenter());
		}
		
		override public function handleBeginContact(contactObj:*):void 
		{
			if(contactObj is Ship)
			{
				trace('Ship');
			}
		}
		
		override protected function addImg(image:String, x:Number, y:Number):void
		{
			/*img = new ImageResources(image) as Sprite;
			state.screen.addChild(img);
			img.x = x;
			img.y = y;
			img.rotation = r;*/
		}
		
	}

}