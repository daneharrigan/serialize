class MockResource
  attr :name
  attr :type
  attr :users

  def initialize
    @name  = "Resource Item"
    @type  = "dedicated"
    @users = [MockUser.new, MockUser.new, MockUser.new]
  end
end
