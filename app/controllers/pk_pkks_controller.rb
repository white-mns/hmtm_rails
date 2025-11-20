class PkPkksController < ApplicationController
  include MyUtility
  before_action :set_pk_pkk, only: [:show, :edit, :update, :destroy]

  # GET /pk_pkks
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = PkPkk.notnil().includes(:pc_name, :status)
    @count = @pre_search.ransack(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).ransack(params[:q])
    @search.sorts = "status_pp desc" if @search.sorts.empty?
    @pk_pkks = @search.result.per(50)
  end

  # GET /pk_pkks/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).ransack(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /pk_pkks/json
  def json
    index
    render json: @pre_search.ransack(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}},
        {status: {only: [:pp]}}
      ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",@latest_result)
      params["last_announcement_result_no_form"] ||= "1~"
      params["pvp_type"] ||= "2"
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "pvp_type", params_name: "pvp_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_match_num", params_name: "total_match_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_battle_num", params_name: "total_battle_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_cheer_num", params_name: "total_cheer_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_win_num", params_name: "total_win_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_draw_num", params_name: "total_draw_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_lose_num", params_name: "total_lose_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "total_income", params_name: "total_income_form", type: "number")
    params_to_form(params, @form_params, column_name: "last_announcement_result_no", params_name: "last_announcement_result_no_form", type: "number")

    params_to_form(params, @form_params, column_name: "status_pp", params_name: "pp_form", type: "text")

    @form_params["pvp_type"]    = params["pvp_type"]
    params[:q]["pvp_type_eq"] = params["pvp_type"]

    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
    toggle_params_to_variable(params, @form_params, params_name: "show_draw_lose", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_announce")
    toggle_params_to_variable(params, @form_params, params_name: "show_profile")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pk_pkk
      @pk_pkk = PkPkk.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pk_pkk_params
      params.require(:pk_pkk).permit(:result_no, :generate_no, :p_no, :pvp_type, :total_match_num, :total_battle_num, :total_cheer_num, :total_win_num, :total_draw_num, :total_lose_num, :total_income, :last_announcement_result_no)
    end
end
