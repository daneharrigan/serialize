class Serialize
  class Generator
    instance_methods.each do |m|
      undef_method m unless m =~ /^(__|object_id)/
    end

    attr :id

    def initialize(object, block)
      @object = object
      @block  = block
      @id = @object.id if @object.respond_to? :id
    end

    def to_hash
      case @block.arity
        when 0 then instance_eval &@block
        when 1 then @block.call(@object)
      end
    end

    def method_missing(*args, &block)
      method = args.first

      if @object.respond_to? method
        @object.send *args, &block
      else
        raise NoMethodError
      end
    end
  end
end
