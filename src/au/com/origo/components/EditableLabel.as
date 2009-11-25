package au.com.origo.components
{
	import au.com.origo.components.skins.EditableLabelSkin;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import spark.components.RichEditableText;
	import spark.components.TextInput;
	
	[SkinState("editing")]
	
	public class EditableLabel extends TextInput
	{
		private var _editing:Boolean = false;
		
		[SkinPart(required="true")]
		public var textView:RichEditableText;
		
		public function EditableLabel() {
			super();
			setStyle("skinClass", au.com.origo.components.skins.EditableLabelSkin);
			this.focusEnabled = false;
		}
		
		public function get editing():Boolean {
			return _editing;
		}
		
		public function set editing(value:Boolean):void {
			_editing = value;
			
			if (!_editing) {
				this.focusManager.setFocus(this.focusManager.getNextFocusManagerComponent(true));
				this.focusManager.hideFocus();
			}
			this.invalidateSkinState();
		}
		
		override protected function getCurrentSkinState():String {
			return editing ? "editing" : super.getCurrentSkinState();
		}
		
		protected function focusHandler(event:FocusEvent):void {
			
			if (event.type == FocusEvent.FOCUS_IN) {
				this.editing = true;
				
			} else if (event.type == FocusEvent.FOCUS_OUT) {
				this.editing = false;
			}
			event.stopPropagation();
		}
		
		private function keyboardHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == Keyboard.ENTER) {
				if (this.editing) {
					this.editing = false;
				}
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			
			super.partAdded(partName, instance);
			
			if (instance == textView) {
				textView.addEventListener(FocusEvent.FOCUS_IN, focusHandler);
				textView.addEventListener(FocusEvent.FOCUS_OUT, focusHandler);
				textView.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void {
			if (instance == textView)
			{
				textView.removeEventListener(FocusEvent.FOCUS_IN, focusHandler);
				textView.removeEventListener(FocusEvent.FOCUS_OUT, focusHandler);
				textView.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			}
			
			super.partRemoved(partName, instance);
		}
	}
}