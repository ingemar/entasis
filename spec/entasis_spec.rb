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
  end

  describe "#attributes" do
    it 'returns a hash of attributes names and values' do
      hilda.attributes.should == {"name"=>"Hilda", "age"=>23, "city"=>"Berlin"}
    end
  end

  context "validations" do
    describe "#valid?" do
      it "validates" do
        hilda.should be_valid
      end

      it "will have errors" do
        anon = Person.new(:name => "")
        anon.should_not be_valid
        anon.errors.should == { :name => ["can't be blank"] }
      end
    end
  end
end
