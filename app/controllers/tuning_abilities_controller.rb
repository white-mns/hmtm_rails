class TuningAbilitiesController < ApplicationController
  include MyUtility
  before_action :set_tuning_ability, only: [:show, :edit, :update, :destroy]

  # GET /tuning_abilities
  def index
    resultno_set
    placeholder_set
    param_set
    spell_data_set

    @pre_search = TuningAbility.notnil().includes(:pc_name, :profile, [spell: [:orig_spell, :timing, :element]], :merit, :demerit)
    @count = @pre_search.ransack(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @tuning_abilities = @search.result.per(50)
  end

  # GET /tuning_abilities/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).ransack(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /tuning_abilities/json
  def json
    index
    render json: @pre_search.ransack(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
    include: [
      {pc_name: {only: [:name, :player]}},
      {profile: {only: [:subject_id]}},
      {spell: {
        only: [:name, :power, :hit, :range, :gems, :tuned_text],
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
      }},
      {merit: {only: :name}},
      {demerit: {only: :name}}
    ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",@latest_result)
    end

    if params["name_form"]
      params["name_form"] = utf8mb4_encode_numericentity(params["name_form"])
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "s_no", params_name: "s_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "merit_id", params_name: "merit_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "merit_value", params_name: "merit_value_form", type: "number")
    params_to_form(params, @form_params, column_name: "demerit_id", params_name: "demerit_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "demerit_value", params_name: "demerit_value_form", type: "number")

    params_to_form(params, @form_params, column_name: "merit_name", params_name: "merit_form", type: "text")
    params_to_form(params, @form_params, column_name: "demerit_name", params_name: "demerit_form", type: "text")

    params_to_form(params, @form_params, column_name: "spell_sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_power", params_name: "power_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_hit", params_name: "hit_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_range", params_name: "range_form", type: "number")

    params_to_form(params, @form_params, column_name: "spell_orig_spell_name", params_name: "spell_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_orig_spell_text", params_name: "spell_text_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_orig_spell_class_data_name", params_name: "spell_class_form", type: "text")

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

    checkbox_params_set_query_any(params, @form_params, query_name: "spell_spell_class_id_eq_any",
                             checkboxes: [{params_name: "class_approach",   value: proper_name["近接"]},
                                          {params_name: "class_gunshot" ,   value: proper_name["射撃"]},
                                          {params_name: "class_defense" ,   value: proper_name["防補"]},
                                          {params_name: "class_heal" ,      value: proper_name["回復"]},
                                          {params_name: "class_abnormal" ,  value: proper_name["異常"]},
                                          {params_name: "class_summon" ,    value: proper_name["召喚"]},
                                          {params_name: "class_synthesis" , value: proper_name["合成"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "profile_subject_id_eq_any",
                             checkboxes: [{params_name: "subject_magic", value: 0, first_checked: true},
                                          {params_name: "subject_martial" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_spell_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_spell_data")
    toggle_params_to_variable(params, @form_params, params_name: "show_spell_text")
    toggle_params_to_variable(params, @form_params, params_name: "show_profile")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tuning_ability
      @tuning_ability = TuningAbility.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tuning_ability_params
      params.require(:tuning_ability).permit(:result_no, :generate_no, :p_no, :s_no, :name, :merit_id, :merit_value, :demerit_id, :demerit_value)
    end
end
