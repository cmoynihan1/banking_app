class RegistrationsController < ApplicationController

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)

    add_intro_offers

    if @new_user.save
      session[:user_id] = @new_user.id
      redirect_to root_path
    else
      redirect_to sign_up_path, alert:'Something went wrong'
    end
  end

  private

  def add_intro_offers
    NewUserOffer.all.each do |offer|
      @new_user.balance += offer.amount
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
