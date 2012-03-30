class Serialize
  class Json < Format
    def render(*args)
      # args are empty unless called through
      # another to_json call
      args.empty? ? content.to_json : content
    end
  end
end
