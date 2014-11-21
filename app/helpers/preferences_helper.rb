module PreferencesHelper
  def user_preference(name, default)
    value = default
    if current_user
      current_user.preferences.each do |preference|
        if preference.name == name
          value = preference.value
        end
      end
    end

    user_preference = value

  end
end