require "serialize/version"
require "serialize/generator"
require "serialize/format"
require "serialize/json"

class Serialize
  def initialize(object, options={})
    key     = options[:as] || :default
    @object = object
    @block  = self.class.structures[key]
  end

  def responses
    @@serializers.keys
  end

  def to(content_type)
    subtype = content_type.split("/").last
    send("to_#{subtype}")
  end

  def self.structure(key=nil, &block)
    key ||= :default
    structures[key] = block
  end

  def self.structures
    @structures ||= {}
  end

  def self.register(content_type, klass)
    @@serializers ||= {}
    @@serializers[content_type] = klass
    subtype = content_type.split("/").last

    define_method "to_#{subtype}" do |*args|
      @@serializers[content_type].new(@object, @block).render(*args)
    end

    send :alias_method, "as_#{subtype}", "to_#{subtype}"
  end
end

Serialize.register "application/json", Serialize::Json
