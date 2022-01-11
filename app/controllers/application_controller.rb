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
    @placeholder["Item"]   = "例）武器/\"防具\""
    @placeholder["Spell"]  = "例）ショット/\"シールド\""
    @placeholder["SpellText"]  = "例）属性付与/\"対：攻撃\""
    @placeholder["TuneGem"]  = "例）火付与/\"射程増\""
    @placeholder["TuneGemSP"]  = "例）2倍/\"3倍\""
    @placeholder["TuneGemText"]  = "例）属性付与/\"列化\""
  end

  def spell_data_set
    spell_data = SpellDatum.pluck(:name, :text)
    @spell_data = Hash[*spell_data.flatten]
  end

  def tg_data_set
    tg_data = TuneGemDatum.pluck(:name, :text)
    @tg_data = Hash[*tg_data.flatten]
  end
end
