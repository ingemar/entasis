entasis
-------
[![Build Status](https://secure.travis-ci.org/ingemar/entasis.png)](http://travis-ci.org/ingemar/entasis)

Entasis provides a few neat methods for building a basic class. Handy for models without a database.

Example:

```ruby
class Person
  include Entasis::Model

  attributes :name, :age, :city

  def age=(years)
    @age = years.to_i
  end
end

hilda = Person.new(name: 'Hilda', age: '23', city: 'Berlin')
hilda.attribute_names # => ["name", "age", "city"]
hilda.attributes      # => {"name"=>"Hilda", "age"=>23, "city"=>"Berlin"}

anon = Person.new
anon.valid?           # => false
anon.errors           # => {:name=>["can't be blank"]}>
```
