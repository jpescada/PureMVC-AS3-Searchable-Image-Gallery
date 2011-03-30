package lib.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class DisplayObj
	{
		public function DisplayObj()
		{
		}
		
		public static function removeAllChildren(holder:DisplayObjectContainer):void
		{
			var i:int = holder.numChildren;
			while( i -- ) holder.removeChildAt( i );
		}
		
		/**
		 * duplicateDisplayObject
		 * creates a duplicate of the DisplayObject passed.
		 * similar to duplicateMovieClip in AVM1
		 * @param source the display object to duplicate
		 * @param autoAdd if true, adds the duplicate to the display list
		 * in which source was located
		 * @return a duplicate instance of source
		 */
		public static function duplicate(source:DisplayObject, autoAdd:Boolean=false):DisplayObject
		{
			// create duplicate
			var sourceClass:Class = Object(source).constructor;
			var duplicate:DisplayObject = new sourceClass();
			
			// duplicate properties
			duplicate.transform = source.transform;
			duplicate.filters = source.filters;
			duplicate.cacheAsBitmap = source.cacheAsBitmap;
			duplicate.opaqueBackground = source.opaqueBackground;
			if (source.scale9Grid)
			{
				var rect:Rectangle = source.scale9Grid;
				// WAS Flash 9 bug where returned scale9Grid is 20x larger than assigned
				// rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
				duplicate.scale9Grid = rect;
			}
			
			// add to source parent's display list
			// if autoAdd was provided as true
			if (autoAdd && source.parent)
			{
				source.parent.addChild( duplicate );
			}
			
			return duplicate;
		}
	}
}