 class Announcer < ApplicationRecord
  include Rolifiable
  has_many :ads
  has_many :photos, class_name: "Gallery"
  has_many :vacancies
  belongs_to :ad_plan
  belongs_to :user, optional: false
  has_many :evaluations, class_name: "Evaluation"

  validates :user_id, presence: true, uniqueness: true
  validates :email, :doc, :doc_type, presence: true, on: :update

  ratyrate_rateable "quality"

  rails_admin do
    object_label_method :announcer_label_name
  end

  enum doc_type: [:cnpj, :cpf]

  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", small: "100x100>", thumb: "27x27>" },
    default_url: "/images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file(
    :banner,
    styles: { normal: "800x370>", medium: "555x150>", thumb: "100x100>" },
    default_url: "/images/banner.png"
  )

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/

  delegate :main_phone, :telephones, to: :user, prefix: true, allow_nil: true

  def rate(stars, comment, user, dimension=nil, dirichlet_method=false)
    dimension = nil if dimension.blank?

    if can_rate? user, dimension
      rates(dimension).create! do |r|
        r.stars = stars
        r.rater = user
        r.comment = comment
      end
      if dirichlet_method
        update_rate_average_dirichlet(stars, dimension)
      else
        update_rate_average(stars, dimension)
      end
    else
      update_current_rate(stars, comment, user, dimension)
    end
  end

  def update_current_rate(stars, comment, user, dimension)
    current_rate = rates(dimension).where(rater_id: user.id).take
    current_rate.stars = stars
    current_rate.comment = comment
    current_rate.save!(validate: false)

    if rates(dimension).count > 1
      update_rate_average(stars, dimension)
    else # Set the avarage to the exact number of stars
      a = average(dimension)
      a.avg = stars
      a.save!(validate: false)
    end
  end

  def address_string
    if user.profile.street != nil && user.profile.neighborhood
      first_coma = " , "
    else
      first_coma = " "
    end

    if user.profile.neighborhood != nil && user.profile.city
      second_coma = " , "
    else
      second_coma = " "
    end

    if user.profile.state != nil && (user.profile.street != nil || user.profile.neighborhood != nil || user.profile.city)
      dash = " - "
    else
      dash = " "
    end

    "#{user.profile.street}" + first_coma + "#{user.profile.neighborhood}" + second_coma + "#{user.profile.city.try(:name)}" + dash + "#{user.profile.state.try(:name)}"
  end

  def announcer_label_name
    "#{user.email} - #{self.name}"
  end
end
