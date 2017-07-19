class TagTopic < ActiveRecord::Base

  validates :topic_name, presence: true, uniqueness: true

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :topic_id


  def popular_links
    self.taggings.all
  end




end
