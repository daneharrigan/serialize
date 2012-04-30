class Serialize
  class Generator
    instance_methods.each do |m|
      undef_method m unless m =~ /^(__|object_id)/
    end

    attr :id

    def initialize(object, block)
      @object = object
      @block  = block
      @id = @object.id
    end

    def to_hash
      instance_eval &@block
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
