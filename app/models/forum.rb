class Forum < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :topics, dependent: :destroy

  def to_singular
    case name
    when "Debates" then "Debate"
    when "Off-Topic" then "Discussion"
    when "Introductions" then "Introduction"
    end
  end
end
