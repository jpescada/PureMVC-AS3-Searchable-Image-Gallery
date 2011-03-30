package app.view
{
	import app.AppFacade;
	import app.model.StageProxy;
	import app.model.vo.Photo;
	import app.view.components.Gallery;
	import app.view.components.Polaroid;
	
	import lib.events.UIEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class GalleryMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "GalleryMediator";
		

		public function GalleryMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			_init();
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.PHOTO_CHANGED,
				AppFacade.PHOTO_SEARCH_RESULT,
				AppFacade.STAGE_RESIZE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case AppFacade.PHOTO_CHANGED:
					var photo:Photo = notification.getBody() as Photo;
					if (photo) gallery.detailMode = true;
					else gallery.detailMode = false;
					break;
				
				case AppFacade.PHOTO_SEARCH_RESULT:
					gallery.load( notification.getBody() as Array );
					break;
				
				case AppFacade.STAGE_RESIZE:
					var stage:StageProxy = notification.getBody() as StageProxy;
					gallery.updateSize( stage.stageWidth, stage.stageHeight );
					break;
				
				default:
					trace("@ "+ NAME +".handleNotification() | Unhandled:", notification.getName(), notification.getBody());
					break;
			}
		}
		
		public function get gallery():Gallery
		{
			return viewComponent as Gallery;
		}
		
		private function _init():void
		{
			gallery.addEventListener( Polaroid.CLICK, _handlePolaroidClick );
		}
		
		private function _handlePolaroidClick(evt:UIEvent):void
		{			
			sendNotification( AppFacade.PHOTO_SHOW, evt.note as Photo );
		}
	}
}