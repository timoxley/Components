package com.timoxley.utilities.events
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	public class InfoEvent extends Event
	{
		public var message:String;
		public var params:Array;
		
		/**
		 * Some information that the user should be notified of. eg
		 * <ul>
		 * 	<li> Action performed with success
		 * 	<li> An event occurred
		 * </ul>
		 */
		static public const USER_INFO:String = "userInfoFlareEvent";
		
		/**
		 * Some error that the user should be notified of. eg
		 * <ul>
		 * 	<li> Connection failed
		 * 	<li> Invalid user text input
		 * 	<li> 
		 * </ul>
		 */
		static public const USER_ERROR:String = "userErrorFlareEvent";
		
		/**
		 * Programmer specific information for debugging purposes
		 * 
		 */
		static public const DEBUG:String = "debugFlareEvent";
		
		/**
		 * Programmer specific information for debugging purposes
		 * 
		 */
		static public const WARNING:String = "warningFlareEvent";
		
		/**
		 * Programmer specific information for debugging purposes.
		 * Means there is something wrong with the app and it cannot/should not continue.
		 * Program should shut down if it recieves this event.
		 */
		static public const FATAL:String = "fatalFlareEvent";
		
		/**
		 * @param type Type of event. If one of the constants defined in this class should be picked up by Logger & ResourceManager
		 * @param message Optional Textual message of event. Use ResourceManager property references (as defined in locale) if using LogCommand.
		 * @param rest other parameters for substitution by ResourceManager.getString
		 */
		public function InfoEvent(type:String, message:String="", ... rest:*) {
			this.params = rest;
			this.message = message;
			super(type, true);
		}

		override public function clone():Event {
			return new InfoEvent(this.type, message, params);
		}

	}
}