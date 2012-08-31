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
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.events.Event;
	import flash.display.Loader;
	import mx.core.ByteArrayAsset;
	import flash.display.MovieClip;
	import space.DEngine;
	import space.CMath;
	import space.shipWeapons;
	import space.UI.fuelfield;
	import space.ImageResources;
	import space.Weapon;
	//import Box2DAS.Dynamics.ContactEvent;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class Ship extends CoreObject
	{
		private var healthBar:fuelfield= new fuelfield(100, 5, 0xff0000);
		public var inertialLess:Boolean = false;
		public var fuel:Number = 200;
		public var pushToFuel:Number = 5;
		public var maxFuel:Number;
		public var rotationSpeed:Number = 2;
		public var power:Number = 2;
		public var health:Number;
		public var maxHealth:Number = 1000;
		public var _fixture:b2Fixture;	
		public var pX:Number;
		public var pY:Number;
		public var pR:Number;
		public var gun:Sprite;
		public var weapons:shipWeapons=new shipWeapons();
		
		public function Ship(_pX:Number, _pY:Number, _pR:Number, ship:int,  _world:b2World,  _worldScale:int, _state:DEngine) 
		{
			
			pX = _pX;
			pY = _pY;
			pR = _pR;
			
			super(pX, pY, r, 'spaceship',  _world,  _worldScale, _state);
			health = maxHealth;
			maxFuel = fuel;
			
			gun = new ImageResources('gun', true);
			state.screen.addChild(gun);
			gun.x = pX;
			gun.y = pY;
			gun.rotation = pR + 90;
			gun.scaleX = 0.1;
			gun.scaleY = 0.1;
			
			weapons.turret = new Weapon(10, 2, 120, 'Bullet', state, true);
			weapons.spin = new Weapon(100, 5, 2, 'Bullet', state, false);
			
			state.UI.addChild(healthBar);
			healthBar.x = 20;
			healthBar.y = 17;
		}
		
		override public function createBody(pX:Number, pY:Number):void
		{
			var circleShape:b2CircleShape=new b2CircleShape(20/worldScale);
			
			/*var polygonShape:b2PolygonShape = new b2PolygonShape();
			
			var vertices:Array = new Array();

			vertices.push( new b2Vec2(25/ worldScale, 0 / worldScale));
			vertices.push(new b2Vec2(-15/worldScale , -25/worldScale));
			vertices.push(new b2Vec2(-15/worldScale, 25/worldScale));
			polygonShape.SetAsArray(vertices);*/
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density=1;
			fixtureDef.friction=1;
			fixtureDef.restitution=0;
			//fixtureDef.shape = polygonShape;
			fixtureDef.shape = circleShape;
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type=b2Body.b2_dynamicBody;
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.userData = this;
			body=world.CreateBody(bodyDef);
			_fixture = body.CreateFixture(fixtureDef);
			body.SetAngle(CMath.gradToRad(r));
			
			state.shipObj.push(this);
		}
		
		override public function handleBeginContact(contactObj:*):void 
		{
			if(contactObj is Planet)
			{
				trace('Planet');
			}
		}
		
		public function move():void
		{
			var target:b2Vec2 = new b2Vec2();
			target.x = power * Math.cos(body.GetAngle());
			target.y = power * Math.sin(body.GetAngle());
			body.ApplyForce(target, body.GetWorldCenter());
			//TODO: fix add bust
			//this.addBust();		
		}
		
		public function addBust():void
		{
			var new_x:Number = (body.GetPosition().x-body.GetLinearVelocity().x)*worldScale*2;
			var new_y:Number = (body.GetPosition().y-body.GetLinearVelocity().y)*worldScale*2;
			var particle:CodirParticle = new CodirParticle(new_x, new_y, 5, '', world, worldScale, state, body.GetLinearVelocity(), 10);
			state.particleVector.push(particle);
		}
		
		public function rotateLeft():void
		{
			body.SetAngle(body.GetAngle() - CMath.gradToRad(rotationSpeed));
		}
		
		public function rotateRight():void
		{
			body.SetAngle(body.GetAngle() + CMath.gradToRad(rotationSpeed));
		}
		
		public function giveDamage(damage:Number):void
		{
			health -= damage;
			healthBar.setWidth(health / maxHealth);
			/*if (damage>1)
			{
				state.soundManager.play("Collaide", 0.5);
			}
			
			if (health <= 0)
			{
				state.soundManager.play("Crash", 1,true);
				destroyTimer.start();
				state.levelComplete();
			}*/
		}
		
	}

}