class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  append_before_action  only: [:edit, :update, :destroy]do 
    unless current_user && current_user.admin?
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to items_path 
    end
  end

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.search(params[:term], params[:page])
    @sales_found =  Sale.count_search(params[:term])
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale = current_user.sales.build
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale = current_user.sales.build(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:date, :customer_name, :customer_identification, :customer_phone, :total_charge, :number_of_items, :payment_method, :comments, :user_id, charges_attributes: [:id, :item_id, :price, :_destroy])
    end
end
