////////////////////////////////////////////////////////////
//
//   Copyright Tim Oxley 2010 
//   All rights reserved. 
//
////////////////////////////////////////////////////////////


package com.timoxley.utilities {
	import flash.utils.getQualifiedClassName;
	
	public class Utils {
		
		//==========================================================
		//
		//
		//   Statics 
		//
		//
		//==========================================================
		
		/**
		 * Returns just class name of the passed-in object (without the package name)
		 * @param object Object to get the class name from
		 * @author Tim Oxley
		 */
		public static function getClassName(object:*):String {
			var qualifiedName:String = getQualifiedClassName(object);
			return getClassNameFromQualifiedName(qualifiedName);
		}
		
		/**
		 * Takes a qualified class name String eg 'flexutils:Utils' and returns just the class name: eg 'Utils'
		 * @author Tim Oxley
		 */
		public static function getClassNameFromQualifiedName(qualifiedName:String):String {
			var parts:Array = qualifiedName.split('::');
			
			if (parts.length == 2) {
				// Handle package.path::Class
				return parts[1];
			} else if (parts.length == 1) {
				// Handle top level packages
				// String, Number etc
				return parts[0];
			} else {
				// parts.length > 2 means we have a malformed package/class name
				throw new Error("Malformed package::class name: " + qualifiedName);
			}
		}
		
		/**
		 * Takes a string name and adds a numeric suffix one larger than any existing numeric suffix.
		 * If no suffix, adds _2 to name.
		 * Note it doesn't add _1 because this is confusing:
		 * we naturally start counting from 1:
		 * <pre>
		 *
		 * Object
		 * Object_1 <- Confusing. Is this the first object? No, the other one is. hmm
		 * VS.
		 * Object
		 * Object_2 <- More clear. Ahh... it's the second object with this name.
		 * </pre>
		 *
		 * Additionally, this is the same method as other apps doing this,
		 * which I guess is argument enough.
		 *
		 * @param name String to append the numeric suffix to
		 * @return name with its incremented suffix
		 * @author Tim Oxley
		 *
		 * <pre><code>
		 * Util.incrementNameNumber("name") //  name > name_2
		 * Util.incrementNameNumber("name_1") // name_1 > name_2
		 * Util.incrementNameNumber("name_10") // name_10 > name_11
		 * Util.incrementNameNumber("name20") // name20 > name21
		 * Util.incrementNameNumber("name0") // name0 > name1
		 * <code></pre>
		 */
		public static function incrementName(name:String):String {
			var nameResult:String = name;
			var findLastDigit:RegExp = new RegExp("([\\d]+)$");
			var lastDigitsMatches:Array = name.match(findLastDigit);
			
			if (!lastDigitsMatches) {
				// No match
				nameResult = name + "_2";
			} else if (lastDigitsMatches.length == 2) {
				// Found trailing digits
				
				// Strip off trailing digits
				nameResult = name.replace(findLastDigit, "");
				
				// Convert last digit to integer so we can increment it
				var index:uint = parseInt(lastDigitsMatches[0]);
				
				// Append incremented digit to result
				nameResult = nameResult + (index + 1);
			} else {
				// Otherwise, there is something wrong with the regex
				throw new Error("The regular expression " + findLastDigit + " is incorrect. Found  " + lastDigitsMatches.length + " 'final' digits.")
			}
			return nameResult;
		}
		
		//==========================================================
		//
		//
		//   Members 
		//
		//
		//==========================================================
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		/**
		 *  Does nothing. Static methods only, no need for an instance.
		 */
		public function Utils() {
		
		}
	}
}