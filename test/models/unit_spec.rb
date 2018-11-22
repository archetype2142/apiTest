Rspec.describe Unit, type: :model do
	let { @unit = Unit.new(name: "test",  kind: "apartment", rent: 2000, capactity: 5,
		agency: true, location_id: 5) }
end