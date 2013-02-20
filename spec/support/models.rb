class Person
  include Entasis::Model
  belongs_to :car

  attributes :name, :age, :city

  validates_presence_of :name

  def age=(years)
    @age = years.to_i
  end
end

class Child < Person
  attributes :candy
end

class RelaxedPerson < Person
  attributes :baggypant, ignore_undefined: true
end

class Car
  include Entasis::Model
  include Entasis::TransposeKeys

  has_many :people
  has_many :passengers, class: 'Person'
  has_many :destinations

  attributes :name, :speed, :left_front_door, :right_front_door

  class Destination
    include Entasis::Model

    belongs_to :transportation, class: 'Car'

    attributes :name
  end
end
