entasis
=======

[![Build Status](https://secure.travis-ci.org/ingemar/entasis.png)](http://travis-ci.org/ingemar/entasis)
[![Code Climate](https://codeclimate.com/github/ingemar/entasis.png)](https://codeclimate.com/github/ingemar/entasis)

Entasis provides a few neat methods for building a basic class. Handy for models without a database.

Example:

```ruby
class Person
  include Entasis::Model

  has_many :friends

  attributes :name, :age, :city

  validates :name, presence: true

  def age=(years)
    @age = years.to_i
  end
end

class Friend
  include Entasis::Model

  belongs_to :best_friend, class: 'Person'

  attributes :name
end


attributes = { name: 'Hilda', age: '23', city: 'Stockholm', friends: [{ name: 'Emma' }, { name: 'Johan' }] }
hilda = Person.new attributes

hilda.attribute_names                  # => ["name", "age", "city"]
hilda.attributes                       # => {"name"=>"Hilda", "age"=>23, "city"=>"Stockholm"}

hilda.friends                          # => [#<Friend:0x0 @name="Emma">, #<Friend:0x1 @name="Johan">]
hilda.friends[0].best_friend == hilda  # => true

anon = Person.new
anon.valid?           # => false
anon.errors           # => {:name=>["can't be blank"]}>
```

Default behavior is to raise if any key in the hash given to `.new` or `#attributes=` is not defined,
this can be circumvented by passing `ignore_undefined: true` as options when defining your attributes.


Transposing keys
----------------

If you include the module `Entasis::TransposeKeys` after you have included `Entasis::Model`,
keys in the given hash will be downcased and underscored before calling the setter methods.

This can be very useful when you got hash with camelcased keys, for example from an external service serving XML soup.


Contributors
------------

  - Ingemar Edsborn (ingemar)
  - Gabriel Reis (greis)
  - Jack Christensen (jackc)
  - Johnny Winn (nurugger07)
  - Joshua Davey (jgdavey)

