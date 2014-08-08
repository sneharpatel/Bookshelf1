class Book < ActiveRecord::Base

  before_validation :strip_whitespace

  def strip_whitespace
    self.title= title.gsub(/\s+/," ").strip
  end

  validates :title,:description,:image_url,:price,presence: true

  validates :title, uniqueness: { case_sensitive: false }, length: {maximum: 60}

  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  validates :discount_price, allow_blank: true, numericality:{greater_than_or_equal_to: 0.00}

  validate :discount_price_cannot_be_greater_than_original_price, allow_blank: true

  has_many :line_items


  def discount_price_cannot_be_greater_than_original_price
    if self.discount_price? && self.price?
      if self.discount_price > self.price
        errors.add(:discount_price,"cannot be greater than original price")
      end

    end
  end

  validates :image_url, format: {
      with: %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
