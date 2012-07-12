require "active_support/core_ext"

class Serialize
  class Xml < Format
    def render(*args)
      # args are empty unless called through
      # another to_xml call
      options = unless args.empty?
        args.first
      else
        subject = collection? ? object.first.class.name : object.class.name
        name = subject.include?("::") ? subject.split("::").last : subject
        name = name.titleize.downcase
        name = name.pluralize if collection?
        { :root => name }
      end

      content.to_xml(options)
    end

    def collection?
      object.respond_to? :map
    end

    private :collection?
  end
end

Serialize.register "application/xml",  Serialize::Xml
