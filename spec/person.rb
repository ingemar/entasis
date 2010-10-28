class Person < Entasis::Base
  attributes :name, :age, :city

  validates_presence_of :name

  def age=(years)
    @age = years.to_i
  end
end
