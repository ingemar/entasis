require 'spec_helper'

describe Entasis::Model do
  let(:attributes) do
    { name: 'Hilda', age: '23', city: 'Berlin' }
  end
  let(:person) { Person.new(attributes) }

  describe '#new' do
    it 'calls #attributes= with the given hash' do
      Person.any_instance.should_receive(:attributes=).once.with(attributes)
      person
    end

    it 'does not require attribute hash' do
      expect { Person.new }.to_not raise_error
    end
  end

  describe '#attribute_names' do
    it 'returns a list of attribute names' do
      expect(person.attribute_names).to eq(%w[name age city].sort)
    end
  end

  describe '#attributes=' do
    context 'when given a hash' do
      it 'sets the attributes from the given hash' do
        person.attributes = attributes

        expect(person.name).to eq('Hilda')
        expect(person.age).to eq(23)
        expect(person.city).to eq('Berlin')
      end
    end

    it 'raises an error if attribute is unknown' do
      expect {
        Person.new(undefined: 'value')
      }.to raise_error Person::UnknownAttributeError, 'unkown attribute: undefined'
    end

    context 'when .attributes option :allow_unknown is set to true' do
      subject { Car.new(undefined: 'value') }

      it 'ignores that attribute' do
        expect(subject.attributes.keys).to_not include('undifined')
      end
    end
  end

  describe '#attributes' do
    it 'returns a hash of attributes names and values' do
      expect(person.attributes).to eq({ 'name' => 'Hilda', 'age' => 23, 'city' => 'Berlin' })
    end

    context 'subclasses' do
      let(:child) { Child.new(name: 'Hans', age: '8', candy: true) }

      it 'inherits attributes from the parent' do
        expect(child.attributes).to eq({ 'name' => 'Hans', 'age' => 8,  'city' => nil, 'candy' => true })
      end
    end
  end

  context 'validations' do
    describe '#valid?' do
      context 'when valid' do
        it { expect(person).to be_valid }
      end

      context 'invalid' do
        subject { Person.new(name: '') }

        it 'will have errors' do
          expect(subject).to_not be_valid
          expect(subject.errors.to_hash).to eq({ name: ["can't be blank"] })
        end
      end
    end
  end
end
