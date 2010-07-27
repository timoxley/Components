package com.timoxley.utilities
{
	import com.timoxley.utilities.events.InfoEvent;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	
	import mx.resources.IResourceBundle;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class SafeResourceManager implements IResourceManager
	{
		public static const RESOURCE_NOT_FOUND:String = "resource_not_found";
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var resourceManager:IResourceManager;
		
		public function SafeResourceManager() {
			resourceManager = ResourceManager.getInstance();
		}
		
		public function get localeChain():Array {
			return resourceManager.localeChain;
		}
		
		public function set localeChain(value:Array):void {
			resourceManager.localeChain = value;
		}
		
		public function loadResourceModule(url:String, update:Boolean=true, applicationDomain:ApplicationDomain=null, securityDomain:SecurityDomain=null):IEventDispatcher {
			return resourceManager.loadResourceModule(url, update, applicationDomain, securityDomain);
		}
		
		public function unloadResourceModule(url:String, update:Boolean=true):void {
			resourceManager.unloadResourceModule(url, update);
		}
		
		public function addResourceBundle(resourceBundle:IResourceBundle):void {
			resourceManager.addResourceBundle(resourceBundle);
		}
		
		public function removeResourceBundle(locale:String, bundleName:String):void {
			resourceManager.removeResourceBundle(locale, bundleName);
		}
		
		public function removeResourceBundlesForLocale(locale:String):void {
			resourceManager.removeResourceBundlesForLocale(locale);
		}
		
		public function update():void {
			resourceManager.update();
		}
		
		public function getLocales():Array {
			return resourceManager.getLocales();
		}
		
		public function getPreferredLocaleChain():Array {
			return resourceManager.getPreferredLocaleChain();
		}
		
		public function getBundleNamesForLocale(locale:String):Array {
			return resourceManager.getBundleNamesForLocale(locale);
		}
		
		public function getResourceBundle(locale:String, bundleName:String):IResourceBundle {
			return resourceManager.getResourceBundle(locale, bundleName);
		}
		
		public function findResourceBundleWithResource(bundleName:String, resourceName:String):IResourceBundle {
			return resourceManager.findResourceBundleWithResource(bundleName, resourceName);
		}
		
		public function getObject(bundleName:String, resourceName:String, locale:String=null):* {
			var value:Object = resourceManager.getObject(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return null; 
			}
			return value;
		}
		
		public function getString(bundleName:String, resourceName:String, parameters:Array=null, locale:String=null):String {
			var value:String = resourceManager.getString(bundleName, resourceName, parameters, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return resourceName; 
			}
			return value;
		}
		
		public function getStringArray(bundleName:String, resourceName:String, locale:String=null):Array {
			var value:Array = resourceManager.getStringArray(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return null; 
			}
			return value;
		}
		
		public function getNumber(bundleName:String, resourceName:String, locale:String=null):Number {
			var value:Number = resourceManager.getNumber(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return 0; 
			}
			return value;
		}
		
		public function getInt(bundleName:String, resourceName:String, locale:String=null):int {
			var value:int = resourceManager.getInt(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return 0; 
			}
			return value;
		}
		
		public function getUint(bundleName:String, resourceName:String, locale:String=null):uint {
			var value:uint = resourceManager.getUint(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return 0;
			}
			return value;
		}
		
		public function getBoolean(bundleName:String, resourceName:String, locale:String=null):Boolean {
			var value:Boolean = resourceManager.getBoolean(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));
				return false; 
			}
			return value;	
		}
		
		public function getClass(bundleName:String, resourceName:String, locale:String=null):Class {
			var value:Class = resourceManager.getClass(bundleName, resourceName, locale);
			if (!value) {
				this.eventDispatcher.dispatchEvent(new InfoEvent(InfoEvent.WARNING, RESOURCE_NOT_FOUND, resourceName));				
				return null; 
			}
			return value;
		}
		
		public function installCompiledResourceBundles(applicationDomain:ApplicationDomain, locales:Array, bundleNames:Array):void {
			resourceManager.installCompiledResourceBundles(applicationDomain, locales, bundleNames);
		}
		
		public function initializeLocaleChain(compiledLocales:Array):void {
			resourceManager.initializeLocaleChain(compiledLocales);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean {
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean {
			return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean {
			return eventDispatcher.willTrigger(type);
		}
		
		public function hasResource(bundleName:String, resourceName:String, locale:String=null):Boolean {
			if (resourceManager.getObject(bundleName, resourceName, locale)) {
				return true;
			}
			return false;
		}
	}
}