class ProfilesController < ApplicationController
  include MyUtility
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  def index
    resultno_set
    placeholder_set
    param_set

    @pre_search = Profile.notnil().includes(:pc_name, :course)
    @count = @pre_search.search(params[:q]).result.hit_count()
    @search = @pre_search.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @profiles = @search.result.per(50)
  end

  # GET /profile/graphs
  def graphs
    index
    @library_param = {
      backgroundColor: "#252025",
      legend: {textStyle: {color: "#fff"}}
    }
  end

  # GET /profiles/json_pno
  def json_pno
    index
    render json: @pre_search.group(:p_no).search(params[:q]).result.to_json(only: :p_no)
  end

  # GET /profiles/json
  def json
    index
    render json: @pre_search.search(params[:q]).result.to_json(except: [:id, :created_at, :updated_at],
      include: [
        {pc_name: {only: [:name, :player]}},
        {course: {only: :name}}])
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
    params_to_form(params, @form_params, column_name: "title", params_name: "title_form", type: "text")
    params_to_form(params, @form_params, column_name: "nickname", params_name: "nickname_form", type: "text")
    params_to_form(params, @form_params, column_name: "subject_id", params_name: "subject_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "course_id", params_name: "course_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "species", params_name: "species_form", type: "text")
    params_to_form(params, @form_params, column_name: "sexuality", params_name: "sexuality_form", type: "text")
    params_to_form(params, @form_params, column_name: "age", params_name: "age_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "subject_id_eq_any",
                             checkboxes: [{params_name: "subject_magic", value: 0, first_checked: true},
                                          {params_name: "subject_martial" , value: 1, first_checked: true}])

    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    checkbox_params_set_query_any(params, @form_params, query_name: "course_id_eq_any",
                             checkboxes: [{params_name: "course_s", value: proper_name["初等部"], first_checked: true},
                                          {params_name: "course_c" , value: proper_name["中等部"], first_checked: true},
                                          {params_name: "course_k" , value: proper_name["高等部"], first_checked: true},
                                          {params_name: "course_d" , value: proper_name["大学部"], first_checked: true}])

    toggle_params_to_variable(params, @form_params, params_name: "show_data")
  end

  # GET /profiles/1
  #def show
  #end

  # GET /profiles/new
  #def new
  #  @profile = Profile.new
  #end

  # GET /profiles/1/edit
  #def edit
  #end

  # POST /profiles
  #def create
  #  @profile = Profile.new(profile_params)

  #  if @profile.save
  #    redirect_to @profile, notice: "Profile was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /profiles/1
  #def update
  #  if @profile.update(profile_params)
  #    redirect_to @profile, notice: "Profile was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /profiles/1
  #def destroy
  #  @profile.destroy
  #  redirect_to profiles_url, notice: "Profile was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def profile_params
      params.require(:profile).permit(:result_no, :generate_no, :p_no, :title, :nickname, :subject_id, :course_id, :species, :sexuality, :age)
    end
end
