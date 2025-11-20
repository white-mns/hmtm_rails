class TeachSpellsController < ApplicationController
  include MyUtility
  before_action :set_teach_spell, only: [:show, :edit, :update, :destroy]

  # GET /teach_spells
  def index
    resultno_set
    placeholder_set
    param_set
    spell_data_set
    tg_data_set

    @pre_search = TeachSpell.notnil().includes(:pc_name, :spell)
    @count = @pre_search.ransack(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @teach_spells = @search.result.per(50)
  end

  # GET /teach_spells/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).ransack(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /teach_spells/json
  def json
    index
    render json: @pre_search.ransack(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}},
        {spell:
          {expect: [:id, :spell_id, :created_at, :updated_at],
          include: [
            {orig_spell: {
              except: [:id, :spell_id, :created_at, :updated_at],
              include: [
                {element: {only: :name}},
                {timing: {only: :name}},
                {class_data: {only: :name}}
              ]
            }},
            {timing: {only: :name}},
            {element: {only: :name}}
          ]
        }}
      ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "previous_result_no", params_name: "previous_result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "previous_generate_no", params_name: "previous_generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "s_no", params_name: "s_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "num", params_name: "num_form", type: "number")
    params_to_form(params, @form_params, column_name: "op", params_name: "op_form", type: "number")

    params_to_form(params, @form_params, column_name: "spell_name", params_name: "orig_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_power", params_name: "power_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_hit", params_name: "hit_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_timing_id", params_name: "timing_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_spell_id", params_name: "spell_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_gems", params_name: "gems_form", type: "concat")
    params_to_form(params, @form_params, column_name: "spell_obsolescence", params_name: "obsolescence_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_tuned_text", params_name: "tuned_text_form", type: "text")

    params_to_form(params, @form_params, column_name: "spell_orig_spell_name", params_name: "spell_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_orig_spell_class_data_name", params_name: "spell_class_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_orig_spell_base_spell_name", params_name: "base_spell_form", type: "text")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "spell_timing_id_eq_any",
                             checkboxes: [{params_name: "timing_active",   value: proper_name["アクティブ"]},
                                          {params_name: "timing_counter" , value: proper_name["カウンター"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "spell_element_id_eq_any",
                             checkboxes: [{params_name: "element_none",   value: proper_name["無"]},
                                          {params_name: "element_fire" ,  value: proper_name["火"]},
                                          {params_name: "element_water" , value: proper_name["水"]},
                                          {params_name: "element_air" ,   value: proper_name["風"]},
                                          {params_name: "element_earth" , value: proper_name["地"]},
                                          {params_name: "element_light" , value: proper_name["光"]},
                                          {params_name: "element_dark" ,  value: proper_name["闇"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "spell_orig_spell_class_id_eq_any",
                             checkboxes: [{params_name: "class_approach",   value: proper_name["近接"]},
                                          {params_name: "class_gunshot" ,   value: proper_name["射撃"]},
                                          {params_name: "class_defense" ,   value: proper_name["防補"]},
                                          {params_name: "class_heal" ,      value: proper_name["回復"]},
                                          {params_name: "class_abnormal" ,  value: proper_name["異常"]},
                                          {params_name: "class_summon" ,    value: proper_name["召喚"]},
                                          {params_name: "class_synthesis" , value: proper_name["合成"]}])

    toggle_params_to_variable(params, @form_params, params_name: "show_spell_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_spell_text")
    toggle_params_to_variable(params, @form_params, params_name: "show_orig_spell", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_pc_name")
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teach_spell
      @teach_spell = TeachSpell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def teach_spell_params
      params.require(:teach_spell).permit(:result_no, :generate_no, :previous_result_no, :previous_generate_no, :p_no, :s_no, :num, :op)
    end
end
