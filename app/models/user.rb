class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  def set_roles(roles_id)
    roles_id ||= {} # no role checked

    if roles_id.empty?
      self.add_role "Insider"
      Insider.create!(user: self)
    else
      roles_id.each do |id|
        role_name = Role.find(id).name
        self.add_role role_name
        create_role_profile(role_name)
      end
    end
  end

  def create_role_profile(klass_name)
    klass = klass_name.constantize
    klass.create!(user: self)
  end

  def has_role?(role_sym)
    super role_sym.to_s.capitalize
  end
end
