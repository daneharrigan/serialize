class ResourceSerializer < Serialize
  structure do
    {
      name:  name,
      type:  type,
      users: UserSerializer.new(users)
    }
  end
end
