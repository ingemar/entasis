entasis
-------

Entasis provides a few very useful instance methods for Struct based classes. Handy for models without a database.

Example:

  class Person < Struct.new(:name, :age, :city)
    include Entasis::Base

    def age=(years)
      self['age'] = years.to_i
    end
  end

  hilda = Person.new(:name => 'Hilda', :age => '23', :city => 'Berlin')
  hilda.attribute_names # => ["name", "age", "city"]
  hilda.attributes      # => {"name"=>"Hilda", "age"=>23, "city"=>"Berlin"}


== Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
* Send me a pull request.

== Author
Ingemar Edsborn, ingemar@elabs.se

== Copyright

Copyright (c) 2010 Elabs AB. See LICENSE for details. http://www.elabs.se

