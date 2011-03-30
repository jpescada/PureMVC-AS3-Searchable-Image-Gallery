package lib.events
{
	// Custom event with bubbling by default for UI components
	public class UIEvent extends CustomEvent
	{
		public function UIEvent(type:String, note:Object=null, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, note, bubbles, cancelable);
		}
	}
}