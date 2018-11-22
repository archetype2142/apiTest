require 'rails_helper'

class ApiService
	def call(data, simulate_failiure: false)

		unit = Unit.find_by(name: data[:name])
		if unit 
			if(data[:size])
				factor = unit.factors.find_by(name: "size")
				factor.update(value: data[:size])
			else 
				unit.factors.delete_all
			end
			ActiveRecord::Base.transaction do
				unit.update!(kind: data[:type], agency: data.fetch(:agency, false))
				raise ActiveRecord::Rollback if simulate_failiure
			end
		else
			unit = Unit.new(
				name: data[:name],
				kind: data[:type], 
				agency: data.fetch(:agency, false)
			)
			factor = Factor.new(name: 'size', value: data[:size])

			ActiveRecord::Base.transaction do
				unit.factors << factor
				unit.save!
				raise ActiveRecord::Rollback if simulate_failiure
			end
			data
		end
	end
end

RSpec.describe ApiService do
	example_data = { name: "666", type: "flat", agency: false, size: 48 }
	api = ApiService.new
	it 'takes arguments in call function' do 
		expect(api.call(example_data)).to eq example_data
	end
	
	it 'creates a unit' do
		api.call(example_data)
		units = Unit.all
		expect(units.count).to_not eq 0
	end

	it 'creates factors' do 
		api.call(example_data)
		factor = Unit.last.factors.last
		expect(factor.name).to eq "size"
		expect(factor.value).to eq 48.to_s
	end

	it 'create a unit only with type flat' do
		api.call(example_data)
		unit = Unit.last 
		expect(unit.kind).to eq "flat"
	end

	it 'creates a unit with name 666, type flat agency true' do
		api.call(example_data)
		unit = Unit.last 
		expect(unit.name).to eq "666"
		expect(unit.kind).to eq "flat"
		expect(unit.agency).to eq false
	end

	it 'creates unit only if name and type are given' do
		api.call(name: example_data[:name], type: example_data[:type])
		unit = Unit.last 
		expect(unit.name).to eq "666"
		expect(unit.kind).to eq "flat"	
	end

	it 'saves with agency false by default' do
		api.call(name: example_data[:name], type: example_data[:type])
		unit = Unit.last
		expect(unit.agency).to eq false
	end

	it 'updates data when given different parameters' do
		api.call(example_data)
		api.call(name: example_data[:name], type: "room", agency: true, size: 49)
		unit = Unit.last
		factor = unit.factors.last
		expect(unit.kind).to eq "room"
		expect(unit.agency).to eq true
		expect(factor.value).to eq 49.to_s
	end

	it 'factor is removed after update if not provided' do
		api.call(example_data)
		api.call(name: example_data[:name], type: "room", agency: true)
		factor = Unit.last.factors.last
		expect(factor).to eq nil
	end

	it "unit shouldn't be created when simulate_failiure is true" do
		api.call(example_data, simulate_failiure: true)
		unit = Unit.last
		expect(unit).to eq nil
	end

	it "unit shouldn't be updated when simulate_failiure is true" do
		api.call(example_data)
		api.call({ name: example_data[:name], type: "room", agency: true, size: 49 }, simulate_failiure: true)
		unit = Unit.last
		expect(unit.kind).to eq "flat"
	end
end

