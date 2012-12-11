class Serialize
  class Generator

    def initialize(object, block)
      @object = object
      @block  = block
    end

    def to_hash
      case @block.arity
        when 0 then @object.instance_eval(&@block)
        when 1 then @block.call(@object)
      end
    end

  end
end
