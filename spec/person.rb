class Person < Entasis::Base
  attributes :name, :age, :city

  def age=(years)
    @age = years.to_i
  end
end
