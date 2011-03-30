package app.controller
{
	import app.AppFacade;
	import app.Main;
	import app.model.PhotosProxy;
	import app.model.StageProxy;
	import app.model.StateProxy;
	import app.view.AppMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var main:Main = notification.getBody() as Main;
			
			facade.registerProxy( new StageProxy( main.stage) );
			facade.registerProxy( new StateProxy() );
			facade.registerProxy( new PhotosProxy() );
			
			facade.registerMediator( new AppMediator( main ) );
			
			facade.sendNotification( AppFacade.PHOTO_SEARCH );
		}
	}
}