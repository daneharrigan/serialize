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
        when 0 then @object.instance_eval(&@block)
        when 1 then @block.call(@object)
      end
    end

  end
end
