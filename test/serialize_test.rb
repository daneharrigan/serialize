require "test_helper"

class SerializeTest < MiniTest::Unit::TestCase
  def setup
    @user       = MockUser.new
    @resource   = MockResource.new
    @user_hash  = { name: @user.name, age: @user.age }
    @collection = [@user, @user, @user]
    @hash_collection = [@user_hash, @user_hash, @user_hash]
    @nested_hash = { name: @resource.name, type: @resource.type, users: @hash_collection }
  end

  def test_default_serialization
    serializer = UserSerializer.new(@user)
    assert_equal @user_hash.to_json, serializer.to_json
  end

  def test_named_json_serialization
    @user_hash[:email] = @user.email
    serializer = UserSerializer.new(@user, as: :extended)
    assert_equal @user_hash.to_json, serializer.to_json
  end

  def test_new_json_serialization
    @user_hash[:email] = @user.email
    serializer = UserSerializer.new(@user, as: :new)
    assert_equal @user_hash.to_json, serializer.to_json
  end

  def test_collection_json_serialization
    serializer = UserSerializer.new(@collection)
    assert_equal @hash_collection.to_json, serializer.to_json
  end

  def test_named_collection_json_serialization
    @hash_collection.each_with_index do |value, index|
      @hash_collection[index][:email] = @user.email
    end

    serializer = UserSerializer.new(@collection, as: :extended)
    assert_equal @hash_collection.to_json, serializer.to_json
  end

  def test_nested_json_serialization
    serializer = ResourceSerializer.new(@resource)
    assert_equal @nested_hash.to_json, serializer.to_json
  end

  def test_xml_serialization
    serializer = UserSerializer.new(@user)
    xml = @user_hash.to_xml(root: "mock-user")

    assert_equal xml, serializer.to_xml
  end

  def test_nested_xml_serialization
    serializer = ResourceSerializer.new(@resource)
    assert_equal @nested_hash.to_xml(root: "mock-resource"), serializer.to_xml
  end

  def test_default_responses
    serializer = UserSerializer.new(@user)
    assert_equal ["application/json", "application/xml"], serializer.responses
  end

  def test_to_content_type
    serializer = UserSerializer.new(@user)
    assert_equal serializer.to("application/json"), serializer.to_json
  end
end
