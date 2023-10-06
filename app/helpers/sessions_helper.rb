module SessionsHelper
    def sign_in(user)
        session[:user_id] = user.id
        @current_user = user
    end

  # Returns the current signed-in user (if any).
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

  # Check if the user is signed in.
    def signed_in?
        !current_user.nil?
    end
end
