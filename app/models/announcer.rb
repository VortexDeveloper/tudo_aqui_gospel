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

  enum doc_type: [:cnpj, :cpf]

  has_attached_file(
    :avatar,
    styles: { medium: "140x140>", small: "100x100>", thumb: "27x27>" },
    default_url: "../../images/user.png"
  )

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file(
    :banner,
    styles: { normal: "800x370>", medium: "555x150>", thumb: "100x100>" },
    default_url: "../../images/banner.png"
  )

  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/

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

  def main_telephone
    user.profile.telephones.first
  end

  def address_string
    "#{user.profile.street}, #{user.profile.neighborhood}, #{user.profile.city.try(:name)} - #{user.profile.state.try(:name)}"
  end
end
