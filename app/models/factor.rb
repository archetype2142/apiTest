class Factor < ApplicationRecord
	belongs_to :subject, :polymorphic => true
end