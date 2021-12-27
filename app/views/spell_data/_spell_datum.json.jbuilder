json.extract! spell_datum, :id, :spell_id, :name, :sp, :element_id, :text, :range, :power, :hit, :timing_id, :class_id, :created_at, :updated_at
json.url spell_datum_url(spell_datum, format: :json)
