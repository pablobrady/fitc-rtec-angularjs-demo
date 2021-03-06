class FeaturedUser < ActiveRecord::Base

  scope :latest,
    order(:created_at => :desc)

  belongs_to :user

  after_save :pusher_create
  after_destroy :pusher_destroy

  def pusher_create
    AppPusher.send('user', 'featured-add', self.user.to_listing_json)
  end

  def pusher_destroy
    AppPusher.send('user', 'featured-remove', self.user.to_listing_json)
  end
end
