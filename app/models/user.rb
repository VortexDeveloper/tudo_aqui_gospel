class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :validatable

  has_many :phonebooks
  has_many :telephones, through: :phonebooks
  has_one :profile, class_name: 'PersonalProfile'

  has_one :columnist
  has_one :insider
  has_one :announcer
  has_one :administrator
  has_one :subscriber

  after_create :setting_user

  enum active: [:unactive, :active]

  # DEPRECATED
  def set_roles(roles_id)
    roles_id ||= {} # no role checked
    if roles_id.empty?
      add_role "Subscriber"
    else
      roles_id.each do |id|
        role_name = Role.find(id).name
        add_role role_name
      end
    end
  end

  def create_role_profile(klass_name)
    klass = klass_name.constantize
    klass.create!(user: self)
  end

  def has_role?(role_sym)
    super valid_role(role_sym)
  end

  # DEPRECATED
  def add_role role
    role = valid_role(role)
    super role
    create_role_profile(role)
  end

  def valid_role(role)
    role.to_s.capitalize
  end

  def setting_user
    create_profile
    roles.each { |role| create_role_profile(role.name) }
  end
end
