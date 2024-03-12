class GameLog < ApplicationRecord
  has_one_attached :file
  validates :filename, presence: true, uniqueness: true

  def file_path
    ActiveStorage::Blob.service.path_for(file.key)
  end

  def log_content
    @log_content ||= File.read(file_path)
  end
end
