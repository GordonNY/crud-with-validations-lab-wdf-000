class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { scope: [:release_year, :artist_name] }
  validates :released, inclusion: { in: [true, false] }
  validate :check_release_year
  validates :artist_name, presence: true

  def released_is_false?
    released == false
  end

  def released_is_true?
    released == true
  end

  def check_release_year
    if release_year.nil? && released == true
      errors.add(:release_year, "cannot be nil when released is true")
    elsif release_year
      less_than_current_year
    end
  end

private
  def less_than_current_year
    if release_year > Date.today.year
      errors.add(:release_year, "must less than current year")
    end
  end
end
