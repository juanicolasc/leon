class Sale < ApplicationRecord
  PAYMENT = ["Efectivo","Tarjeta"]
    has_many :charges, inverse_of: :sale
    belongs_to :user
    accepts_nested_attributes_for :charges, :reject_if => :all_blank, :allow_destroy => true
      validates :customer_name, :customer_identification, :customer_phone, :total_charge, :number_of_items, :payment_method, presence: true
      validates :number_of_items, :total_charge, numericality: true
    after_create :update_stock
    
    def self.search(term, page)
      if term
        where('customer_name LIKE ? or customer_identification LIKE ? ', "%#{term}%", "%#{term}%").paginate(page: page, per_page: 20).order('id DESC')
      else
        paginate(page: page, per_page: 20).order('id DESC') 
      end
    end
    
    def self.count_search(term)
      if term
        where('customer_name LIKE ? or customer_identification LIKE ? ', "%#{term}%", "%#{term}%").count
      else
        count
      end
    end
    
    private
    #updates stcok once a sale is created
    def update_stock
        for charge in self.charges
            charge.item.update_attribute(:stock, (charge.item.stock.to_i-1)) 
        end
    end
end
