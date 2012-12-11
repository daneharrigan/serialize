require "serialize"
require "support/mock_user"
require "support/mock_resource"
require "support/user_serializer"
require "support/resource_serializer"

require "minitest/benchmark"
require "minitest/autorun"

class BenchSerializationTest < MiniTest::Unit::TestCase
  def self.bench_range
    [100, 1_000, 10_000, 100_000, 1_000_000]
  end

  def bench_with_instance_eval
    assert_performance_linear do |n|
      collection = n.times.map do
        User.new(:name => "John Smith", :age => "27", :gender => "M")
      end

      UserSerializer.new(collection).to("application/json")
    end
  end

  def bench_without_instance_eval
    assert_performance_linear do |n|
      collection = n.times.map do
        User.new(:name => "John Smith", :age => "27", :gender => "M")
      end

      UserSerializer.new(collection, :as => :new).to("application/json")
    end
  end

  class User
    attr :name
    attr :age
    attr :gender

    def initialize(args={})
      @name   = args[:name]
      @age    = args[:age]
      @gender = args[:gender]
    end
  end

  class UserSerializer < Serialize
    structure do
      {
        :name   => name,
        :age    => age,
        :gender => gender
      }
    end

    structure(:new) do |user|
      {
        :name   => user.name,
        :age    => user.age,
        :gender => user.gender
      }
    end
  end
end
