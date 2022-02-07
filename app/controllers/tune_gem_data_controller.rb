class TuneGemDataController < ApplicationController
  include MyUtility
  before_action :set_tune_gem_datum, only: [:show, :edit, :update, :destroy]

  # GET /tune_gem_data
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = TuneGemDatum.includes(:type).where(tg_id: 1..Float::INFINITY)
    @count =  @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @tune_gem_data = @search.result.per(50)
  end

  # GET /tune_gem_data/json_pno
  def json_pno
    index
    render json: []
  end

  # GET /spells/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {type: {only: :name}}
      ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)

    params_to_form(params, @form_params, column_name: "tg_id", params_name: "tg_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "sp", params_name: "sp_form", type: "text")
    params_to_form(params, @form_params, column_name: "type_id", params_name: "type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "text", params_name: "text_form", type: "text")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "type_id_eq_any",
                             checkboxes: [{params_name: "type_element_change",     value: proper_name["属性変化"]},
                                          {params_name: "type_range_change" ,      value: proper_name["射程変化"]},
                                          {params_name: "type_attack_change" ,     value: proper_name["攻撃変化"]},
                                          {params_name: "type_timing_change" ,     value: proper_name["タイミング"]},
                                          {params_name: "type_abnormal_addition" , value: proper_name["異常付与"]},
                                          {params_name: "type_ability_change" ,    value: proper_name["能力変化"]}])

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end
  # GET /tune_gem_data/1
  #def show
  #end

  # GET /tune_gem_data/new
  #def new
  #  @tune_gem_datum = TuneGemDatum.new
  #end

  # GET /tune_gem_data/1/edit
  #def edit
  #end

  # POST /tune_gem_data
  #def create
  #  @tune_gem_datum = TuneGemDatum.new(tune_gem_datum_params)

  #  if @tune_gem_datum.save
  #    redirect_to @tune_gem_datum, notice: "Tune gem datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /tune_gem_data/1
  #def update
  #  if @tune_gem_datum.update(tune_gem_datum_params)
  #    redirect_to @tune_gem_datum, notice: "Tune gem datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /tune_gem_data/1
  #def destroy
  #  @tune_gem_datum.destroy
  #  redirect_to tune_gem_data_url, notice: "Tune gem datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tune_gem_datum
      @tune_gem_datum = TuneGemDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tune_gem_datum_params
      params.require(:tune_gem_datum).permit(:tg_id, :name, :sp, :type_id, :text)
    end
end
