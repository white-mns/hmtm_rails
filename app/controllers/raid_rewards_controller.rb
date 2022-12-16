class RaidRewardsController < ApplicationController
  include MyUtility
  before_action :set_raid_reward, only: [:show, :edit, :update, :destroy]

  # GET /raid_rewards
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = RaidReward.notnil().includes(:pc_name, [party: :party_info])
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "sc desc" if @search.sorts.empty?
    @raid_rewards = @search.result.per(50)
  end

  # GET /raid_rewards/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /raid_rewards/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}},
        {party: { only: [],
          include: [
            party_info: {only: [:name]}
          ]
        }}
      ])
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",RaidReward.maximum("result_no"))
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "sc", params_name: "sc_form", type: "number")
    params_to_form(params, @form_params, column_name: "tp", params_name: "tp_form", type: "number")
    params_to_form(params, @form_params, column_name: "rp", params_name: "rp_form", type: "number")

    params_to_form(params, @form_params, column_name: "party_party_info_name", params_name: "party_name_form", type: "text")

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raid_reward
      @raid_reward = RaidReward.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def raid_reward_params
      params.require(:raid_reward).permit(:result_no, :generate_no, :p_no, :sc, :tp, :rp)
    end
end
