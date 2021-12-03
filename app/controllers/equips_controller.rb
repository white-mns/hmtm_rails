class EquipsController < ApplicationController
  include MyUtility
  before_action :set_equip, only: [:show, :edit, :update, :destroy]

  # GET /equips
  def index
    resultno_set
    placeholder_set
    param_set

    @count = Equip.notnil().includes(:pc_name, :profile).search(params[:q]).result.hit_count()
    @search = Equip.notnil().includes(:pc_name, :profile).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @equips = @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "equip_no", params_name: "equip_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "range", params_name: "range_form", type: "number")
    params_to_form(params, @form_params, column_name: "strength_1", params_name: "strength_1_form", type: "number")
    params_to_form(params, @form_params, column_name: "strength_2", params_name: "strength_2_form", type: "number")
    params_to_form(params, @form_params, column_name: "note", params_name: "note_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "equip_no_eq_any",
                             checkboxes: [{params_name: "equip_weapon",      value: 0, first_checked: true},
                                          {params_name: "equip_guard",       value: 1, first_checked: true},
                                          {params_name: "equip_decoration" , value: 2, first_checked: true}])

    checkbox_params_set_query_any(params, @form_params, query_name: "profile_subject_id_eq_any",
                             checkboxes: [{params_name: "subject_magic", value: 0, first_checked: true},
                                          {params_name: "subject_martial" , value: 1, first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_profile")
  end

  # GET /equip/graphs
  def graphs
    index
    @library_param = {
      backgroundColor: "#3a313a",
      vAxis: { textStyle: { color: "#fff"}, titleTextStyle: {color: "#fff"} },
      hAxis: { textStyle: { color: "#fff"}, titleTextStyle: {color: "#fff"} },
      legend: {textStyle: {color: "#fff"}}
    }
  end

  # GET /equips/1
  #def show
  #end

  # GET /equips/new
  #def new
  #  @equip = Equip.new
  #end

  # GET /equips/1/edit
  #def edit
  #end

  # POST /equips
  #def create
  #  @equip = Equip.new(equip_params)

  #  if @equip.save
  #    redirect_to @equip, notice: "Equip was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /equips/1
  #def update
  #  if @equip.update(equip_params)
  #    redirect_to @equip, notice: "Equip was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /equips/1
  #def destroy
  #  @equip.destroy
  #  redirect_to equips_url, notice: "Equip was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equip
      @equip = Equip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def equip_params
      params.require(:equip).permit(:result_no, :generate_no, :p_no, :equip_no, :name, :range, :strength_1, :strength_2, :note)
    end
end
