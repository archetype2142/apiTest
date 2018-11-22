class Unit < ApplicationRecord
	has_many :factors, as: :subject, dependent: :destroy
end