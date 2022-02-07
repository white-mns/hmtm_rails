class SpellDataController < ApplicationController
  include MyUtility
  before_action :set_spell_datum, only: [:show, :edit, :update, :destroy]

  # GET /spell_data
  def index
    resultno_set
    placeholder_set
    param_set
    tg_data_set

    @pre_search = SpellDatum.includes(:element, :timing, :class_data).where(spell_id: 1..Float::INFINITY)
    @count =  @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @spell_data = @search.result.per(50)
  end

  # GET /spell_data/pno_text
  def pno_text
    index
    render plain: ""
  end

  # GET /spell_data/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {element: {only: :name}},
        {timing: {only: :name}},
        {class_data: {only: :name}}
      ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)

    params_to_form(params, @form_params, column_name: "spell_id", params_name: "spell_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "element_id", params_name: "element_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "text", params_name: "text_form", type: "text")
    params_to_form(params, @form_params, column_name: "range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "power", params_name: "power_form", type: "number")
    params_to_form(params, @form_params, column_name: "hit", params_name: "hit_form", type: "number")
    params_to_form(params, @form_params, column_name: "timing_id", params_name: "timing_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "class_id", params_name: "class_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "gems", params_name: "gems_form", type: "concat")

    params_to_form(params, @form_params, column_name: "element_name", params_name: "element_form", type: "text")
    params_to_form(params, @form_params, column_name: "timing_name", params_name: "timing_form", type: "text")
    params_to_form(params, @form_params, column_name: "class_data_name", params_name: "class_form", type: "text")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "element_id_eq_any",
                             checkboxes: [{params_name: "element_none",   value: proper_name["無"]},
                                          {params_name: "element_fire" ,  value: proper_name["火"]},
                                          {params_name: "element_water" , value: proper_name["水"]},
                                          {params_name: "element_air" ,   value: proper_name["風"]},
                                          {params_name: "element_earth" , value: proper_name["地"]},
                                          {params_name: "element_light" , value: proper_name["光"]},
                                          {params_name: "element_dark" ,  value: proper_name["闇"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "timing_id_eq_any",
                             checkboxes: [{params_name: "timing_active",   value: proper_name["A"]},
                                          {params_name: "timing_counter" , value: proper_name["C"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "class_id_eq_any",
                             checkboxes: [{params_name: "class_approach",   value: proper_name["近接"]},
                                          {params_name: "class_gunshot" ,   value: proper_name["射撃"]},
                                          {params_name: "class_defense" ,   value: proper_name["防補"]},
                                          {params_name: "class_heal" ,      value: proper_name["回復"]},
                                          {params_name: "class_abnormal" ,  value: proper_name["異常"]},
                                          {params_name: "class_summon" ,    value: proper_name["召喚"]},
                                          {params_name: "class_synthesis" , value: proper_name["合成"]}])

    gems_first_checked = (params["tg_all"]) ? false : true
    checkbox_params_set_query_single(params, @form_params, query_name: "gems_blank",
                             checkbox: {params_name: "no_gems",   value: true, first_checked: gems_first_checked})

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  # GET /spell_data/1
  #def show
  #end

  # GET /spell_data/new
  #def new
  #  @spell_datum = SpellDatum.new
  #end

  # GET /spell_data/1/edit
  #def edit
  #end

  # POST /spell_data
  #def create
  #  @spell_datum = SpellDatum.new(spell_datum_params)

  #  if @spell_datum.save
  #    redirect_to @spell_datum, notice: "Spell datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /spell_data/1
  #def update
  #  if @spell_datum.update(spell_datum_params)
  #    redirect_to @spell_datum, notice: "Spell datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /spell_data/1
  #def destroy
  #  @spell_datum.destroy
  #  redirect_to spell_data_url, notice: "Spell datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spell_datum
      @spell_datum = SpellDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spell_datum_params
      params.require(:spell_datum).permit(:spell_id, :name, :sp, :element_id, :text, :range, :power, :hit, :timing_id, :class_id)
    end
end
