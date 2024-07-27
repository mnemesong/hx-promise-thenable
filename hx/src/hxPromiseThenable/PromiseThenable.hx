package hxPromiseThenable;

import js.lib.Promise;
import hxThenable.Thenable;

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
