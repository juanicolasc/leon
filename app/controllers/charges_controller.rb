class ChargesController < ApplicationController
  append_before_action do 
    unless current_user && current_user.admin?
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to items_path 
    end
  end
  # GET /charges
  # GET /charges.json
  def index
    @from = params[:from] ? params[:from] : Date.today.beginning_of_month
    @to = params[:to] ? params[:to] : @from.end_of_month
    @charges = Charge.search(params[:page], @from, @to)
    @charges_found = Charge.count_search(@from, @to)
    respond_to do |format|
      format.html
      format.csv { send_data Charge.to_csv(@from, @to, :col_sep => ";") }
    end
  end

end
