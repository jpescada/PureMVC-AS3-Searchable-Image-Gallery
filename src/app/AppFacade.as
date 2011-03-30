package app
{
	import app.controller.PhotoSearchCommand;
	import app.controller.PhotoDetailCommand;
	import app.controller.StartupCommand;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class AppFacade extends Facade implements IFacade
	{
		public static const NAME:String = "AppFacade";
		public static const STARTUP:String = NAME + "_Startup";
		public static const STAGE_RESIZE:String = NAME + "_StageResize";				
		public static const PHOTO_SHOW:String = NAME + "_PhotoShow";
		public static const PHOTO_HIDE:String = NAME + "_PhotoHide";
		public static const PHOTO_SEARCH:String = NAME + "_PhotoSearch";
		public static const PHOTO_SEARCH_RESULT:String = NAME +"_PhotoSearchResult";
		public static const PHOTO_CHANGED:String = NAME + "_PhotoChanged";		
		
		
		public function AppFacade()
		{
			super();
		}
		
		public function startup( main:DisplayObject):void
		{
			sendNotification( AppFacade.STARTUP, main );
		}
		
		public static function getInstance():AppFacade
		{
			return ( instance ? instance : new AppFacade() ) as AppFacade;
		}
		
		override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			trace("@ "+ NAME +".sendNotification( "+ notificationName +", "+ body +", "+ type +" )");
			notifyObservers( new Notification( notificationName, body, type ) );
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand( AppFacade.STARTUP, StartupCommand );
			registerCommand( AppFacade.PHOTO_SEARCH, PhotoSearchCommand );
			registerCommand( AppFacade.PHOTO_SHOW, PhotoDetailCommand );
			registerCommand( AppFacade.PHOTO_HIDE, PhotoDetailCommand );
		}
	}
}