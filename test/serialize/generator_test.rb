require "test_helper"

class Serialize::GeneratorTest < MiniTest::Unit::TestCase
  def setup
    object = MockUser.new
    block = proc do
      { name: name, age: age }
    end

    @generator = Serialize::Generator.new(object, block)
    @hash = { name: object.name, age: object.age }
  end

  def test_hash_creation_from_block
    assert_equal @hash, @generator.to_hash
  end
end
