package app.view
{
	import app.AppFacade;
	import app.model.StageProxy;
	import app.view.components.SearchBox;
	
	import flash.events.MouseEvent;
	
	import lib.events.UIEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class SearchBoxMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "SearchBoxMediator";
		
		public function SearchBoxMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			_init();
		}
		
		public function get searchBox():SearchBox
		{
			return viewComponent as SearchBox;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.PHOTO_SEARCH_RESULT,
				AppFacade.STAGE_RESIZE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case AppFacade.PHOTO_SEARCH_RESULT:
					//TODO: hide preloader?
					var list:Array = notification.getBody() as Array;
					if (list.length == 0) searchBox.showStatus();
					break;
				
				case AppFacade.STAGE_RESIZE:
					var stage:StageProxy = notification.getBody() as StageProxy;
					searchBox.updateSize( stage.stageWidth, stage.stageHeight );
					break;
				
				default:
					trace("@ "+ NAME +".handleNotification() | Unhandled:", notification.getName(), notification.getBody());
					break;
			}
		}		
		
		private function _init():void
		{
			searchBox.addEventListener( SearchBox.SUBMIT, _handleSearchRequest );
		}
		
		private function _handleSearchRequest(evt:UIEvent):void
		{
			sendNotification( AppFacade.PHOTO_SEARCH, evt.note );
		}
	}
}