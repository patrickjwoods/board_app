class Board < ActiveRecord::Base
	belongs_to :project
	has_many :ideas, :dependent => :destroy

	accepts_nested_attributes_for :ideas

end
