class Item < ApplicationRecord
    require 'csv'
    
    has_many :charges, inverse_of: :item
    mount_uploader :image, ImageUploader
    SIZE_OPTIONS=[  "N.A", "1","1.5","2"," 2.5","3"," 3.5",
                    "4","4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5"]
    GENDER_OPTIONS = ["N.A", "Hombre","Mujer","Niño"]
    
    def code_name
        self.code + ' - ' + self.brand + ' - ' + self.name
    end
    
    def self.available_stock
        self.where("stock > 0").order(:name)
    end
    
    def self.count_search(term, include_0)
      if include_0.present? and term.present?
            where('name LIKE ? or brand LIKE ? or code LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%").count
      elsif include_0.blank? and term.blank?
            where('stock > 0').count
      elsif include_0.blank? and term.present?
            where('(name LIKE ? or brand LIKE ? or code LIKE ?) and stock > 0', "%#{term}%", "%#{term}%", "%#{term}%").count
      else
            count
      end
    end
    
    def self.search(term, page, include_0)
      if include_0.present? and term.present?
            where('name LIKE ? or brand LIKE ? or code LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%").paginate(page: page, per_page: 20).order('id DESC')
      elsif include_0.blank? and term.blank?
            where('stock > 0').paginate(page: page, per_page: 20).order('id DESC')
      elsif include_0.blank? and term.present?
            where('(name LIKE ? or brand LIKE ? or code LIKE ?) and stock > 0', "%#{term}%", "%#{term}%", "%#{term}%").paginate(page: page, per_page: 20).order('id DESC')
      else
            paginate(page: page, per_page: 20).order('id DESC') 
      end
    end
    
    
    def self.to_csv(term, include_0, options = {})
      if include_0.present? and term.present?
            items = where('name LIKE ? or brand LIKE ? or code LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%").all
      elsif include_0.blank? and term.blank?
            items = where('stock > 0').all
      elsif include_0.blank? and term.present?
            items = where('(name LIKE ? or brand LIKE ? or code LIKE ?) and stock > 0', "%#{term}%", "%#{term}%", "%#{term}%").all
      else
            items = all
      end
      CSV.generate(options) do |csv|
        csv << ['Código' , 'Marca' , 'Nombre' , 'Proveedor', 'Talla', 'Genero','Precio sugerido' , 'Costo' , 'Cantidad']
        items.each do |item|
          csv << [item.code, item.brand, item.name, item.supplier, item.size, item.gender, item.price, item.cost, item.stock]
        end
      end
    end
end
