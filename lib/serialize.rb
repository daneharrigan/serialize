require "serialize/version"
require "serialize/generator"
require "json"

class Serialize
  def initialize(object, options={})
    key     = options[:as] || :default
    @object = object
    @block  = self.class.structures[key]
  end

  def to_json(*args)
    content.to_json
  end

  def content
    if @object.is_a? Array
      @object.map { |obj| Generator.new(obj, &@block).to_hash }
    else
      Generator.new(@object, &@block).to_hash
    end
  end

  private :content

  def self.structure(key=nil, &block)
    key ||= :default
    structures[key] = block
  end

  def self.structures
    @structures ||= {}
  end
end
