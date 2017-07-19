class Visit < ActiveRecord::Base

  validates :user_id, :url_id, presence: true

  belongs_to :url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :url_id

  belongs_to :visitor,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id


  def self.record_visits!(user, short_url)
    # debugger
    Visit.create!(user_id: user.id, url_id: short_url.id)
  end



end
