class ApplicationController < ActionController::Base
  def resultno_set
    @latest_result = Name.maximum("result_no")
    @latest_generate = Name.where(result_no: @latest_result).maximum("generate_no")
    @uploaded_result = UploadedCheck.maximum("result_no")
  end

  def placeholder_set
    @placeholder = {}
    @placeholder["Number"] = "例）1~10/50~100"
    @placeholder["Text"]   = "例）武器/\"防具\""
    @placeholder["Name"]   = "例）太郎/\"次郎\""
    @placeholder["Spell"]  = "例）ショット/\"シールド\""
    @placeholder["SpellText"]  = "例）属性付与/\"対：攻撃\""
    @placeholder["Item"]   = "例）武器/\"防具\""
  end
end
