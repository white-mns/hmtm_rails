class ObsolescencesController < ApplicationController
  include MyUtility
  before_action :set_obsolescence, only: [:show, :edit, :update, :destroy]

  # GET /obsolescences
  def index
    resultno_set
    placeholder_set
    param_set
    tg_data_set

    @pre_search = Obsolescence.notnil()
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @obsolescences = @search.result.per(50)
  end

  # GET /obsolescences/json_pno
  def json_pno
    index
    render json: []
  end

  # GET /obsolescences/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at])
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
    params_to_form(params, @form_params, column_name: "gems", params_name: "gems_form", type: "concat")
    params_to_form(params, @form_params, column_name: "gem_num", params_name: "gem_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "obsolescence", params_name: "obsolescence_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "gem_num_eq_any",
                             checkboxes: [{params_name: "gem_num_1", value: 1, first_checked: true},
                                          {params_name: "gem_num_2", value: 2},
                                          {params_name: "gem_num_3", value: 3}])

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end
  # GET /obsolescences/1
  #def show
  #end

  # GET /obsolescences/new
  #def new
  #  @obsolescence = Obsolescence.new
  #end

  # GET /obsolescences/1/edit
  #def edit
  #end

  # POST /obsolescences
  #def create
  #  @obsolescence = Obsolescence.new(obsolescence_params)

  #  if @obsolescence.save
  #    redirect_to @obsolescence, notice: "Obsolescence was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /obsolescences/1
  #def update
  #  if @obsolescence.update(obsolescence_params)
  #    redirect_to @obsolescence, notice: "Obsolescence was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /obsolescences/1
  #def destroy
  #  @obsolescence.destroy
  #  redirect_to obsolescences_url, notice: "Obsolescence was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obsolescence
      @obsolescence = Obsolescence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def obsolescence_params
      params.require(:obsolescence).permit(:result_no, :generate_no, :gems, :gem_num, :obsolescence)
    end
end
