class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication, flash: { success: "Successfully Registered" }
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
      #redirect_to edit_user_registration_path, flash: { error: "This file type is not supported. Only files with the following extensions are allowed: jpg jpeg png" }
      render :template => 'users/new'
    end
  end
end
