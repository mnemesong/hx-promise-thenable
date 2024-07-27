# hx-promise-thenable
Class implemepts Thenable and Helpers for them by js Promises.
See details of Thenable interfaces at https://lib.haxe.org/p/hx-thenable/


## API

### PromiseThenable.hx
```haxe
package hxPromiseThenable;

import js.lib.Promise;
import hxThenable.Thenable;

/**
	Implenents thenable interface by js Promises
	see hxThenable.Themable declaration
**/
class PromiseThenable<T> implements Thenable<T> {

	private var v : Promise<T>;

	public function new( v : Promise<T> ) {
		this.v = v;
	}

	public function getPromise() {
		return v;
	}

	public function map<V2>( f : T -> V2 ) : Thenable<V2> {
		return new PromiseThenable( this.v.then( val -> f( val ) ) );
	}

	public function then<V2>( f : T -> Thenable<V2> ) : Thenable<V2> {
		return new PromiseThenable(
			this.v.then( val -> cast( f( val ), PromiseThenable<Dynamic> )
				.getPromise() ) );
	}
}
```


### PromiseThenableHelper.hx
```haxe
package hxPromiseThenable;

import js.lib.Promise;
import hxThenable.Thenable.Thenable;

class PromiseThenableHelper {

	/**
		Converts unit to Thenable
	**/
	public static function lift<V>( v : V ) : Thenable<V> {
		return new PromiseThenable( Promise.resolve( v ) );
	}

	/**
		Await ready and success of all thenables and convert them values to array of
		same count, as a given array. 
	**/
	public static function all<V>( all : Array<Thenable<V>> ) : Thenable<Array<V>> {
		var vals = all.map( v -> cast( v, PromiseThenable<Dynamic> ).getPromise() );
		return cast new PromiseThenable( Promise.all( vals ) );
	}

	/**
		Await ready and of all thenables and convert only success of  them values to array. 
	**/
	public static function some<V>( all : Array<Thenable<V>> ) : Thenable<Array<V>> {
		var vals = all.map( v -> cast( v, PromiseThenable<Dynamic> ).getPromise() );
		return cast new PromiseThenable( Promise.allSettled( vals )
			.then( results -> results.map( r -> r.status == "fulfilled" ) ) );
	}

	/**
		Await ready of first success thenable and return its value as a thenable.
	**/
	public static function any<V>( all : Array<Thenable<V>> ) : Thenable<V> {
		var vals = all.map( v -> cast( v, PromiseThenable<Dynamic> ).getPromise() );
		return cast new PromiseThenable( Promise.race( vals ) );
	}

	/**
		Executes procedure and lift result to Thenable context
	**/
	public static function exec<A>( f : () -> A ) : Thenable<A> {
		try {
			var result = f();
			return new PromiseThenable( Promise.resolve( result ) );
		} catch( e ) {
			return new PromiseThenable( Promise.reject( e ) );
		}
	}
}
```