package hxPromiseThenableTest;

import hxPromiseThenable.PromiseThenableHelper;
import js.lib.Promise;
import hxPromiseThenable.PromiseThenable;
import hxPromiseThenableTest.TestService.ITestIO;
import hxThenable.Thenable.Thenable;

using Lambda;

class JsPromiseIO implements ITestIO {

	public function new() {}

	/**
		Converts unit to Thenable
	**/
	public function lift<V>( v : V ) : Thenable<V> {
		return PromiseThenableHelper.lift( v );
	}

	/**
		Await ready and success of all thenables and convert them values to array of
		same count, as a given array. 
	**/
	public function all<V>( all : Array<Thenable<V>> ) : Thenable<Array<V>> {
		return PromiseThenableHelper.all( all );
	}

	/**
		Await ready and of all thenables and convert only success of  them values to array. 
	**/
	public function some<V>( all : Array<Thenable<V>> ) : Thenable<Array<V>> {
		return PromiseThenableHelper.some( all );
	}

	/**
		Await ready of first success thenable and return its value as a thenable.
	**/
	public function any<V>( all : Array<Thenable<V>> ) : Thenable<V> {
		return PromiseThenableHelper.any( all );
	}

	public function readLnInt() : Thenable<Int> {
		return PromiseThenableHelper.exec(() -> {
			Sys.println( "Please input integer number:" );
			return Std.parseInt( Sys.stdin().readLine() );
		} );
	}

	public function printLnInt( i : Int ) : Thenable<{}> {
		return PromiseThenableHelper.exec(() -> {
			Sys.println( "Output num: " + Std.string( i ) );
			return {};
		} );
	}
}
