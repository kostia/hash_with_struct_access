class HashWithStructAccess < Hash
  VERSION = "0.0.1"

  def initialize(hash = {})
    hash.each_pair do |key, value|
      self[key] = value.kind_of?(Hash) ? self.class.new(value) : value
    end
    self.freeze
  end

  def method_missing(method_name)
    self[method_name] || self[method_name.to_s] || super
  end

  # Method stub to be overriden by plugins
  def self.compute_path(path)
    path
  end
end
