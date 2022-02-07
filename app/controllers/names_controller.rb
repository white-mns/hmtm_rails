class NamesController < ApplicationController
  include MyUtility
  before_action :set_name, only: [:show, :edit, :update, :destroy]

  # GET /names
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = Name.notnil()
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @names = @search.result.per(50)
  end

  # GET /names/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /names/json
  def json
    index
    render json: @pre_search.page(params[:page]).result.per(100000).to_json(except: [:id, :created_at, :updated_at])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "player", params_name: "player_form", type: "text")
  end
  # GET /names/1
  #def show
  #end

  # GET /names/new
  #def new
  #  @name = Name.new
  #end

  # GET /names/1/edit
  #def edit
  #end

  # POST /names
  #def create
  #  @name = Name.new(name_params)

  #  if @name.save
  #    redirect_to @name, notice: "Name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /names/1
  #def update
  #  if @name.update(name_params)
  #    redirect_to @name, notice: "Name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /names/1
  #def destroy
  #  @name.destroy
  #  redirect_to names_url, notice: "Name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_name
      @name = Name.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def name_params
      params.require(:name).permit(:result_no, :generate_no, :p_no, :name, :player)
    end
end
