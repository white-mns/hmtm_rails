class PartiesController < ApplicationController
  include MyUtility
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = Party.notnil().includes(:pc_name)
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @parties = @search.result.per(50)
  end

  # GET /parties/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /parties/json
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
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_type", params_name: "party_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_no", params_name: "party_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "is_supporter", params_name: "is_supporter_form", type: "number")

    checkbox_params_set_query_any(params, @form_params, query_name: "party_type_eq_any",
                             checkboxes: [{params_name: "party_type_normal",            value: 0},
                                          {params_name: "party_type_practice",          value: 1},
                                          {params_name: "party_type_rank",              value: 2},
                                          {params_name: "party_type_pk",                value: 3},
                                          {params_name: "party_type_reid",              value: 4},
                                          {params_name: "party_type_convention",        value: 5},
                                          {params_name: "party_type_normal_notice",     value: 10},
                                          {params_name: "party_type_practice_notice",   value: 11},
                                          {params_name: "party_type_rank_notice",       value: 12},
                                          {params_name: "party_type_pk_notice",         value: 13},
                                          {params_name: "party_type_reid_notice",       value: 14},
                                          {params_name: "party_type_convention_notice", value: 15}])

    checkbox_params_set_query_any(params, @form_params, query_name: "is_supporter_eq_any",
                             checkboxes: [{params_name: "is_attacker", value: 0},
                                          {params_name: "is_supporter", value: 1}])

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_params
      params.require(:party).permit(:result_no, :generate_no, :p_no, :party_type, :party_no, :is_supporter)
    end
end
