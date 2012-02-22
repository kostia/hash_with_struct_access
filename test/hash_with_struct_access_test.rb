require "./test/test_helper"


class HashWithStructAccessTest < Test::Unit::TestCase
  def test_should_be_kind_of_hash
    assert(HashWithStructAccess.new(:foo => :bar).kind_of?(Hash))
  end

  def test_should_be_initializable_by_hash_object
    hash = HashWithStructAccess.new({:foo => {:bar => :baz}})
    assert_equal(hash.to_hash, {:foo => {:bar => :baz}})
  end

  def test_should_be_initializable_by_options
    hash = HashWithStructAccess.new(:foo => {:bar => :baz})
    assert_equal(hash.to_hash, {:foo => {:bar => :baz}})
  end

  def test_should_be_initializable_with_hash_like_objects
    hash_like = HashLike.new
    hash_like[:foo] = {:bar => :baz}
    hash = HashWithStructAccess.new(hash_like)
    assert_equal(hash.to_hash, {:foo => {:bar => :baz}})
  end

  def test_should_be_initializable_with_nothing_given
    hash = HashWithStructAccess.new
    assert_equal(hash.keys, [])
    assert_equal(hash.values, [])
  end

  def test_should_convert_to_hash_properly
    o = Object.new
    hash = {:foo => {1 => {o => "bar"}}}
    assert_equal(HashWithStructAccess.new(hash).to_hash, hash)
  end

  def test_should_be_able_to_handle_numerical_keys
    hash = HashWithStructAccess.new(:foo => {1 => {:bar => :baz}})
    assert_equal(hash.foo[1].bar, :baz)
  end

  def test_should_be_able_to_hadle_object_keys
    o1, o2 = Object.new, Object.new
    hash = HashWithStructAccess.new(o1 => {:foo => {o2 => {:bar => :baz}}})
    assert_equal(hash[o1].foo[o2].bar, :baz)
  end

  def test_should_behave_like_deep_struct
    hash = HashWithStructAccess.new(:foo => {"bar" => {:baz => 42}})
    assert_equal(hash.foo.bar.baz, 42)
  end

  def test_should_convert_subhashes_to_hashes_with_struct_access
    hash = HashWithStructAccess.new(:foo => {"bar" => {:baz => 42}})
    assert(hash.foo.kind_of?(HashWithStructAccess))
    assert(hash.foo.bar.kind_of?(HashWithStructAccess))
  end

  # The main purpose of HashWithStructAccess is to be a configuration object,
  # so it would be not such a good idea to modify a configuration object at the runtime.
  def test_should_not_allow_modifications_after_initialization
    hash = HashWithStructAccess.new(:foo => :bar)
    begin
      hash[:foo] = :baz
    rescue RuntimeError => e
      assert_equal(e.message, "can't modify frozen HashWithStructAccess")
    end
  end

  def test_should_be_able_to_act_as_method_options
    assert_equal(HashLike.call_me_with_options(HashWithStructAccess.new(:foo => {:bar => :baz})),
        HashLike.call_me_with_options(:foo => {:bar => :baz}))
  end
end
