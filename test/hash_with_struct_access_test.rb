require "test/unit"

require "./lib/hash_with_struct_access"

class HashWithStructAccessTest < Test::Unit::TestCase
  def test_should_be_kind_of_hash
    assert(HashWithStructAccess.new({}).kind_of?(Hash))
  end

  def test_should_be_initializable_by_hash_object
    assert_equal(HashWithStructAccess.new({:foo => :bar}).to_hash, {"foo" => :bar})
  end

  def test_should_be_initializable_by_options
    assert_equal(HashWithStructAccess.new(:foo => :bar).to_hash, {"foo" => :bar})
  end

  def test_should_be_initializable_with_nothing_given
    hash = HashWithStructAccess.new
    assert_equal(hash.keys, [])
    assert_equal(hash.values, [])
  end

  def test_should_convert_to_hash_properly
    hash = {"foo" => "bar"}
    assert_equal(HashWithStructAccess.new(hash).to_hash, hash)
  end

  def test_should_stringify_all_keys
    hash = HashWithStructAccess.new(:foo => {1 => %w(bar baz)})
    assert_equal(hash.to_hash, {"foo" => {"1" => %w(bar baz)}})
    assert_equal(hash[:foo], nil)
  end

  def test_should_behave_like_hash
    hash = HashWithStructAccess.new(:foo => {1 => %w(bar baz)})
    assert_equal(hash["foo"], {"1" => %w(bar baz)})
    assert_equal(hash["foo"]["1"], %w(bar baz))
    assert_equal(hash["blub"], nil)
  end

  def test_should_behave_like_struct
    hash = HashWithStructAccess.new(:foo => {:bar => :baz})
    assert_equal(hash.foo, {"bar" => :baz})
    assert_equal(hash.foo["bar"], :baz)
    assert_equal(hash.foo.bar, :baz)
    assert_equal(hash["foo"].bar, :baz)
  end

  def test_should_convert_subhashes_to_hashes_with_struct_access
    hash = HashWithStructAccess.new(:foo => {:bar => {:baz => :blub}})
    assert(hash.foo.kind_of?(HashWithStructAccess))
    assert(hash.foo.bar.kind_of?(HashWithStructAccess))
  end

  # The main purpose of HashWithStructAccess is to be a configuration object,
  # so it would be not such a good idea to modify a configuration object at the runtime.
  def test_should_not_allow_modifications_after_initialization_by_default
    hash = HashWithStructAccess.new(:foo => :bar)
    begin
      hash[:foo] = :baz
    rescue RuntimeError => e
      assert_equal(e.message, "can't modify frozen HashWithStructAccess")
    end
  end
end
