package com.timoxley.components
{
	import com.timoxley.components.skins.EditableLabelSkin;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.managers.IFocusManagerComponent;
	
	import spark.components.RichEditableText;
	import spark.components.SkinnableContainer;
	import spark.components.TextSelectionHighlighting;
	
	[SkinState("editing")]
	
	public class EditableLabel extends SkinnableContainer implements IFocusManagerComponent
	{
		private var _editing:Boolean = false;
		private var changeWatcher:ChangeWatcher;
		
		[Bindable]
		public var text:String; 
		
		[SkinPart(required="true")]
		public var textView:RichEditableText;
		
		public function EditableLabel() {
			super();
			setStyle("skinClass", com.timoxley.components.skins.EditableLabelSkin);
			this.focusEnabled = false;
			this.mouseFocusEnabled = false;
		}
		
		public function get editing():Boolean {
			return _editing;
		}
		
		public function set editing(value:Boolean):void {
			_editing = value;
			
			if (!_editing) {
				this.focusManager.setFocus(this.focusManager.getNextFocusManagerComponent(true));
				this.focusManager.hideFocus();
				changeWatcher.reset(textView)
			} else {
				changeWatcher.unwatch();
			}
			this.invalidateSkinState();
		}
		
		override protected function getCurrentSkinState():String {
			return editing ? "editing" : super.getCurrentSkinState();
		}
		
		protected function focusHandler(event:FocusEvent):void {
			
			if (event.type == FocusEvent.FOCUS_IN) {
				trace("FOCUS_IN");
				//this.editing = true;
				
			} else if (event.type == FocusEvent.FOCUS_OUT) {
				trace("FOCUS_OUT");
				this.editing = false;
			}
			event.stopPropagation();
			
		}
		
		public function clickHandler(event:MouseEvent):void {
			if (event.type == MouseEvent.DOUBLE_CLICK) {
				this.editing = true;
				event.stopImmediatePropagation();
			}
			this.invalidateSkinState();
			//event.stopImmediatePropagation();
		}
		
		private function keyboardHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == Keyboard.ENTER) {
				if (this.editing) {
					this.editing = false;
				}
			}
			
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			
			if (instance == textView) {
				textView.doubleClickEnabled = true;
				textView.addEventListener(MouseEvent.DOUBLE_CLICK, clickHandler);
				//textView.addEventListener(MouseEvent.CLICK, clickHandler);
				textView.addEventListener(FocusEvent.FOCUS_IN, focusHandler);
				textView.addEventListener(FocusEvent.FOCUS_OUT, focusHandler);
				changeWatcher = BindingUtils.bindProperty(textView, 'text', this, 'text');
				
				textView.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
				textView.selectionHighlighting = TextSelectionHighlighting.ALWAYS;
			}
			
			super.partAdded(partName, instance);
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			
			if (instance == textView) {
				//textView.removeEventListener(FocusEvent.FOCUS_IN, focusHandler);
				textView.addEventListener(MouseEvent.DOUBLE_CLICK, clickHandler);
				textView.removeEventListener(FocusEvent.FOCUS_OUT, focusHandler);
				textView.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
				changeWatcher.unwatch();
			}
			
			super.partRemoved(partName, instance);
		}
	}
}