require "./test/test_helper"

describe HashWithStructAccess do
  it "should be kind of hash" do
    HashWithStructAccess.new(:foo => :bar).must_be_kind_of(Hash)
  end

  it "should be initializable by hash object" do
    hash = HashWithStructAccess.new({:foo => {:bar => :baz}})
    hash.to_hash.must_equal({:foo => {:bar => :baz}})
  end

  it "should be initializable by options" do
    hash = HashWithStructAccess.new(:foo => {:bar => :baz})
    hash.to_hash.must_equal({:foo => {:bar => :baz}})
  end

  it "should be initializable by hash like objects" do
    hash_like = HashLike.new
    hash_like[:foo] = {:bar => :baz}
    hash = HashWithStructAccess.new(hash_like)
    hash.to_hash.must_equal({:foo => {:bar => :baz}})
  end

  it "should be initializable by nothing" do
    hash = HashWithStructAccess.new
    hash.to_hash.must_equal({})
  end

  it "should convert to hash properly" do
    o = Object.new
    hash = {:foo => {1 => {o => "bar"}}}
    HashWithStructAccess.new(hash).to_hash.must_equal(hash)
  end

  it "should be able to handle numerical keys" do
    hash = HashWithStructAccess.new(:foo => {1 => {:bar => :baz}})
    hash.foo[1].bar.must_equal(:baz)
  end

  it "should be able to handle object keys" do
    o1, o2 = Object.new, Object.new
    hash = HashWithStructAccess.new(o1 => {:foo => {o2 => {:bar => :baz}}})
    hash[o1].foo[o2].bar.must_equal(:baz)
  end

  it "should behave like deep struct" do
    hash = HashWithStructAccess.new(:foo => {"bar" => {:baz => 42}})
    hash.foo.bar.baz.must_equal(42)
  end

  it "should convert subhashes to hashes with struct access" do
    hash = HashWithStructAccess.new(:foo => {"bar" => {:baz => 42}})
    hash.foo.must_be_kind_of(HashWithStructAccess)
    hash.foo.bar.must_be_kind_of(HashWithStructAccess)
  end

  # The main purpose of HashWithStructAccess is to be a configuration object,
  # so it would be not such a good idea to modify a configuration object at the runtime.
  it "should not allow modifications after initialization" do
    hash = HashWithStructAccess.new(:foo => :bar)
    Proc.new { hash[:foo] = :baz }.must_raise(RuntimeError,
        "can't modify frozen HashWithStructAccess")
  end

  it "should be able to act as method options" do
    HashLike.call_me_with_options(HashWithStructAccess.new(:foo => {:bar => :baz})).must_equal(
        HashLike.call_me_with_options(:foo => {:bar => :baz}))
  end

  it "should have dummy method for path computation" do
    HashWithStructAccess.compute_path("/foo/bar").must_equal("/foo/bar")
  end
end
