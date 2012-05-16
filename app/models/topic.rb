class Topic < ActiveRecord::Base
  attr_accessible :title, :posts_attributes

  belongs_to :forum
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :posts

  validates :title, presence: true, length: { in: 3..90 }

  before_save :set_first_post_creator

  def self.by_latest_post_at
    order "topics.latest_post_at DESC"
  end

  def latest_post
    posts.last
  end

  def original_post
    posts.first
  end

  private 
  def set_first_post_creator
    post = self.posts.first
    post.creator = self.creator
  end
end
