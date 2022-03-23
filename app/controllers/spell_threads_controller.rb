class SpellThreadsController < ApplicationController
  include MyUtility
  before_action :set_spell_thread, only: [:show, :edit, :update, :destroy]

  # GET /spell_threads
  def index
    resultno_set
    placeholder_set
    param_set
    spell_data_set
    tg_data_set

    @pre_search = SpellThread.distinct.notnil().includes(thread_members: :pc_name)
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @spell_threads = @search.result.per(50)
  end

  # GET /spell_threads/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck("spell_thread_members.p_no").join('/')
  end

  # GET /spell_threads/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at]).gsub("\\u003c","<").gsub("\\u003e",">").gsub(",","")
  end

  def param_set
    @form_params = {}

    @latest_result = Name.maximum("result_no")

    params_clean(params)
    unless params["is_form"]
      params["result_no_form"] ||= sprintf("%d",@latest_result)
      params["depth_form"] ||= "2~"
      params["thread_orig_spell"] ||= "on"
    end

    if params["thread_form"] then params["thread_form"] = utf8mb4_encode_numericentity(params["thread_form"]) end
    if params["thread_tg_form"] then params["thread_tg_form"] = utf8mb4_encode_numericentity(params["thread_tg_form"]) end
    if params["thread_orig_form"] then params["thread_orig_form"] = utf8mb4_encode_numericentity(params["thread_orig_form"]) end
    if params["thread_orig_tg_form"] then params["thread_orig_tg_form"] = utf8mb4_encode_numericentity(params["thread_orig_tg_form"]) end
    if params["thread_base_form"] then params["thread_base_form"] = utf8mb4_encode_numericentity(params["thread_base_form"]) end
    if params["thread_base_tg_form"] then params["thread_base_tg_form"] = utf8mb4_encode_numericentity(params["thread_base_tg_form"]) end

    params_to_form(params, @form_params, column_name: "result_no", params_name: "result_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "generate_no", params_name: "generate_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_type", params_name: "battle_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_no", params_name: "battle_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "turn", params_name: "turn_form", type: "number")
    params_to_form(params, @form_params, column_name: "thread_id", params_name: "thread_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "thread", params_name: "thread_form", type: "concat")
    params_to_form(params, @form_params, column_name: "thread_tg", params_name: "thread_tg_form", type: "concat")
    params_to_form(params, @form_params, column_name: "thread_orig", params_name: "thread_orig_form", type: "concat")
    params_to_form(params, @form_params, column_name: "thread_orig_tg", params_name: "thread_orig_tg_form", type: "concat")
    params_to_form(params, @form_params, column_name: "thread_base", params_name: "thread_base_form", type: "concat")
    params_to_form(params, @form_params, column_name: "thread_base_tg", params_name: "thread_base_tg_form", type: "concat")
    params_to_form(params, @form_params, column_name: "depth", params_name: "depth_form", type: "number")
    params_to_form(params, @form_params, column_name: "length", params_name: "length_form", type: "number")

    params_to_form(params, @form_params, column_name: "thread_members_pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "thread_members_p_no", params_name: "p_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "thread_members_name", params_name: "all_name_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_type_eq_any",
                             checkboxes: [{params_name: "battle_type_normal",            value: 0},
                                          {params_name: "battle_type_practice",          value: 1},
                                          {params_name: "battle_type_rank",              value: 2},
                                          {params_name: "battle_type_pk",                value: 3},
                                          {params_name: "battle_type_reid",              value: 4},
                                          {params_name: "battle_type_convention",        value: 5}])

    @form_params["show_tg"] = params["show_tg"]
    @form_params["thread_after_spell"] = params["thread_after_spell"]
    @form_params["thread_orig_spell"] = params["thread_orig_spell"]
    @form_params["thread_base_spell"] = params["thread_base_spell"]
    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spell_thread
      @spell_thread = SpellThread.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spell_thread_params
      params.require(:spell_thread).permit(:result_no, :generate_no, :battle_type, :battle_no, :turn, :thread_id, :thread, :thread_tg, :thread_orig, :thread_orig_tg, :thread_base, :thread_base_tg, :depth, :length)
    end
end
