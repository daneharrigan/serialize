# Serialize

Move serialization logic out of your model

## Installation

Add this line to your application's Gemfile:

    gem 'serialize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serialize

## Usage

    class UserSerializer < Serialize
      # create a default serialization structure
      structure do
        {
          :name   => name,
          :gender => gender,
          :email  => email
        }
      end

      # create a named serialization structure
      structure :extended do
        {
          :name   => name,
          :gender => gender,
          :email  => email,
          :height => height,
          :eye_color  => eye_color,
          :hair_color => hair_color
        }
      end
    end

    @app = App.find(params[:id])

    # serialize your @app object with the default structure
    AppSerializer(@app).to_json

    # serialize your @app with a specified structure
    AppSerializer.new(@app, :as => :extended)

    # serializers can take an array of objects
    @collection = App.all
    AppSerializer.new(@collection, :as => :extended)

## Serialization Formats

The `serialize` gem comes with JSON and XML support, but you can add
your own.

To do this, you'll have to define a `render` method that accepts
`*args`. Because JSON and XML parsing pass different arguments `*args`
keeps the interface generic.

The hash to be serialized will be available as `content`.

Once your serialization format is built register it with by using the
`Serialize.register` method.

    class Serialize::CSV < Serialize::Format
      def render(*args)
        if args.empty?
          # turn hash into CSV
        else
          # do something else because arguments are passed in
        end
      end
    end

    Serialize.register "text/csv", Serialize::CSV

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
