class User < ActiveRecord::Base

  ROLES = %w[admin member banned]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login
  attr_accessor :login

  has_many :topics, foreign_key: "creator_id"
  has_many :posts,  foreign_key: "creator_id"

  validates :username,  presence: true, 
                        length: { in: 3..20 },
                        uniqueness: { case_sensitive: false }

  before_create :set_default_role

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = ?", login.downcase]).first
    else
      where(conditions).first
    end
  end

  private
  def set_default_role
    self.role = "member"
  end
end
