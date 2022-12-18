class BattleRankingsController < ApplicationController
  include MyUtility
  before_action :set_battle_ranking, only: [:show, :edit, :update, :destroy]

  # GET /battle_rankings
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = BattleRanking.notnil().includes(:pc_name, :profile, :abnormal_name)
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "value desc" if @search.sorts.empty?
    @battle_rankings = @search.result.per(50)
  end

  # GET /battle_rankings/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /battle_rankings/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}},
        {abnormal_name: {only: :name}}
      ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",RaidReward.maximum("result_no"))
      params["p_no_form"] ||= "1~5000"
      params["ranking_type"] ||= "0"
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")
    params_to_form(params, @form_params, column_name: "ranking_type", params_name: "ranking_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "value", params_name: "value_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_no", params_name: "battle_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "page_no", params_name: "page_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "turn", params_name: "turn_form", type: "number")
    params_to_form(params, @form_params, column_name: "thread_id", params_name: "thread_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "abnormal_type", params_name: "abnormal_type_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "battle_type_normal",     value: 0},
                                          {params_name: "battle_type_practice",   value: 1},
                                          {params_name: "battle_type_rank",       value: 2},
                                          {params_name: "battle_type_pk",         value: 3},
                                          {params_name: "battle_type_reid",       value: 4, first_checked: true},
                                          {params_name: "battle_type_convention", value: 5}])

    @form_params["ranking_type"]    = params["ranking_type"]
    params[:q]["ranking_type_eq"] = params["ranking_type"]

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_ranking
      @battle_ranking = BattleRanking.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_ranking_params
      params.require(:battle_ranking).permit(:result_no, :generate_no, :p_no, :name, :ranking_type, :value, :battle_type, :battle_no, :page_no, :turn, :thread_id, :abnormal_type)
    end
end
