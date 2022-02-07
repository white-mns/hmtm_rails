class StatusesController < ApplicationController
  include MyUtility
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = Status.notnil().includes(:pc_name, :rank, :profile)
    @count =  @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @statuses = @search.result.per(50)
  end

  # GET /statuses/pno_text
  def pno_text
    index
    render plain: @pre_search.group(:p_no).search(params[:q]).result.pluck(:p_no).join('/')
  end

  # GET /statuses/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}},
        {profile: {except: [:id, :result_no, :generate_no, :created_at, :updated_at]}},
        {rank: {only: :name}}
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
    params_to_form(params, @form_params, column_name: "mhp", params_name: "mhp_form", type: "number")
    params_to_form(params, @form_params, column_name: "mmp", params_name: "mmp_form", type: "number")
    params_to_form(params, @form_params, column_name: "msp", params_name: "msp_form", type: "number")
    params_to_form(params, @form_params, column_name: "cp", params_name: "cp_form", type: "number")
    params_to_form(params, @form_params, column_name: "str", params_name: "str_form", type: "number")
    params_to_form(params, @form_params, column_name: "def", params_name: "def_form", type: "number")
    params_to_form(params, @form_params, column_name: "tec", params_name: "tec_form", type: "number")
    params_to_form(params, @form_params, column_name: "eva", params_name: "eva_form", type: "number")
    params_to_form(params, @form_params, column_name: "agi", params_name: "agi_form", type: "number")
    params_to_form(params, @form_params, column_name: "luk", params_name: "luk_form", type: "number")
    params_to_form(params, @form_params, column_name: "cha", params_name: "cha_form", type: "number")
    params_to_form(params, @form_params, column_name: "rank_id", params_name: "rank_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "tp", params_name: "tp_form", type: "number")
    params_to_form(params, @form_params, column_name: "ap", params_name: "ap_form", type: "number")
    params_to_form(params, @form_params, column_name: "pp", params_name: "pp_form", type: "number")
    params_to_form(params, @form_params, column_name: "sc", params_name: "sc_form", type: "number")

    params_to_form(params, @form_params, column_name: "rank_name", params_name: "rank_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "profile_subject_id_eq_any",
                             checkboxes: [{params_name: "subject_magic", value: 0, first_checked: true},
                                          {params_name: "subject_martial" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_profile")
  end
  # GET /statuses/1
  #def show
  #end

  # GET /statuses/new
  #def new
  #  @status = Status.new
  #end

  # GET /statuses/1/edit
  #def edit
  #end

  # POST /statuses
  #def create
  #  @status = Status.new(status_params)

  #  if @status.save
  #    redirect_to @status, notice: "Status was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /statuses/1
  #def update
  #  if @status.update(status_params)
  #    redirect_to @status, notice: "Status was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /statuses/1
  #def destroy
  #  @status.destroy
  #  redirect_to statuses_url, notice: "Status was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:result_no, :generate_no, :p_no, :mhp, :mmp, :msp, :cp, :str, :def, :tec, :eva, :agi, :luk, :cha, :rank_id, :tp, :ap, :pp, :sc)
    end
end
