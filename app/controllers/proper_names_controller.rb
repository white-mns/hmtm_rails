class ProperNamesController < ApplicationController
  include MyUtility
  before_action :set_proper_name, only: [:show, :edit, :update, :destroy]

  # GET /proper_names
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = ProperName
    @count = @pre_search.ransack(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @proper_names = @search.result.per(50)
  end

  # GET /proper_names/pno_text
  def pno_text
    index
    render plain: ""
  end

  # GET /proper_names/json
  def json
    index
    render json: @pre_search.ransack(params[:q]).result.to_json(except: [:id, :created_at, :updated_at])
  end

  def param_set
    @form_params = {}

    params_clean(params)

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "proper_id", params_name: "proper_id_form", type: "number")
  end

  # GET /proper_names/1
  #def show
  #end

  # GET /proper_names/new
  #def new
  #  @proper_name = ProperName.new
  #end

  # GET /proper_names/1/edit
  #def edit
  #end

  # POST /proper_names
  #def create
  #  @proper_name = ProperName.new(proper_name_params)

  #  if @proper_name.save
  #    redirect_to @proper_name, notice: "Proper name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /proper_names/1
  #def update
  #  if @proper_name.update(proper_name_params)
  #    redirect_to @proper_name, notice: "Proper name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /proper_names/1
  #def destroy
  #  @proper_name.destroy
  #  redirect_to proper_names_url, notice: "Proper name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proper_name
      @proper_name = ProperName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def proper_name_params
      params.require(:proper_name).permit(:proper_id, :name)
    end
end
