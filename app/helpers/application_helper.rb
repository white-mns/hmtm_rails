module ApplicationHelper
  def site_title
    title = "Secret Sphereデータ小屋"
  end

  def page_title
    title = site_title
    title = @page_title + " | " + title if @page_title
    title
  end

  def uploading_alert(latest_result, uploaded_result)
    if latest_result == uploaded_result then return end

    haml_tag :div, class: "alert alert-dismissible alert-danger" do
      haml_concat "現在データの更新中です。"
      haml_tag :button, type: "button", class: "btn-close", data: {dismiss: "alert"}
    end
  end

  def numeric_parse(text)
    return Nokogiri::HTML.parse(text).text
  end

  def pc_name_text(p_no, pc_name)
    if pc_name then
      haml_concat pc_name.name
    end
    haml_concat "("
    haml_tag :a, href: "http://www.sssloxia.jp/result/now/c/"+sprintf("%d",p_no)+".html", target: "_blank" do
      haml_concat sprintf("%d",p_no)
    end
    haml_concat ")"
  end

  def party_members_pc_name_text(party_members)
    if !party_members then return end

    party_members.each do |party_member|
      if (party_member.is_supporter == 0)
        pc_name_text(party_member.p_no, party_member.pc_name)
        haml_tag :br
      end
    end

    party_members.each do |party_member|
      if (party_member.is_supporter == 1)
        pc_name_text(party_member.p_no, party_member.pc_name)
        haml_concat "　[ CHEER ]"
        haml_tag :br
      end
    end
  end

  def character_link(p_no)
    if p_no <= 0 then return end

    file_name = sprintf("%d",p_no)
    link_to " 結果", "http://www.sssloxia.jp/result/now/c/"+file_name+".html", :target => "_blank"
  end

  def character_next_link(latest_result_no, p_no, result_no, generate_no)
    if p_no <= 0 then return end
    if result_no == latest_result_no then return end

    result_no_text = (result_no == latest_result_no - 1) ? "now" : sprintf("%d", result_no + 1)
    file_name = sprintf("%d", p_no)
    link_to " 次回結果", "http://www.sssloxia.jp/result/"+result_no_text+"/c/"+file_name+".html", :target => "_blank"
  end

  def character_previous_link(latest_result_no, p_no, previous_result_no, previous_generate_no)
    if p_no <= 0 then return end
    if previous_result_no == 0 then return end

    previous_result_no_text = sprintf("%d", previous_result_no)
    file_name = sprintf("%d", p_no)
    link_to " 前回結果", "http://www.sssloxia.jp/result/"+previous_result_no_text+"/c/"+file_name+".html", :target => "_blank"
  end

  def character_old_link(latest_result_no, p_no, result_no, generate_no)
    if p_no <= 0 then return end
    if result_no == latest_result_no then return end

    result_no_text = sprintf("%d", result_no)
    generate_text  = generate_no > 0 ? "_" + sprintf("%d", generate_no) : ""
    file_name = sprintf("%d", p_no)
    link_to " 過去結果", "http://www.sssloxia.jp/result/"+result_no_text+"/c/"+file_name+".html", :target => "_blank"
  end

  def battle_link(battle_type, battle_no)
    directories = {
        0 => "b",
        1 => "prc",
        2 => "rank",
        3 => "pk",
        4 => "b",
        5 => "b",
    };

    file_name = sprintf("%d",battle_no)
    link_to " 結果", "http://www.sssloxia.jp/result/now/"+directories[battle_type]+"/"+file_name+".html", :target => "_blank"
  end

  def battle_old_link(latest_result_no, battle_type, battle_no, result_no, generate_no)
    directories = {
        0 => "b",
        1 => "prc",
        2 => "rank",
        3 => "pk",
        4 => "b",
        5 => "b",
    };

    if result_no == latest_result_no then return end

    result_no_text = sprintf("%d", result_no)
    generate_text  = generate_no > 0 ? "_" + sprintf("%d", generate_no) : ""
    file_name = sprintf("%d", battle_no)
    link_to " 過去結果", "http://www.sssloxia.jp/result/"+result_no_text+"/"+directories[battle_type]+"/"+file_name+".html", :target => "_blank"
  end

  def search_submit_button()
    haml_tag :button, class: "btn btn-outline-search", type: "submit" do
      haml_concat fa_icon "search", text: "検索する"
    end
  end

  def p_no_concat_button()
    query_text = (URI.parse(request.url).query) ? '?' + URI.parse(request.url).query : ''
    haml_tag :button, class: 'btn btn-p-no-concat', data: {url: controller_name + '/pno_text' + query_text} do
      haml_concat fa_icon "copy", text: "PNoを文字列化"
    end
  end

  def ex_sort_text(params, sort_column, text)
    if params["ex_sort"] == "on" && params["ex_sort_text"] && params["ex_sort_text"].include?(sort_column) then
      if params["ex_sort_text"].include?("desc")
        text = text + "▼"
      else
        text = text + "▲"
      end
    end
    text
  end

  def help_icon()
    haml_concat fa_icon "question-circle"
  end

  def act_desc(is_opened)
    desc        = is_opened ? "（クリックで閉じます）" : "（クリックで開きます）"
    desc_closed = is_opened ? "（クリックで開きます）" : "（クリックで閉じます）"

    haml_tag :span, class: "act_desc" do
      haml_concat desc
    end

    haml_tag :span, class: "act_desc closed" do
      haml_concat desc_closed
    end
  end

  def act_icon(is_opened)
    icon        = is_opened ? "times" : "plus"
    icon_closed = is_opened ? "plus"  : "times"

    haml_tag :span, class: "act_desc" do
      haml_concat fa_icon icon, class: "fa-lg"
    end

    haml_tag :span, class: "act_desc closed" do
      haml_concat fa_icon icon_closed, class: "fa-lg"
    end
  end

  def td_form(f, form_params, placeholders, class_name: nil, colspan: nil, label: nil, params_name: nil, placeholder: nil, checkboxes: nil, label_td_class_name: nil)
    haml_tag :td, class: label_td_class_name do
      if label then
        haml_concat f.label params_name.to_sym, label
      end
    end

    # テキストフォームの描画
    if !class_name.nil? && !params_name.nil?  then
      td_text_form(f, form_params, placeholders, class_name: class_name, colspan: colspan, params_name: params_name, placeholder: placeholder)
    end

    # チェックボックス選択フォームの描画
    if !checkboxes.nil?  then
      td_text_checkbox(f, form_params, placeholders, class_name: class_name, colspan: colspan, checkboxes: checkboxes)
    end
  end

  def td_text_form(f, form_params, placeholders, class_name: nil, colspan: nil, params_name: nil, placeholder: nil)
    haml_tag :td, class: class_name, colspan: colspan do
      haml_concat text_field_tag params_name.to_sym, form_params[params_name], placeholder: placeholders[placeholder]
    end
  end

  def td_text_checkbox(f, form_params, placeholders, class_name: nil, colspan: nil, checkboxes: [])
    haml_tag :td, class: class_name, colspan: colspan do
      checkboxes.each do |hash|
        # チェックボックスの描画
        if !hash[:params_name].nil? then
          haml_tag :span, class: hash[:class_name] do
            haml_concat check_box_tag hash[:params_name].to_sym, form_params[hash[:params_name]], form_params[hash[:params_name]]
            haml_concat label_tag hash[:params_name].to_sym, hash[:label]
          end
        end

        # 改行指定
        if hash[:br] then
          haml_tag :br
        end
      end
    end
  end

  def tbody_toggle(form_params, params_name: nil, label: {open: "", close: ""}, act_desc: nil, base_first: false)
    haml_tag :tbody, class: "tbody_toggle pointer"do
      haml_tag :tr do
        haml_tag :td, colspan: 5 do
          if base_first then
            haml_concat hidden_field_tag :base_first, form_params["base_first"]
          end

          haml_concat hidden_field_tag params_name.to_sym, form_params[params_name]

          act_icon(false)

          haml_concat label_tag params_name.to_sym, "　" + label[:open],  class: "act_desc"
          haml_concat label_tag params_name.to_sym, "　" + label[:close], class: "act_desc closed"
          if act_desc then
            haml_tag :div, class: "act_desc" do
              haml_concat "　" + act_desc
            end
          end
        end
      end
    end
  end

  def subject_text(profile)
    if !profile then return end

    if profile.subject_id == 0 then "魔術科"
    elsif profile.subject_id == 1 then "武術科"
    else "？"
    end
  end

  def equip_no_text(equip_no)
    if !equip_no then return "-" end

    if equip_no == 0 then "武器"
    elsif equip_no == 1 then "防具"
    elsif equip_no == 2 then "装飾"
    else "？"
    end
  end

  def range_text(range)
    if !range then return "-" end

    if range >= 0 then range
    else "-"
    end
  end

  def party_type_text(party_type)
    if !party_type then return "-" end

    party_types = {
        0 => "通常戦闘",
        1 => "朝練戦闘",
        2 => "ランク戦",
        3 => "風紀戦闘",
        4 => "レイド戦",
        5 => "魔闘大会",
        10 => "次回通常戦闘予告",
        11 => "次回朝練戦闘予告",
        12 => "次回ランク戦予告",
        13 => "次回風紀戦闘予告",
        14 => "次回レイド戦予告",
        15 => "次回魔闘大会予告"
    };

    return party_types[party_type]
  end

  def battle_type_text(party_type)
    party_type_text(party_type)
  end

  def pk_type_text(pk_type)
    if !pk_type then return "-" end

    pk_types = {
        0 => "",
        1 => "※不良",
        2 => "●風紀",
        3 => "▲抗戦"
    };

    return pk_types[pk_type]
  end

  def battle_result_text(battle_result, is_left)
    if !battle_result then return "-" end

    if battle_result == 0 then return "引分" end
    if battle_result < -2 then return "？" end
    if battle_result == is_left then return "勝利"
    else "敗北"
    end

  end

  def battle_result_style(battle_result, is_left)
    if !battle_result then return "-" end

    if battle_result == 0 then return "" end
    if battle_result < -2 then return "" end
    if battle_result == is_left then return "border-left: double 6px #c44;"
    else "border-left: dotted 3px #66c;"
    end
  end

  def tooltip_text(text, data, placement="right")
    if text == "" then return end

    title = data[text]
    placement = "-" + placement

    span_attr = {data: {bs: {toggle: "tooltip" + placement}}, title: title}

    haml_tag :span, span_attr do
      haml_concat numeric_parse(text)
    end
  end

  def tooltip_spell_or_tg_text(text, spell_data, tg_data, placement="right")
    if text == "" then return end

    if spell_data[text] then
      tooltip_text(text, spell_data, placement)
    else
      tooltip_text(text, tg_data, placement)
    end
  end

  def spell_text(name, spell_data, placement="right")
    if name == "" then return end

    tooltip_text(name, spell_data, placement)
  end

  def gems_text(gems_text, tg_data)
    if !gems_text then return end

    gems = gems_text.split(",")

    gems.each_with_index do |gem, index|
      if gem == "" then next end

        tooltip_text(gem, tg_data, "bottom")

      if index != gems.size - 1 then haml_concat "、" end
    end

    return
  end

  def enemy_names_text(enemies_text)
    if !enemies_text then return end

    enemies = enemies_text.split(",")
    enemies.shift

    enemies.each do |enemy|
      haml_concat numeric_parse(enemy)
      haml_tag :br
    end

    return
  end

  def thread_text(thread_text, spell_data, tg_data)
    if !thread_text then return end

    thread_text = thread_text.gsub(",","")
    actions = thread_text.split("|")

    actions.each_with_index do |action, index|
      if action == "" then next end

      depth = action.count(">")
      for i in 1..depth do
        haml_concat "→"
      end

      tg_depth = action.count("<")
      for i in 1..tg_depth -1 do
        haml_concat "　"
      end
      if tg_depth > 0 then
        haml_concat "+"
      end

      tooltip_spell_or_tg_text(numeric_parse(action.gsub(">","").gsub("<","")), spell_data, tg_data, "bottom")

      if index != actions.size - 1 then haml_tag :br end
    end

    return
  end

  def thread_members_text(thread_members)
    if !thread_members then
      return
    end

    thread_members.each do |thread_member|
      if (!thread_member.pc_name || thread_member.name != thread_member.profile.nickname) then
        haml_concat thread_member.name
      else
        pc_name_text(thread_member.p_no, thread_member.pc_name)
      end
      haml_tag :br
    end
  end
end
