class ShortenedUrl < ActiveRecord::Base

  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  has_many :tags,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :url_id

  has_many :tag_topics,
    through: :tags,
    source: :tag_topic

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :url_id

  def self.shorten_url(user, url)
    code = self.random_code
    ShortenedUrl.create!(long_url: url, short_url: code, user_id: user.id)
  end

  def self.random_code
    begin
      code = SecureRandom::urlsafe_base64
      raise "Code exists already." if ShortenedUrl.exists?(short_url: code[0..15])
    rescue
      retry
    end
    code[0..15]
  end

  def num_clicks
    self.visits.select(:id).count
  end

  def num_uniques
    self.visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    self.visits.select(:user_id).distinct.where({ created_at: (10.minutes.ago)..(Time.now.utc) }).count
  end

end
