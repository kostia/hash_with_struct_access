Hash object with struct access.
Main purpose is to be a configuration object.

* It can't be modified after initialization
* All keys will be stringified

```ruby
hash = HashWithStructAccess.new(:foo => {:bar => :baz})
hash.foo # => {"bar" => :baz}
hash.foo.bar => :baz
```

