class Post < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :topic, counter_cache: true
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  before_save :render_body
  after_create :set_topic_latest_post_at
  after_destroy :rollback_topic_latest_post_at, unless: :original_post?, 
                                                if:     :latest_post?

  validates :body, presence: true, length: { in: 3..10000 }

  class << self
    def by_created_at
      order :created_at
    end
  end

  def original_post?
    self.topic.original_post == self
  end
  def latest_post?
    self.topic.latest_post == self
  end


  def to_html
    rendered_body.html_safe
  end

  private
  def set_topic_latest_post_at
    self.topic.update_attribute(:latest_post_at, self.created_at)
  end
  def rollback_topic_latest_post_at
    self.topic.reload
    self.topic.update_attribute(:latest_post_at, self.topic.posts.last.created_at)
  end
  def render_body
    require "bb-ruby"
    self.rendered_body = body.bbcode_to_html
  end

end
