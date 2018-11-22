class CreateFactors < ActiveRecord::Migration[5.2]
	def change
		create_table :factors do |t|
			t.string "name"
			t.string "value"
			t.references :subject, polymorphic: true
			
		end
			add_index :factors, :name
			add_index :factors, :subject_id
		add_index :factors, :subject_type
	end
end
