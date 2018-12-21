class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true, if: :same_year?
  validates :released, inclusion: { in: [true, false] }
  validates :release_year, presence: true, if: :is_released?
  validate :is_in_the_future?
  validates :artist_name, presence: true
  
  def is_released?
    released == true
  end
  def is_in_the_future?
    errors.add(:base,"The release date is past the current year!") unless release_year.to_i < Time.new.year
  end
  def same_year?
    Song.all.each do |song|
      release_year == song.release_year
    end
  end
  
end
