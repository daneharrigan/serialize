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
end
