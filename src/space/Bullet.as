package space 
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
	import space.objects.CoreObject;
	import space.objects.Ship;
	/**
	 * ...
	 * @author Codir
	 */
	public class Bullet extends CoreObject
	{
		public var life:int;
		public var speed:b2Vec2;
		
		public function Bullet(position:b2Vec2, r:Number, image:String, _speed:b2Vec2, _world:b2World,  _worldScale:int, _state:DEngine, _life:int) 
		{
			speed = _speed;
			life = _life;
			
			super(position.x, position.y, r, image,  _world,  _worldScale, _state);
		}
		
		override public function createBody(pX:Number, pY:Number):void
		{
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.restitution=0;
			fixtureDef.density = 1;
			var circleShape:b2CircleShape=new b2CircleShape(r/worldScale);
			fixtureDef.shape = circleShape;
			fixtureDef.friction = 0.1;
			fixtureDef.restitution = 0;
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = this;
			body = world.CreateBody(bodyDef);
			state.bullets.push(this);
			body.CreateFixture(fixtureDef);
			
			var mass:b2MassData = new b2MassData();
			mass.mass = 1;
			mass.I = 0;
			body.SetMassData(mass);
			body.ApplyImpulse(speed, body.GetWorldCenter());
		}
		
		override public function handleBeginContact(contactObj:*):void 
		{
			if(contactObj is Ship)
			{
				trace('Ship');
				var damage:Number = Math.round(Math.abs((body.GetMass() * body.GetLinearVelocity().x + body.GetMass() * body.GetLinearVelocity().y) / 2));
				contactObj.giveDamage(damage);
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