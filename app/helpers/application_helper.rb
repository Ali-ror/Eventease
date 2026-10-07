module ApplicationHelper
  def auth_tab_class(active)
    base = "flex-1 text-center py-2.5 rounded-lg text-sm font-medium transition font-body"
    if active
      "#{base} bg-primary text-white shadow-sm"
    else
      "#{base} bg-white text-gray-500 shadow-sm hover:text-charcoal"
    end
  end

  def role_toggle_class(active)
    base = "px-5 py-2 text-sm font-medium rounded-full transition font-body"
    if active
      "#{base} bg-primary text-white shadow-sm"
    else
      "#{base} text-gray-600 hover:text-charcoal"
    end
  end
end
