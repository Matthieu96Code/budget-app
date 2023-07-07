class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /operations or /operations.json
  def index
    @operations = current_user.operations.where(category_id: params[:category_id])
    @category_id = params[:category_id]
    @total_operation = @operations.sum(:amount)
  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @category_id = params[:category_id]
    @category = Category.find(@category_id)
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
  end

  def create
    category_ids = operation_params[:category_ids]
    category_ids.each do |category_id|
      @operation = Operation.new(operation_params.except(:category_ids))
      @operation.category_id = category_id
      
      @operation.author = current_user
      @operation.save
    end

    category_route = Category.find(category_ids.first) # Assuming only one category is selected
        
    respond_to do |format|
      if @operation.save
        format.html { redirect_to  category_operations_path(category_route), notice: "Operation was successfully created." }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to operation_url(@operation), notice: "Operation was successfully updated." }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to operations_url, notice: "Operation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:name, :amount, category_ids: [])#:category_id) 
    end
end
