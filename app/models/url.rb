class Url < ActiveRecord::Base

  belongs_to :post

  scope :canonical, -> { where(canonical: true) }
end
