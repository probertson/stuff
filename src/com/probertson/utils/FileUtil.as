package com.probertson.utils
{
	import flash.filesystem.File;

	public class FileUtil
	{
		private var _stringUtil:StringUtil;
		
		public function sortFilesByNameAlphaNumeric(file1:File, file2:File):Number
		{
			if (file1 == null)
				return -1;
			if (file2 == null)
				return 1;
			if (_stringUtil == null)
				_stringUtil = new StringUtil();
			
			return _stringUtil.sortAlphaNumeric(file1.name, file2.name);
		}
		
		/**
		 * Given a file path, this method creates a reference to a file path 
		 * that is unique -- that is, a path to a file that does not exist --
		 * within the same directory as the provided file.
		 * 
		 * <p>If the provided file path points to a non-existent file, that
		 * file path is returned. Otherwise, a new file path is generated consisting
		 * of the following parts:</p>
		 * 
		 * <ol>
		 *   <li>original_file_name</li>
		 *   <li>{separator} - specified in the <code>separatorText</code> parameter</li>
		 *   <li>{number} - a number that's incremented (starting with 1) until a unique 
		 *       filename is found</li>
		 *   <li>".___" (a period and the original extension from the file)</li>
		 * </ol>
		 */
		public function getFileWithUniqueName(targetFile:File, preSeparatorText:String="_", postSeparatorText:String=""):File
		{
			var result:File = targetFile;
			
			var name:String = result.name;
			var extension:String;
			var dot:String;
			var fileNameMinusExtension:String;
			if (result.extension != null)
			{
				extension = result.extension;
				dot = ".";
				fileNameMinusExtension = name.substr(0, name.length - (result.extension.length + 1));
			}
			else
			{
				extension = dot = "";
				fileNameMinusExtension = name;
			}
			
			var number:int = 0;
			while (result.exists)
			{
				number += 1;
				result = result.parent.resolvePath(fileNameMinusExtension + preSeparatorText + number.toString() + postSeparatorText + dot + extension);
			}
			
			return result;
		}
	}
}