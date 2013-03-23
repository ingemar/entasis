entasis
=======

[![Build Status](https://secure.travis-ci.org/ingemar/entasis.png)](http://travis-ci.org/ingemar/entasis)
[![Code Climate](https://codeclimate.com/github/ingemar/entasis.png)](https://codeclimate.com/github/ingemar/entasis)

Entasis provides a few neat methods for building a basic class. Handy for models without a database.

Example:

```ruby
class Person
  include Entasis::Model

  attributes :name, :age, :city

  validates :name, presence: true

  def age=(years)
    @age = years.to_i
  end
end

person = Person.new name: 'Hilda', age: '23', city: 'Stockholm'

person.attribute_names # => ["name", "age", "city"]
person.attributes      # => {"name"=>"Hilda", "age"=>23, "city"=>"Stockholm"}

anon = Person.new
anon.valid?           # => false
anon.errors           # => {:name=>["can't be blank"]}>
```

Relations
---------

You can build simple relations between objects.

Example:

```ruby
class Person
  include Entasis::Model

  has_many :friends

  attributes :name
end

class Friend
  include Entasis::Model

  belongs_to :best_friend, class: 'Person'

  attributes :name
end


person = Person.new name: 'Anna', friends: [{ name: 'Emma' }, { name: 'Johan' }]

person.friends                           # => [#<Friend:0x0 @name="Emma">, #<Friend:0x1 @name="Johan">]
person.friends[0].best_friend == person  # => true
```


Strict checking of attributes
-----------------------------

Default behavior is to ignore any key in the hash given to `.new` or `#attributes=` that's not in the list of attribute names.
By setting passing the option `strict: true` to the attribute definition it will raise an UnknownAttributeError for that class everytime an unkown key is in the given hash.


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

