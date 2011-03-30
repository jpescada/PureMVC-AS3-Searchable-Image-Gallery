package app
{
	import app.AppFacade;
	import app.view.components.Detail;
	import app.view.components.Gallery;
	import app.view.components.SearchBox;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */	
	//[SWF (width="960", height="600", frameRate="24", backgroundColor="#333333")]
	public class Main extends Sprite
	{
		public var gallery:Gallery;
		public var searchBox:SearchBox;
		public var detail:Detail;
		
		public function Main()
		{
			if (stage) _init();
			else addEventListener(Event.ADDED_TO_STAGE, _init, false, 0, true );
		}
		
		private function _init(evt:Event=null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _init );
			
			AppFacade.getInstance().startup( this );
		}
	}
}