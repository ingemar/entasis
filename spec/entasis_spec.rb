require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/person')

describe "Entasis::Base" do
  let(:hilda) { hilda = Person.new(:name => 'Hilda', :age => '23', :city => 'Berlin') }

  describe "#new" do
    it "sets the attributes from the given hash" do
      hilda.name.should == 'Hilda'
      hilda.age.should  == 23
      hilda.city.should == 'Berlin'
    end
  end
  
  describe "#attribute_names" do
    it 'returns a list of attribute names' do
      hilda.attribute_names.should == %w[name age city]
    end
    
    it 'is an alias for #members' do
      Person.instance_method(:attribute_names).should == Person.instance_method(:members)
    end
  end
  
  describe "#attributes" do
    it 'returns a hash of attributes names and values' do
      hilda.attributes.should == {"name"=>"Hilda", "age"=>23, "city"=>"Berlin"}
    end
  end
end
