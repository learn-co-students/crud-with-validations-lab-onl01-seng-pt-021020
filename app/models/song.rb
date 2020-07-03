class Song < ActiveRecord::Base
    validates :title, uniqueness: { scope: [:release_year, :artist_name], message: "Cannot be repeated by the same artist in the same year" }, presence: true
    validates :release_year, presence: true,
        if: :released?  

    with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {less_than_or_equal_to: Date.today.year }
    end
        
    def released?
        released
    end
    



end 