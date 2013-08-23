module VisualizeHelper
  def style_avg(rel_time, target_time)
    pct = rel_time / target_time.to_f
    case
    when pct > 1.1 then
      "color: green"
    when pct < 0.9 then
      "color: red; font-weight: bold"
    else
      ""
    end
  end
end
