class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {scope: [:release_year, :artist_name]}
  validates :released, inclusion: {in: [true, false]}
  validates :release_year, presence: true, if: :released?
  validate :valid_year
  validates :artist_name, presence: true

  def valid_year
    if release_year.present? && release_year > Date.today.year
      errors.add(:release_year, "release year can't be in the future")
    end
  end
end