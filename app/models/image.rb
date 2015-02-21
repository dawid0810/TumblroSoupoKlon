class Image < ActiveRecord::Base
  belongs_to :post

  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :caption

  has_attached_file :file, styles: { medium: "600x600>" }

  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :file, :less_than => 2.megabytes

  def url
  end

  def url=(u)
    if u.blank? == false
      self.file = open(u)
      self.source = u
    end
  end

  def np
  end
  def np=(np)
  end
end