class Login
  include ActiveModel::Model

  attr_accessor :email, :password

  def authenticated_user
    return @user if defined?(@user)

    user = User.find_by(email: email)

    @user =
      if user.present? && user.authenticate(password)
        user
      else
        errors.add(:base, "Invalid credentials")
        nil
      end
  end
end
