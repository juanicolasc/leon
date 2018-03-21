class Sale < ApplicationRecord
  PAYMENT = ["Efectivo","Tarjeta"]
    has_many :charges, inverse_of: :sale
    belongs_to :user
    accepts_nested_attributes_for :charges, :reject_if => :all_blank, :allow_destroy => true
      validates :customer_name, :customer_identification, :customer_phone, :total_charge, :number_of_items, :payment_method, presence: true
      validates :number_of_items, :total_charge, numericality: true
    
end
