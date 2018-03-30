class Charge < ApplicationRecord
    require 'csv'

    belongs_to :sale, inverse_of: :charges
    belongs_to :item, inverse_of: :charges
    
    def self.search(page, start_date, end_date)
        select('sales.id as id, sales.date as date, items.name as name, items.price as retail_price, items.cost as cost, charges.price as sell_price, (charges.price - items.cost) as profit').joins(:sale, :item).where("sales.date" => start_date..end_date).paginate(page: page, per_page: 20).order('date DESC') 
    end
    
    def self.count_search(start_date, end_date)
        select('sum(charges.price - items.cost) as total_profit, sum(items.cost) as total_cost, sum(items.price) as total_retail, sum(charges.price) as total_sell , count(*) as total_quantity').joins(:sale, :item).where("sales.date" => start_date..end_date).order('date DESC') 
    end
    
    def self.to_csv(start_date, end_date, options = {})
      sales = select('sales.id as id, sales.date as date, items.name as name, items.price as retail_price, items.cost as cost, charges.price as sell_price, (charges.price - items.cost) as profit').joins(:sale, :item).where("sales.date" => start_date..end_date)
      CSV.generate(options) do |csv|
        csv << ['Venta No.' , 'Fecha' , 'Item' , 'Precio sugerido' , 'Precio de venta' , 'Costo' , 'Utilidad']
        sales.each do |sale|
          csv << [sale.id, sale.date, sale.name, sale.retail_price, sale.sell_price, sale.cost, sale.profit]
        end
      end
    end

    
    def item_name
      item.try(:name)
    end

    def item_name=(name)
      self.item = Item.find_by(name: name).where("stock > 0").order(:name) if name.present?
    end

end
