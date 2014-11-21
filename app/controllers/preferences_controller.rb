class PreferencesController < ApplicationController

  def set_preference

    @response = '{}'

    if current_user

      @name = params[:name]
      @value = params[:value]

      @response = 'true'

      preference = Preference.find_by_user_id_and_name(current_user.id, @name)

      if preference
        if @value.strip == ''
          preference.destroy # unset if this is blank
        else
          preference.value = @value
          preference.save
        end
      elsif @value.strip != ''
        preference = Preference.new
        preference.user_id = current_user.id
        preference.name = @name
        preference.value = @value
        preference.save
      end

    end

    respond_to do |format|
      format.json { render :json => @response }
    end
  end

end

