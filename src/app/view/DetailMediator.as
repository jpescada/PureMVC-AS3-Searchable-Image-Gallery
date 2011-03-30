package app.view
{
	import app.AppFacade;
	import app.model.StageProxy;
	import app.model.vo.Photo;
	import app.view.components.Detail;
	
	import lib.events.UIEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class DetailMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DetailMediator";
		
		public function DetailMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			_init();
		}
		
		public function get detail():Detail
		{
			return viewComponent as Detail;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.PHOTO_CHANGED,
				AppFacade.STAGE_RESIZE
			];				
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case AppFacade.PHOTO_CHANGED:
					var photo:Photo = notification.getBody() as Photo;
					if (photo) detail.show( photo );
					else detail.hide();
					break;
				
				case AppFacade.STAGE_RESIZE:
					var stage:StageProxy = notification.getBody() as StageProxy;
					detail.updateSize( stage.stageWidth, stage.stageHeight );
					break;
				
				default:
					trace("@ "+ NAME +".handleNotification() | Unhandled:", notification.getName(), notification.getBody());
					break;
			}
		}
		
		private function _init():void
		{
			detail.addEventListener( Detail.HIDE, _handleDetailHide );
		}
		
		private function _handleDetailHide(evt:UIEvent):void
		{
			sendNotification( AppFacade.PHOTO_HIDE );
		}	
	}
}