package lib.utils
{
	public class Math2
	{
		public function Math2()
		{
		}
		
		public static function randRange(min:Number, max:Number):Number
		{
			return Math.random() * (max - min + 1) + min;
		}
		
		public static function randColor(base:Number=0xFFFFFF):Number
		{
			return Math.random() * base;
		}
		
		public static function format(number:*, maxDecimals:int = 2, forceDecimals:Boolean = false, siStyle:Boolean = true):String
		{
			var i:int = 0;
			var inc:Number = Math.pow(10, maxDecimals);
			var str:String = String(Math.round(inc * Number(number))/inc);
			var hasSep:Boolean = str.indexOf(".") == -1, sep:int = hasSep ? str.length : str.indexOf(".");
			var ret:String = (hasSep && !forceDecimals ? "" : (siStyle ? "," : ".")) + str.substr(sep+1);
			if (forceDecimals) {
				for (var j:int = 0; j <= maxDecimals - (str.length - (hasSep ? sep-1 : sep)); j++) ret += "0";
			}
			while (i + 3 < (str.substr(0, 1) == "-" ? sep-1 : sep)) ret = (siStyle ? "." : ",") + str.substr(sep - (i += 3), 3) + ret;
			return str.substr(0, sep - i) + ret;
		}

	}
}