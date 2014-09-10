class Project < ActiveRecord::Base
	belongs_to :user
	has_many :boards
	has_many :ideas, through: :boards
end
