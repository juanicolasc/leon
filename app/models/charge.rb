class Charge < ApplicationRecord
    belongs_to :sale, inverse_of: :charges
    belongs_to :item, inverse_of: :charges
    
    def item_name
      item.try(:name)
    end

    def item_name=(name)
      self.item = Item.find_by(name: name).where("stock > 0").order(:name) if name.present?
    end

end
