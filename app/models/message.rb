class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :has_data, presence: true

  private

  def has_data
    body.present? || image.present?
  end
end
