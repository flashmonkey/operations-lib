package org.flashmonkey.operations.service
{
	import org.osflash.signals.Signal;

	public interface IOperation
	{
		function get displayName():String;
		
		function get onComplete():Signal;
		
		function get onError():Signal;
		
		function get onProgress():Signal;
		
		function get result():*;
		
		function get error():*;
		
		function get progress():Number;
		function set progress(value:Number):void;
		
		function execute():void;
		
		function addCompleteListener(f:Function):IOperation;
		function removeCompleteListener(f:Function):IOperation;
		
		function addErrorListener(f:Function):IOperation;
		function removeErrorListener(f:Function):IOperation;
		
		function addProgressListener(f:Function):IOperation;
		function removeProgressListener(f:Function):IOperation;
	}
}