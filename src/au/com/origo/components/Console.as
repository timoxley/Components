package au.com.origo.components {
	
	import au.com.origo.components.interfaces.IMessageBoard;
	import au.com.origo.components.skins.ConsoleSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import spark.components.Button;
	import spark.components.RichText;
	import spark.components.SkinnableContainer;

	public class Console extends SkinnableContainer implements IMessageBoard
	{
		public static const DEFAULT_CATEGORY:String = "DefaultConsoleLoggerCategory";
		
		[SkinPart(required="true")]
		public var textSpace:RichText;
		
		[Bindable]
		public var text:String = "";
		
		[SkinPart(required="true")]
		public var clearBtn:Button;
		
		public function Console() {
			super();
			trace("Creating Console");
			setStyle("skinClass", au.com.origo.components.skins.ConsoleSkin);
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void {
			var consoleTarget:ConsoleTarget = new ConsoleTarget();
			consoleTarget.messageTarget = this;
			Log.addTarget(consoleTarget);
			clearBtn.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		public static function getLogger(category:String = null):ILogger {
			if (category) {
				return Log.getLogger(category);
			} else {
				return Log.getLogger(DEFAULT_CATEGORY);
			}			
		}
		
		public function postMessage(message:String):void {
			text = message + "\n" + text;
		}
		
		public function clear():void {
			text = "";
		}
		
		private function handleClick(event:MouseEvent):void{
			clear();
		}
		
	}
}