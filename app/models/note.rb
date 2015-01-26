class Note < ActiveRecord::Base
  belongs_to :post
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :body
end
