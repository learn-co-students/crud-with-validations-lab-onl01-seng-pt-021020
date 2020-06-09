class Song < ActiveRecord::Base
    validates :title, presence: true
    validates :title, uniqueness: { scope: :release_year,
        message: "should happen once per year" }
    validates :released, inclusion: { in: [true, false] }
    validates :artist_name, presence: true
    validate :song_is_invalid_without_release_year_when_released_is_true,
        :song_is_invalid_when_the_release_year_is_in_the_future

    def song_is_invalid_without_release_year_when_released_is_true
        if released == true && release_year == nil 
          errors.add(:release_year, "song must have release year")
        end
      end
     
      def song_is_invalid_when_the_release_year_is_in_the_future
        if released == true && release_year != nil && release_year > Date.current.year == true
            errors.add(:release_year, "can't be in the future")
        end
      end

end