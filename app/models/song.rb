class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, presence: true, if: :released?
    validates :release_year, inclusion: {in: 1900..Date.today.year}, if: :released?
    validates :artist_name, presence: true

    def title_and_artist
        self.title + " by " + self.artist_name
    end
end
