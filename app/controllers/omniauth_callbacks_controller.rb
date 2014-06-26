class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :authorize_user
  
  def facebook
    
  end

  def twitter
    
  end

  private

  def authorize_user
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success, kind: provider if is_navigational_format?
    # else
    #   session["devise." + provider + "_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    end
  end

end