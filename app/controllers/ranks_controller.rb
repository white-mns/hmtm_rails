class RanksController < ApplicationController
  include MyUtility
  before_action :set_rank, only: [:show, :edit, :update, :destroy]

  # GET /ranks
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = Rank.notnil().includes(:pc_name, :profile, :status).joins(:status)
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @ranks = @search.result.per(50)
  end

  # GET /ranks/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /ranks/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
    include: [
      {pc_name: {only: [:name, :player]}},
      {profile: {only: [:subject_id]}},
      {status: {only: [],
        include: [
          {rank: {only: :name}}
        ]
        }
      }
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
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "rp", params_name: "rp_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_match_num", params_name: "total_match_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_win_num", params_name: "total_win_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_draw_num", params_name: "total_draw_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_lose_num", params_name: "total_lose_num_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "profile_subject_id_eq_any",
                             checkboxes: [{params_name: "subject_magic", value: 0, first_checked: true},
                                          {params_name: "subject_martial" , value: 1, first_checked: true}])

    params_to_form(params, @form_params, column_name: "status_rank_name", params_name: "rank_form", type: "text")

    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
    toggle_params_to_variable(params, @form_params, params_name: "show_draw_lose")
    toggle_params_to_variable(params, @form_params, params_name: "show_rank", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_profile")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank
      @rank = Rank.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rank_params
      params.require(:rank).permit(:result_no, :generate_no, :p_no, :rp, :total_match_num, :total_win_num, :total_draw_num, :total_lose_num)
    end
end
