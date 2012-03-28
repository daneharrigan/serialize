require "serialize/version"
require "serialize/generator"
require "active_support/core_ext"

class Serialize
  def initialize(object, options={})
    key     = options[:as] || :default
    @object = object
    @block  = self.class.structures[key]
  end

  def to_json(*args)
    # args are empty unless called through
    # another to_json call
    args.empty? ? content.to_json : content
  end

  alias as_json to_json

  def to_xml(*args)
    # args are empty unless called through
    # another to_xml call
    options = args.empty? ? { root: @object.class.name.titleize.downcase } : args.first
    content.to_xml(options)
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
