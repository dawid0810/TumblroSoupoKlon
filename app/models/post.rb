class Post < ActiveRecord::Base
  has_many :notes, dependent: :destroy
  has_many :posts
  has_many :images, dependent: :destroy
  belongs_to :post
  belongs_to :user

  accepts_nested_attributes_for :notes, reject_if: proc { |n| n[:body].blank? }, allow_destroy: true
  accepts_nested_attributes_for :images, reject_if: proc { |n| n[:file].blank? && n[:url].blank? && n[:np] == "true" }, allow_destroy: true

  validate :not_empty

  def not_empty
    if self.notes.empty? && self.images.empty?
      errors[:base] << ('Empty post is not valid.')
    end
  end

end
