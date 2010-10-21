package com.probertson.utils
{
	public class StringUtil
	{
		// ------- Public methods -------
		
		public function isNumeric(str:String):Boolean
		{
			if (str == null)
				return false;
			
			var n:Number = parseFloat(str);
			while (str.charAt(0) == "0" && str.length > 1)
			{
				str = str.substr(1);
			}
			
			return (n.toString() == str);
		}
		
		
		public function sortAlphaNumeric(str1:String, str2:String):Number
		{
			if (str1 == null)
				return -1;
			if (str2 == null)
				return 1;
			
			var i1:int = 0, i2:int = 0;
			var segment1:String, segment2:String;
			while ((segment1 = _nextSegment(str1, i1)) != null && (segment2 = _nextSegment(str2, i2)) != null)
			{
				if (isNumeric(segment1) && isNumeric(segment2))
				{
					var n1:Number = parseFloat(segment1);
					var n2:Number = parseFloat(segment2);
					if (n1 < n2)
						return -1;
					else if (n1 > n2)
						return 1;
				}
				else
				{
					if (segment1 < segment2)
						return -1;
					else if (segment1 > segment2)
						return 1;
				}
				
				i1 += segment1.length;
				i2 += segment2.length;
			}
			
			return 0;
		}
		
		
		// ------- Private methods -------
		
		private function _nextSegment(str:String, i:int):String
		{
			if (str == null)
				return null;
			if (str.length < i)
				return null;
			if (str.length == i)
				return "";
			
			var result:String = str.substr(i);
			var matches:Array = result.match(_WORD_OR_NUMBER);
			result = matches[0];
			return result;
		}
		private static const _WORD_OR_NUMBER:RegExp = /^([0-9.]+)|([^0-9]+)/;
	}
}