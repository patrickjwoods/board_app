class Project < ActiveRecord::Base
	belongs_to :user
	has_many :boards, :dependent => :destroy
	has_many :ideas, through: :boards, :dependent => :destroy

	accepts_nested_attributes_for :boards

	validates :name, presence: true

end
