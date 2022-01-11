class SpellsController < ApplicationController
  include MyUtility
  before_action :set_spell, only: [:show, :edit, :update, :destroy]

  # GET /spells
  def index
    resultno_set
    placeholder_set
    param_set
    spell_data_set
    tg_data_set

    @count =  Spell.notnil().includes(:pc_name, :spell, :timing).search(params[:q]).result.hit_count()
    @search = Spell.notnil().includes(:pc_name, :spell, :timing).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @spells = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "s_no", params_name: "s_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "sp", params_name: "sp_form", type: "number")
    params_to_form(params, @form_params, column_name: "power", params_name: "power_form", type: "number")
    params_to_form(params, @form_params, column_name: "hit", params_name: "hit_form", type: "number")
    params_to_form(params, @form_params, column_name: "range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "timing_id", params_name: "timing_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "spell_id", params_name: "spell_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "gems", params_name: "gems_form", type: "concat")

    params_to_form(params, @form_params, column_name: "spell_name", params_name: "spell_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_text", params_name: "spell_text_form", type: "text")
    params_to_form(params, @form_params, column_name: "spell_class_data_name", params_name: "spell_class_form", type: "text")

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "timing_id_eq_any",
                             checkboxes: [{params_name: "timing_active",   value: proper_name["アクティブ"]},
                                          {params_name: "timing_counter" , value: proper_name["カウンター"]}])

    checkbox_params_set_query_any(params, @form_params, query_name: "spell_class_id_eq_any",
                             checkboxes: [{params_name: "class_approach",   value: proper_name["近接"]},
                                          {params_name: "class_gunshot" ,   value: proper_name["射撃"]},
                                          {params_name: "class_defense" ,   value: proper_name["防補"]},
                                          {params_name: "class_heal" ,      value: proper_name["回復"]},
                                          {params_name: "class_abnormal" ,  value: proper_name["異常"]},
                                          {params_name: "class_summon" ,    value: proper_name["召喚"]},
                                          {params_name: "class_synthesis" , value: proper_name["合成"]}])

    toggle_params_to_variable(params, @form_params, params_name: "show_spell_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_spell_text")
  end
  # GET /spells/1
  #def show
  #end

  # GET /spells/new
  #def new
  #  @spell = Spell.new
  #end

  # GET /spells/1/edit
  #def edit
  #end

  # POST /spells
  #def create
  #  @spell = Spell.new(spell_params)

  #  if @spell.save
  #    redirect_to @spell, notice: "Spell was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /spells/1
  #def update
  #  if @spell.update(spell_params)
  #    redirect_to @spell, notice: "Spell was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /spells/1
  #def destroy
  #  @spell.destroy
  #  redirect_to spells_url, notice: "Spell was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spell
      @spell = Spell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spell_params
      params.require(:spell).permit(:result_no, :generate_no, :p_no, :s_no, :name, :sp, :power, :hit, :range, :timing_id, :spell_id, :gems)
    end
end
