class SpellThreadMembersController < ApplicationController
  include MyUtility
  before_action :set_spell_thread_member, only: [:show, :edit, :update, :destroy]

  # GET /spell_thread_members
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = SpellThreadMember.notnil().includes(:pc_name)
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @spell_thread_members = @search.result.per(50)
  end

  # GET /spell_thread_members/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /spell_thread_members/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}}
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
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_no", params_name: "battle_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "turn", params_name: "turn_form", type: "number")
    params_to_form(params, @form_params, column_name: "thread_id", params_name: "thread_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "battle_type_normal",            value: 0},
                                          {params_name: "battle_type_practice",          value: 1},
                                          {params_name: "battle_type_rank",              value: 2},
                                          {params_name: "battle_type_pk",                value: 3},
                                          {params_name: "battle_type_raid",              value: 4},
                                          {params_name: "battle_type_convention",        value: 5}])

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spell_thread_member
      @spell_thread_member = SpellThreadMember.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spell_thread_member_params
      params.require(:spell_thread_member).permit(:result_no, :generate_no, :battle_type, :battle_no, :turn, :thread_id, :p_no, :name)
    end
end
