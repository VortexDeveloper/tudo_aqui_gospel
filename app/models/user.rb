class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :validatable

  # before_destroy :destroy_transactions

  ratyrate_rater

  has_one :profile, class_name: 'PersonalProfile', dependent: :destroy

  has_one :columnist, dependent: :destroy
  has_one :insider, dependent: :destroy
  has_one :announcer, dependent: :destroy
  has_one :administrator, dependent: :destroy
  has_one :subscriber, dependent: :destroy
  has_many :publications, foreign_key: "author_id", dependent: :destroy
  has_many :evaluations, dependent: :destroy

  after_create :setting_user

  enum active: [:unactive, :active]

  delegate :name, :street, :street_number, :complement, :neighborhood, :cpf,
           :city_name, :state_uf, :state, :country_code, :zip_code, :main_phone,
           :telephones, to: :profile, prefix: false, allow_nil: true

  validates :email, presence: true, uniqueness: true

  # def destroy_transactions
  #   self.transaction.destroy_all
  # end

  rails_admin do
    object_label_method :user_label_name
  end

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

  def type
    profile_type = self.roles.first.name
    case profile_type
      when "Columnist"
        self.columnist
      when "Subscriber"
        self.subscriber
      when "Announcer"
        self.announcer
      when "Administrator"
        self.administrator
    end
  end

  def user_label_name
    "#{self.email} - #{self.name}"
  end

  # def active_for_authentication?
  #   super && active?
  # end
  #
  # def inactive_message
  #   "Desculpe, sua conta não está ativa"
  # end

end
