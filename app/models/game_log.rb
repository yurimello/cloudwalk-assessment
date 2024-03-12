class GameLog < ApplicationRecord
  has_one_attached :file
  has_many :games

  validates :filename, presence: true

  def file_path
    ActiveStorage::Blob.service.path_for(file.key)
  end

  
end
