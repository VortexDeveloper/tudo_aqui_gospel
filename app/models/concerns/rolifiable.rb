module Rolifiable
  include ActiveRecord::Concerns

  def has_role?(role_sym)
    user.has_role? role_sym.to_s.capitalize
  end
end
