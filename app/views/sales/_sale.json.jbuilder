json.extract! sale, :id, :date, :customer_name, :customer_id, :customer_phone, :total_charge, :number_of_items, :payment_method, :comments, :user_id, :created_at, :updated_at
json.url sale_url(sale, format: :json)
