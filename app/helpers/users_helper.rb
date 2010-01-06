module UsersHelper
  def is_admin?
    current_user and current_user.has_role? 'administrator'
  end
end