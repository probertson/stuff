package test.probertson.utils
{
	import com.probertson.utils.StringUtil;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertTrue;

	public class StringUtilTest
	{
		// ------- Test instance -------
		
		private var _instance:StringUtil;
		
		
		// ------- Setup/Teardown -------

		
		[Before]
		public function setUp():void
		{
			_instance = new StringUtil();
		}
		
		
		[After]
		public function tearDown():void
		{
		}
		
		
		// ------- Tests -------
		
		// ----- isNumeric -----
		
		[Test]
		public function test_isNumeric_zero():void
		{
			// 0
			Assert.assertTrue(_instance.isNumeric("0"));
		}
		
		
		[Test]
		public function test_isNumeric_positive_int():void
		{
			// positive int
			Assert.assertTrue(_instance.isNumeric("42"));
		}
		
		
		[Test]
		public function test_isNumeric_negative_int():void
		{
			// negative int
			Assert.assertTrue(_instance.isNumeric("-42"));
		}
		
		
		[Test]
		public function test_isNumeric_positive_float():void
		{
			// positive float
			Assert.assertTrue(_instance.isNumeric("27.3"));
		}
		
		
		[Test]
		public function test_isNumeric_negative_float():void
		{
			// negative float
			Assert.assertTrue(_instance.isNumeric("-15.5"));
		}
		
		
		[Test]
		public function test_isNumeric_non_numeric_String():void
		{
			// non-numeric String (should be false)
			Assert.assertFalse(_instance.isNumeric("Hello, World!"));
		}
		
		
		[Test]
		public function test_isNumeric_mixed_String_String_first():void
		{
			// mixed string/numeric (string first)
			Assert.assertFalse(_instance.isNumeric("a1"));
		}
		
		
		[Test]
		public function test_isNumeric_mixed_String_numeric_first():void
		{
			// mixed string/numeric (numeric first)
			Assert.assertFalse(_instance.isNumeric("1a"));
		}
		
		
		[Test]
		public function test_isNumeric_leading_zero():void
		{
			Assert.assertTrue(_instance.isNumeric("001"));
		}
		
		
		[Test]
		public function test_isNumeric_leading_following_zero():void
		{
			Assert.assertTrue(_instance.isNumeric("010"));
		}
		
		
		[Test]
		public function test_isNumeric_null():void
		{
			// null
			Assert.assertFalse(_instance.isNumeric(null));
		}
		
		
		// ----- sortAlphaNumeric -----
		
		[Test]
		public function test_sortAlphaNumeric_basic_String():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "abc";
			list[list.length] = "xyz";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("abc", list[0]);
			Assert.assertEquals("xyz", list[1]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_string_length():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "abcde";
			list[list.length] = "abcd";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("abcd", list[0]);
			Assert.assertEquals("abcde", list[1]);
			
			
			list = new Vector.<String>();
			list[list.length] = "abcd";
			list[list.length] = "abcde";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("abcd", list[0]);
			Assert.assertEquals("abcde", list[1]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_string_empty():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "abcde";
			list[list.length] = "";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("", list[0]);
			Assert.assertEquals("abcde", list[1]);
			
			
			list = new Vector.<String>();
			list[list.length] = "";
			list[list.length] = "abcde";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("", list[0]);
			Assert.assertEquals("abcde", list[1]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_basic_numeric():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "100";
			list[list.length] = "20";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("20", list[0]);
			Assert.assertEquals("100", list[1]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_null():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "a";
			list[list.length] = null;
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals(null, list[0]);
			Assert.assertEquals("a", list[1]);
			
			
			list = new Vector.<String>();
			list[list.length] = null;
			list[list.length] = "a";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals(null, list[0]);
			Assert.assertEquals("a", list[1]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_alpha_numeric():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "z100";
			list[list.length] = "z20";
			list[list.length] = "z2";
			list[list.length] = "z10";
			list[list.length] = "z1";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("z1", list[0]);
			Assert.assertEquals("z2", list[1]);
			Assert.assertEquals("z10", list[2]);
			Assert.assertEquals("z20", list[3]);
			Assert.assertEquals("z100", list[4]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_alpha_numeric_leading_zeros():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "z100";
			list[list.length] = "z020";
			list[list.length] = "z002";
			list[list.length] = "z010";
			list[list.length] = "z001";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("z001", list[0]);
			Assert.assertEquals("z002", list[1]);
			Assert.assertEquals("z010", list[2]);
			Assert.assertEquals("z020", list[3]);
			Assert.assertEquals("z100", list[4]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_alpha_numeric_leading_zeros_mixed_length():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "z100";
			list[list.length] = "z20";
			list[list.length] = "z02";
			list[list.length] = "z010";
			list[list.length] = "z001";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("z001", list[0]);
			Assert.assertEquals("z02", list[1]);
			Assert.assertEquals("z010", list[2]);
			Assert.assertEquals("z20", list[3]);
			Assert.assertEquals("z100", list[4]);
		}
		
		
		[Test]
		public function test_sortAlphaNumeric_alpha_numeric_mixed():void
		{
			var list:Vector.<String> = new Vector.<String>();
			list[list.length] = "20X Radonius";
			list[list.length] = "1000X Radonius Maximus";
			list[list.length] = "Callisto Morphamax 6000 SE";
			list[list.length] = "30X Radonius";
			list[list.length] = "Xiph Xlater 50";
			list[list.length] = "Alpha 2";
			list[list.length] = "Allegia 50 Clasteron";
			list[list.length] = "Xiph Xlater 300";
			list[list.length] = "Allegia 51 Clasteron";
			list[list.length] = "Callisto Morphamax 500";
			list[list.length] = "20X Radonius Prime";
			list[list.length] = "Allegia 6R Clasteron";
			list[list.length] = "Xiph Xlater 10000";
			list[list.length] = "200X Radonius";
			list[list.length] = "Callisto Morphamax 600";
			list[list.length] = "Alpha 2A";
			list[list.length] = "Allegia 500 Clasteron";
			list[list.length] = "10X Radonius";
			list[list.length] = "Alpha 200";
			list[list.length] = "Callisto Morphamax 6000 SE2";
			list[list.length] = "Xiph Xlater 500";
			list[list.length] = "Alpha 2A-900";
			list[list.length] = "Callisto Morphamax";
			list[list.length] = "Allegia 50B Clasteron";
			list[list.length] = "Xiph Xlater 40";
			list[list.length] = "Callisto Morphamax 700";
			list[list.length] = "Xiph Xlater 2000";
			list[list.length] = "Alpha 2A-8000";
			list[list.length] = "Callisto Morphamax 5000";
			list[list.length] = "Xiph Xlater 58";
			list[list.length] = "40X Radonius";
			list[list.length] = "Xiph Xlater 5";
			list[list.length] = "Callisto Morphamax 7000";
			list[list.length] = "Xiph Xlater 5000";
			list[list.length] = "Alpha 100";
			
			list = list.sort(_instance.sortAlphaNumeric);
			
			Assert.assertEquals("10X Radonius", list[0]);
			Assert.assertEquals("20X Radonius", list[1]);
			Assert.assertEquals("20X Radonius Prime", list[2]);
			Assert.assertEquals("30X Radonius", list[3]);
			Assert.assertEquals("40X Radonius", list[4]);
			Assert.assertEquals("200X Radonius", list[5]);
			Assert.assertEquals("1000X Radonius Maximus", list[6]);
			Assert.assertEquals("Allegia 6R Clasteron", list[7]);
			Assert.assertEquals("Allegia 50 Clasteron", list[8]);
			Assert.assertEquals("Allegia 50B Clasteron", list[9]);
			Assert.assertEquals("Allegia 51 Clasteron", list[10]);
			Assert.assertEquals("Allegia 500 Clasteron", list[11]);
			Assert.assertEquals("Alpha 2", list[12]);
			Assert.assertEquals("Alpha 2A", list[13]);
			Assert.assertEquals("Alpha 2A-900", list[14]);
			Assert.assertEquals("Alpha 2A-8000", list[15]);
			Assert.assertEquals("Alpha 100", list[16]);
			Assert.assertEquals("Alpha 200", list[17]);
			Assert.assertEquals("Callisto Morphamax", list[18]);
			Assert.assertEquals("Callisto Morphamax 500", list[19]);
			Assert.assertEquals("Callisto Morphamax 600", list[20]);
			Assert.assertEquals("Callisto Morphamax 700", list[21]);
			Assert.assertEquals("Callisto Morphamax 5000", list[22]);
			Assert.assertEquals("Callisto Morphamax 6000 SE", list[23]);
			Assert.assertEquals("Callisto Morphamax 6000 SE2", list[24]);
			Assert.assertEquals("Callisto Morphamax 7000", list[25]);
			Assert.assertEquals("Xiph Xlater 5", list[26]);
			Assert.assertEquals("Xiph Xlater 40", list[27]);
			Assert.assertEquals("Xiph Xlater 50", list[28]);
			Assert.assertEquals("Xiph Xlater 58", list[29]);
			Assert.assertEquals("Xiph Xlater 300", list[30]);
			Assert.assertEquals("Xiph Xlater 500", list[31]);
			Assert.assertEquals("Xiph Xlater 2000", list[32]);
			Assert.assertEquals("Xiph Xlater 5000", list[33]);
			Assert.assertEquals("Xiph Xlater 10000", list[34]);
		}
	}
}