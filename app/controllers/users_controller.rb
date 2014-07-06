class UsersController < ApplicationController
  require 'net/ftp'

  before_action :authenticate_user!, only: [:upload_avatar]
  before_action :authorize, only: [:upload_avatar]

  def upload_avatar
    @user = current_user
    file = params[:file]

    if file != nil && file.original_filename.downcase.end_with?('.jpg','.png','.jpeg')
      file.original_filename = @user.nickname

      if file.size <= 50.kilobytes
        ftp = Net::FTP.new(ENV['ftp_address'])
        ftp.passive = true
        ftp.login(user = ENV['ftp_login'], passwd = ENV['ftp_password'])
        ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
        ftp.quit()
        @user.avatar_url = "http://avatars.m1l05z.pl/#{file.original_filename}"
        @user.save
        redirect_to root_url, flash: { success: "Your new avatar was uploaded successfully" }
      else
        redirect_to edit_user_registration_path, flash: { error: "Your avatar's file size is too large. Please upload an avatar no bigger than 50 KB" }
      end
    else
      redirect_to edit_user_registration_path, flash: { error: "This file type is not supported. Only files with the following extensions are allowed: jpg jpeg png" }
    end
  end

  private
    def authorize
      unless @snipp.owner?(current_user)
        redirect_to root_url, flash: { alert: "Unauthorize" }
      end
    end
end
