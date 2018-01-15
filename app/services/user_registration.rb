class UserRegistration
  def initialize(user)
    self.user = user 
  end
  
  def log_in(session, cookies)
    session[:user_id] = user.id
    remember_token = new_token
    user.update!(remember_digest: digest(remember_token))
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
    return user
  end

  def log_out(session, cookies)
    user.update!(remember_digest: nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
  end
  
  private
  attr_accessor :user

  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
