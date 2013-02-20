require 'spec_helper'

describe Entasis::Relations do
  let(:attributes) do
    {
      name: 'Volvo',
      people: [{ name: 'Aslog' }],
      passengers: [{ name: 'Gunnar' }],
      destinations: [{ name: 'Stockholm' }]
    }
  end
  let(:car) { Car.new }
  let(:person) { car.people.first }
  let(:passenger) { car.passengers.first }
  let(:destination) { car.destinations.first }

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

    context 'subclasses' do
      it 'creates a new instance of the relation' do
        expect(destination).to be_a(Car::Destination)
        expect(destination.name).to eq('Stockholm')
      end
    end

    context 'when belongs_to was given a custom class name' do
      it 'sets the correct relation' do
        expect(destination.transportation).to eq(car)
      end
    end
  end
end
