class BattleResultsController < ApplicationController
  include MyUtility
  before_action :set_battle_result, only: [:show, :edit, :update, :destroy]

  # GET /battle_results
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = BattleResult.distinct.notnil().includes([left_party_info: [party_members: :pc_name]], [right_party_info: [party_members: :pc_name]], :enemy_party_name)
    @count = @pre_search.ransack(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @battle_results = @search.result.per(50)
  end

  # GET /battle_results/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).ransack(params[:q]).result.pluck('parties.p_no').join('/')
  end

  # GET /battle_results/json
  def json
    index
    render json: @pre_search.ransack(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        left_party_info: {
          except: [:id, :result_no, :generate_no, :party_type, :created_at, :updated_at],
          include: [
            {party_members: {
              only: [:pc_name, :p_no, :is_supporter],
              include: [
                pc_name: {only: [:name, :player]}
              ]
            }}
          ]
        },
        right_party_info: {
          except: [:id, :result_no, :generate_no, :party_type, :created_at, :updated_at],
          include: [
            {party_members: {
              only: [:pc_name, :p_no, :is_supporter],
              include: [
                pc_name: {only: [:name, :player]}
              ]
            }}
          ]
        },
        enemy_party_name: {only: :name}
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
    params_to_form(params, @form_params, column_name: "left_party_no", params_name: "left_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "right_party_no", params_name: "right_party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_no", params_name: "battle_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_result", params_name: "battle_result_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_party_name_id", params_name: "enemy_party_name_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_num", params_name: "enemy_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_names", params_name: "enemy_names_form", type: "concat")

    params_to_form(params, @form_params, column_name: "enemy_party_name_name", params_name: "enemy_party_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_p_no_or_right_party_info_party_members_p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "left_party_info_party_members_pc_name_name_or_right_party_info_party_members_pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "left_party_info_name_or_right_party_info_name", params_name: "party_name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "battle_type_normal",     value: 0},
                                          {params_name: "battle_type_practice",   value: 1},
                                          {params_name: "battle_type_rank",       value: 2},
                                          {params_name: "battle_type_pk",         value: 3},
                                          {params_name: "battle_type_reid",       value: 4},
                                          {params_name: "battle_type_convention", value: 5}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_eq_any",
                             checkboxes: [{params_name: "battle_result_left_win", value: 1},
                                          {params_name: "battle_result_draw", value: 0},
                                          {params_name: "battle_result_right_win", value: -1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_info_member_num_eq_any",
                             checkboxes: [{params_name: "member_num_1", value: 1},
                                          {params_name: "member_num_2", value: 2},
                                          {params_name: "member_num_3", value: 3},
                                          {params_name: "member_num_4", value: 4}])

    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_info_attacker_num_eq_any",
                             checkboxes: [{params_name: "attacker_num_1", value: 1},
                                          {params_name: "attacker_num_2", value: 2},
                                          {params_name: "attacker_num_3", value: 3},
                                          {params_name: "attacker_num_4", value: 4}])

    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_info_supporter_num_eq_any",
                             checkboxes: [{params_name: "supporter_num_1", value: 1},
                                          {params_name: "supporter_num_2", value: 2},
                                          {params_name: "supporter_num_3", value: 3},
                                          {params_name: "supporter_num_4", value: 4}])

    checkbox_params_set_query_any(params, @form_params, query_name: "right_party_info_member_num_or_enemy_num_eq_any",
                             checkboxes: [{params_name: "right_member_num_1", value: 1},
                                          {params_name: "right_member_num_2", value: 2},
                                          {params_name: "right_member_num_3", value: 3},
                                          {params_name: "right_member_num_4", value: 4}])

    checkbox_params_set_query_any(params, @form_params, query_name: "right_party_info_attacker_num_or_enemy_num_eq_any",
                             checkboxes: [{params_name: "right_attacker_num_1", value: 1},
                                          {params_name: "right_attacker_num_2", value: 2},
                                          {params_name: "right_attacker_num_3", value: 3},
                                          {params_name: "right_attacker_num_4", value: 4}])

    checkbox_params_set_query_any(params, @form_params, query_name: "right_party_info_supporter_num_eq_any",
                             checkboxes: [{params_name: "right_supporter_num_1", value: 1},
                                          {params_name: "right_supporter_num_2", value: 2},
                                          {params_name: "right_supporter_num_3", value: 3},
                                          {params_name: "right_supporter_num_4", value: 4}])

    checkbox_params_set_query_any(params, @form_params, query_name: "left_party_info_pk_type_or_right_party_info_pk_type_eq_any",
                             checkboxes: [
                                          {params_name: "pk_type_fallen",            value: 1},
                                          {params_name: "pk_type_pk",                value: 2},
                                          {params_name: "pk_type_resistance",        value: 3}])

    toggle_params_to_variable(params, @form_params, params_name: "show_party_name")
    toggle_params_to_variable(params, @form_params, params_name: "show_pk_type")
    toggle_params_to_variable(params, @form_params, params_name: "show_right_serach")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_result
      @battle_result = BattleResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_result_params
      params.require(:battle_result).permit(:result_no, :generate_no, :previous_result_no, :previous_generate_no, :left_party_no, :right_party_no, :battle_no, :battle_type, :battle_result, :enemy_party_name_id, :enemy_num, :enemy_names)
    end
end
