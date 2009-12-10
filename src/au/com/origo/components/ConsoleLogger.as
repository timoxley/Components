package au.com.origo.components
{
	import mx.logging.ILogger;
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	
	public class ConsoleLogger 
	{
		//~ Instance Attributes -----------------------------------------------
		private var logger : ILogger;
		
		//~ Constructor -------------------------------------------------------
		/**
		 * SingletonEnforcer parameter ensures that only the getInstance
		 * method can create an instance of this class.
		 */
		public function ConsoleLogger(category:String, enforcer:SingletonEnforcer) : void
		{
			this.logger = Log.getLogger(category);
		}
		
		//~ Methods -----------------------------------------------------------
		public static function getInstance(category:String):ConsoleLogger
		{
			return new ConsoleLogger(category, new SingletonEnforcer());
		}
		
		public static function addTarget(target:ILoggingTarget) : void {
			Log.addTarget(target);
		}
		
		public static function removeTarget(target:ILoggingTarget) : void {
			Log.removeTarget(target);
		}
		
		public function debug(message : String) : void {
			this.logger.debug(message);
		}
		
		// other logging methods by level (e.g. warn, error)	
	}	
}
internal class SingletonEnforcer {}