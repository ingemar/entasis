require 'spec_helper'

describe Entasis::Relations do
  let(:attributes) do
    {
      name: 'Volvo',
      people: [{ name: 'Aslog' }],
      passengers: [{ name: 'Gunnar' }]
    }
  end
  let(:car) { Car.new }
  let(:person) { car.people.first }
  let(:passenger) { car.passengers.first }

  describe '#attributes=' do
    before { car.attributes = attributes }

    context 'when given a hash' do
      it 'creates a new instance of the relation' do
        expect(car.name).to eq('Volvo')
        expect(person).to be_a(Person)
        expect(person.name).to eq('Aslog')
        expect(person.car).to eq(car)
      end
    end

    context 'when relation definied with a custom class' do
      it 'creates a new instance of the relation' do
        expect(passenger).to be_a(Person)
        expect(passenger.name).to eq('Gunnar')
        expect(passenger.car).to eq(car)
      end
    end
  end
end
