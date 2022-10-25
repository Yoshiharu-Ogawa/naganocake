class Genre < ApplicationRecord

  has_many :item, dependent: :destroy

end
