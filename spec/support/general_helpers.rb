module GeneralHelpers
  extend self

  def epigene
    User.find_by(email: "augusts.bautra@gmail.com") || create(
      :user, :epigene
    )
  end

  def clear_db!
    DatabaseCleaner.clean_with(:truncation, except: %w(ar_internal_metadata))
  end
end
