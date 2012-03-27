class Serialize
  class Generator
    def initialize(object, &block)
      @object = object
      @block  = block
    end

    def to_hash
      instance_eval &@block
    end

    def method_missing(*args)
      method = args.first

      if @object.respond_to? method
        @object.send *args
      else
        super
      end
    end
  end
end
