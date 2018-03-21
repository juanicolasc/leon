class Item < ApplicationRecord
    has_many :charges, inverse_of: :item
    mount_uploader :image, ImageUploader
    
    def self.available_stock
        self.where("stock > 0").order(:name)
    end
end
