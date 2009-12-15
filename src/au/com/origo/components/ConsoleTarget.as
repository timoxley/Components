package au.com.origo.components
{
	
	import au.com.origo.components.interfaces.IMessageBoard;
	
	import mx.logging.ILogger;
	import mx.logging.LogEvent;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.LineFormattedTarget;
	import mx.resources.IResourceManager;
	
	public class ConsoleTarget extends LineFormattedTarget
	{
		[Inject]
		public var resourceManager:IResourceManager;
		
		public var messageTarget:IMessageBoard;
		
		public function ConsoleTarget()
		{
			super();
		}
		
		/**
		 * Event handler that is called by the logging API -- not to be called directly.
		 * @param event
		 */
		public override function logEvent(event : LogEvent) : void {
			
			// Take care to NOT include mx.*, as code in std lib issues log calls,
			// which will call this target, which will send a message to server
			// (through rpc operation), which will log to this again, ... until StackOverflowException
			var category : String = ILogger(event.target).category;
			if (category.indexOf("mx.") != 0) {
				if (messageTarget) {
					
					messageTarget.postMessage(event.message);
				}
			}
		}
	}
}
