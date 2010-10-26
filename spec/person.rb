class Person < Struct.new(:name, :age, :city)
  include Entasis::Base
  
  def age=(years)
    self['age'] = years.to_i
  end
end
