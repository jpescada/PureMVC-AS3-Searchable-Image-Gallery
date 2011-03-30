package app.controller
{
	import app.AppFacade;
	import app.model.StateProxy;
	import app.model.vo.Photo;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class PhotoDetailCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var photo:Photo = notification.getBody() as Photo;
			stateProxy.currentPhoto = photo;
		}
		
		private function get stateProxy():StateProxy
		{
			return facade.retrieveProxy( StateProxy.NAME ) as StateProxy;
		}
	}
}