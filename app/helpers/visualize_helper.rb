module VisualizeHelper
  def style_avg(rel_time, target_time)
    pct = (rel_time / target_time.to_f).round(2)
    case
    when pct > 1.1 then
      "<span style='color: green'>#{rel_time}</span>".html_safe
    when pct < 0.9 then
      "<span style='color: red; font-weight: bold'>#{rel_time}</span>".html_safe
    else
      "<span>#{rel_time}</span>".html_safe
    end
  end
end
