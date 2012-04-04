class Serialize
  class Xml < Format
    def render(*args)
      # args are empty unless called through
      # another to_xml call
      options = args.empty? ? { :root => object.class.name.titleize.downcase } : args.first
      content.to_xml(options)
    end
  end
end

