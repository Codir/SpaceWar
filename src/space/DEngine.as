package space 
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
	import space.CreateLevel;
	import space.CScreens.levelComplite;
	import space.Input;
	import space.objects.Asteroid;
	import space.objects.CodirParticle;
	import space.objects.Planet;
	import space.objects.Ship;
	import space.SoundManager;
	import space.UI.fuelfield;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class DEngine extends Sprite
	{
		public var game:Game;
		public var _angle:Number=0;

		public var soundManager:SoundManager;
		
		public var world:b2World=new b2World(new b2Vec2(0,0),true);
		public var worldScale:int=30;
		public var planetVector:Vector.<b2Body>=new Vector.<b2Body>();
		
		private var fuelBar:fuelfield= new fuelfield(100, 5, 0x00ff00);
		
		static public const GAMEWIDTH:int = 640;
		static public const GAMEHEIGHT:int = 480;
		
		public var score:int=0;
		public var completeScreen:levelComplite;
		public var shipObj:Vector.<Ship> = new Vector.<Ship>;
		public var asteroidsVector:Vector.<Asteroid> = new Vector.<Asteroid>;
		public var particleVector:Vector.<CodirParticle> = new Vector.<CodirParticle>;
		public var bullets:Vector.<Bullet> = new Vector.<Bullet>;
		
		public var ship:int = 1;
		
		public var createLevel:CreateLevel;
		public var inputObj:Input;
		public var hero:int = 0;
		
		public var bg:DeepSpace = new DeepSpace();
		public var screen:Sprite = new Sprite();
		public var UI:Sprite = new Sprite();
		public var ButtonsPanel:buttonsPanel;
		
		protected var debug:Boolean = true;
		
		public function DEngine(_game:Game) 
		{
			game = _game;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function debugDraw():void {
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			screen.addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
				
		public function init(e:Event = null):void  {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			inputObj = new Input(this);
			
			soundManager = new SoundManager(game);
			createLevel = new CreateLevel(world, worldScale, this);
			
			addChild(bg);
			addChild(screen);
			addChild(UI);
			
			//UI
			UI.addChild(fuelBar);
			fuelBar.x = 20;
			fuelBar.y = 2;

			ButtonsPanel = new buttonsPanel(game);
			UI.addChild(ButtonsPanel);
			ButtonsPanel.x = 445;
			ButtonsPanel.y = 19;
			
			addEventListener(Event.ENTER_FRAME, updateWorld);
			debugDraw();
		}
		
		protected function updateWorld(e:Event):void {
			world.Step(1/30, 10, 10);
			world.ClearForces();
			
			var planetPosition:b2Vec2;	
			var planetShape:b2CircleShape;
			var planetRadius:Number;
			var planetDistance:b2Vec2;
			var finalDistance:Number;	
			
			for (var bb:b2Body = world.GetBodyList(); bb; bb = bb.GetNext())
			{
				//Radial gravitation
				if (bb.GetType() == b2Body.b2_dynamicBody)
				{
					for (var j:int=0; j<planetVector.length; j++) {
						planetShape=planetVector[j].GetFixtureList().GetShape() as b2CircleShape;
						planetRadius=planetShape.GetRadius();
						planetPosition=planetVector[j].GetWorldCenter();
						planetDistance=new b2Vec2(0,0);
						planetDistance.Add(bb.GetWorldCenter());
						planetDistance.Subtract(planetPosition);
						finalDistance=planetDistance.Length();
						if (finalDistance<=planetRadius*3) {
							planetDistance.NegativeSelf();
							var vecSum:Number=Math.abs(planetDistance.x)+Math.abs(planetDistance.y);
							planetDistance.Multiply((1/vecSum)*planetRadius/finalDistance);
							bb.ApplyForce(planetDistance, bb.GetWorldCenter());
						}
					}
				}
				
				//Request contact handlers
				var c:b2ContactEdge = bb.GetContactList();
				while (c)
				{
					var a:b2Fixture = c.contact.GetFixtureA();
					var b:b2Fixture = c.contact.GetFixtureB();
					var a1:b2Body = a.GetBody();
					var b1:b2Body = b.GetBody();
					
					a1.GetUserData().handleBeginContact(b1.GetUserData());
					b1.GetUserData().handleBeginContact(a1.GetUserData());	
					c = c.next;
				} 
				
				//Update image from physical objects
				if (bb.GetUserData()!=null)
				{
				  var obj:* 		= bb.GetUserData();
				  if (obj.img != null)
				  {
					  obj.img.x 		= bb.GetPosition().x * worldScale;
					  obj.img.y 		= bb.GetPosition().y * worldScale;
					  obj.img.rotation 	= CMath.radToGrad(bb.GetAngle());
				  }
				  
				  if (obj is Ship)
				  {
					obj.gun.x = obj.img.x;
					obj.gun.y = obj.img.y;
				  }
				}
			}

			var pos_x:Number = shipObj[hero].body.GetWorldCenter().x * worldScale;
			var pos_y:Number = shipObj[hero].body.GetWorldCenter().y * worldScale;
			
			screen.x=GAMEWIDTH/2-pos_x;
			screen.y=GAMEHEIGHT/2-pos_y;
			
			if (debug)
			{
				world.DrawDebugData();
			}
			
			this.update();
		}
		
		protected function update():void 
		{
			
		}
		
	}

}