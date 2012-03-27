require "test_helper"

class SerializeTest < MiniTest::Unit::TestCase
  def setup
    @user = MockUser.new
  end

  def test_default_serialization
    serializer = UserSerializer.new(@user)
    json = { name: @user.name, age: @user.age }.to_json

    assert_equal json, serializer.to_json
  end

  def test_named_serialization
    serializer = UserSerializer.new(@user, :as => :extended)
    json = { name: @user.name, age: @user.age, email: @user.email }.to_json

    assert_equal json, serializer.to_json
  end

  def test_collection_serialization
    collection = [@user, @user, @user]
    user_hash  = { name: @user.name, age: @user.age }
    json = [user_hash, user_hash, user_hash].to_json
    serializer = UserSerializer.new(collection)

    assert_equal json, serializer.to_json
  end

  def test_named_collection_serialization
    collection = [@user, @user, @user]
    user_hash  = { name: @user.name, age: @user.age, email: @user.email }
    json = [user_hash, user_hash, user_hash].to_json
    serializer = UserSerializer.new(collection, :as => :extended)

    assert_equal json, serializer.to_json
  end

  def test_nested_serializers
    resource = MockResource.new
    user_hash  = { name: @user.name, age: @user.age }
    json = {
      name: resource.name,
      type: resource.type,
      users: resource.users.size.times.map { user_hash }
    }.to_json

    serializer = ResourceSerializer.new(resource)

    assert_equal json, serializer.to_json
  end
end
