class UserSerializer < Serialize
	structure do
		{
		  name: name,
		  age:  age
		}
	end

	structure :extended do
		{
		  name:  name,
		  age:   age,
		  email: email
		}
	end

  structure :new do |user|
		{
		  name:  user.name,
		  age:   user.age,
		  email: user.email
		}
  end
end
