Song.destroy_all

10.times do |i|
  song = Song.new(title: "Title #{i + 1}", artist_name: "Artist Name #{i + 1}", genre: "Genre #{i + 1}")
  if i % 2 == 0
    song.released = true
    song.release_year = 2001 + i
  else
    song.released = false
  end

  song.save!
end