json.extract! profile, :id, :result_no, :generate_no, :p_no, :title, :nickname, :subject_id, :course_id, :species, :sexuality, :age, :created_at, :updated_at
json.url profile_url(profile, format: :json)
