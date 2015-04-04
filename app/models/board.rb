class Board < ActiveRecord::Base
	belongs_to :project
	has_many :ideas, :dependent => :destroy

	accepts_nested_attributes_for :ideas

	validates :title, presence: true
	validates :description, presence: true

	before_create :generate_hash_token

	private

	  def generate_hash_token
	    begin
	      self.hash_token = SecureRandom.hex
	    end while self.class.exists?(hash_token: hash_token)
	  end

end
