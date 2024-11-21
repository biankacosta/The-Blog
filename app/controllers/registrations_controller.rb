class RegistrationsController < ApplicationController
    def new
        @user = User.new
        #@ permite a visualização em outras partes do código
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account"
        else 
            render :new, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password)
        
    end
end