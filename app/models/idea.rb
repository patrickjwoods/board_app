require 'open-uri'

class Idea < ActiveRecord::Base
  belongs_to :board
    attr_accessor :image_url

  has_attached_file   :image, 
                      :styles => { :medium => "400x400>", :thumb => "100x100>" }
  
  validates_attachment_content_type   :image, 
                                      :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  before_validation :download_remote_image, :if => :image_url_provided?

  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

  # validates :image_file_name, presence: true, :unless => :image_url_provided? 

private
  
  def image_url_provided?
    !self.image_url.blank?
  end
  
  def download_remote_image
    self.image = do_download_remote_image
    self.image_remote_url = image_url
  end
  
  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end
  
end