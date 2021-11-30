module StatusHelper
  def mmp_text(mmp)
    if !mmp then
      return "-"
    end

    if mmp >= 0 then mmp
    else "-"
    end
  end
end