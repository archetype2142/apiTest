require 'rails_helper'

RSpec.describe Unit, type: :model do
	
	it 'unit has been created' do
		unit = Unit.new(
			name: "test",  
			kind: "apartment", 
			rent: 2000, 
			capacity: 5, 
			agency: true, 
			location_id: 5
		) 
		
		expect(unit).to be_valid
	end
end

RSpec.describe Factor, type: :model do 
	
	it 'factor has been create' do
		factor = Factor.new(
			name: "size",
			value: 48
		)
	end

	it 'testing the relation' do
		unit = Unit.new
		factor = Factor.new(name: "anything", value: 48)
		unit.factors << factor
		unit.save!
		# byebug
		# factor.save!
		expect(unit.factors.count).to eq 1
	end
end 