json.extract! item, :id, :code, :brand, :name, :supplier, :description, :price, :cost, :stock, :created_at, :updated_at
json.url item_url(item, format: :json)
