package hxPromiseThenableTest;

import hxPromiseThenableTest.JsPromiseIO.JsPromiseIO;

class HxPromiseThenableTest {

	public static function main() {
		var jsPromiseIO = new JsPromiseIO();
		var testService = new TestService( jsPromiseIO );
		testService.mySimpleScript();
	}
}
