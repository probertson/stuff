package test.probertson.utils
{
	import com.probertson.utils.FileUtil;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.flexunit.asserts.assertEquals;

	public class FileUtilTest
	{
		// ------- Instance under test -------
		
		private var _instance:FileUtil;
		
		private var _directory:File;
		
		[Before]
		public function setUp():void
		{
			_instance = new FileUtil();
			_directory = File.createTempDirectory();
		}
		
		[After]
		public function tearDown():void
		{
			_directory.deleteDirectory(true);
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function test_WithANonExistentFile_getFileWithUniqueName_returnsAReferenceToThatFile():void
		{
			var fileName:String = "testFile.txt";
			var originalFile:File = _directory.resolvePath(fileName);
			
			var testFile:File = _instance.getFileWithUniqueName(originalFile);
			
			assertEquals(fileName, testFile.name);
		}
		
		
		[Test]
		public function test_WithAnExistingFile_getFileWithUniqueName_returnsAFileWithNamePlusUnderscorePlus1PlusExtension():void
		{
			var fileName:String = "testFile";
			var extension:String = ".txt";
			var originalFile:File = _directory.resolvePath(fileName + extension);
			
			_createFile(originalFile);
			
			var testFile:File = _instance.getFileWithUniqueName(originalFile);
			
			assertEquals(fileName + "_1" + extension, testFile.name);
		}
		
		
		[Test]
		public function test_WithAnExistingFileWithoutAnExtension_getFileWithUniqueName_returnsAFileWithNamePlusUnderscorePlus1WithoutExtension():void
		{
			var fileName:String = "testFile";
			var originalFile:File = _directory.resolvePath(fileName);
			
			_createFile(originalFile);
			
			var testFile:File = _instance.getFileWithUniqueName(originalFile);
			
			assertEquals(fileName + "_1", testFile.name);
		}
		
		
		[Test]
		public function test_WithAnExistingFileAndAnExistingFileWithSuffix1_getFileWithUniqueName_returnsAFileWithSuffix2():void
		{
			var fileName:String = "testFile";
			var extension:String = ".txt";
			var originalFile:File = _directory.resolvePath(fileName + extension);
			var file1:File = _directory.resolvePath(fileName + "_1" + extension);
			
			_createFile(originalFile);
			_createFile(file1);
			
			var testFile:File = _instance.getFileWithUniqueName(originalFile);
			
			assertEquals(fileName + "_2" + extension, testFile.name);
		}
		
		
		[Test]
		public function test_WithAnExistingFileAndACustomSeparator_getFileWithUniqueName_returnsAFileWithNamePlusCustomSeparatorPlus1():void
		{
			var fileName:String = "testFile";
			var extension:String = ".txt";
			var separator:String = "_test_";
			var originalFile:File = _directory.resolvePath(fileName + extension);
			
			_createFile(originalFile);
			
			var testFile:File = _instance.getFileWithUniqueName(originalFile, separator);
			
			assertEquals(fileName + separator + "1" + extension, testFile.name);
		}
		
		
		[Test]
		public function test_WithAnExistingFileAndTwoCustomSeparators_getFileWithUniqueName_returnsAFileWithNamePlusCustomSeparatorPlus1PlusCustomSeparator():void
		{
			var fileName:String = "testFile";
			var extension:String = ".txt";
			var separator:String = "(";
			var separator2:String = ")";
			var originalFile:File = _directory.resolvePath(fileName + extension);
			
			_createFile(originalFile);
			
			var testFile:File = _instance.getFileWithUniqueName(originalFile, separator, separator2);
			
			assertEquals(fileName + separator + "1" + separator2 + extension, testFile.name);
		}
		
		
		private function _createFile(file:File):void
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.close();
		}
	}
}