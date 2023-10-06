class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to '/my_tasks'
      # Handle successful login (e.g., redirect to user dashboard)
        else
            flash.now[:alert] = 'Invalid email or password'
            
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to '/'
    end
end
