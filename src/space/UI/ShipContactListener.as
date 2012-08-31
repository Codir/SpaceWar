package  space.UI
{
	import flash.events.Event;
    import Box2D.Dynamics.Contacts.b2Contact;
    import flash.events.EventDispatcher;
    import Box2D.Dynamics.b2ContactListener;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class ContactListener 
	{
		
		public static const START_CONTACT:String = "blueBallStartContact";
        public var eventDispatcher:EventDispatcher;
 
        public function ShipContactListener()
        {
            eventDispatcher = new EventDispatcher();
        }
 
        override public function BeginContact(contact:b2Contact):void
        {
			trace(contact.GetFixtureA().GetBody().GetUserData());
            if((contact.GetFixtureA().GetBody().GetUserData() == BodyType.SHIP && contact.GetFixtureB().GetBody().GetUserData() == BodyType.PLANET))
            {
                eventDispatcher.dispatchEvent(new Event(START_CONTACT));
            }
        }
		
	}

}