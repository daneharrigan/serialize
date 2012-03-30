require "serialize/version"
require "serialize/generator"
require "serialize/format"
require "serialize/json"
require "serialize/xml"
require "active_support/core_ext"

class Serialize
  def initialize(object, options={})
    key     = options[:as] || :default
    @object = object
    @block  = self.class.structures[key]
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
Serialize.register "application/xml",  Serialize::Xml
