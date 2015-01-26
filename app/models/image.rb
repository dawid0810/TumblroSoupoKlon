class Image < ActiveRecord::Base
  belongs_to :post

  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :caption

  has_attached_file :file, styles: { medium: "500x500>" }
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end