Hash object with struct access.
Main purpose is to be a configuration object.

*Warning*: It can't be modified after initialization.

```ruby
# Simple example
hash = HashWithStructAccess.new(:foo => {:bar => 42})
hash.foo #=> {:bar => 42}
hash.foo.bar #=> 42

# More complex example
hash = HashWithStructAccess.new(:foo => {(o = Object.new) => {"bar" => {1 => :baz}}})
hash.foo #=> {o => {"bar" => {1 => :baz}}}
hash.foo[o] #=> {"bar" => {1 => :baz}}
hash.foo[o].bar #=> {1 => :baz}
hash.foo[o].bar[1] #=> :baz
```

