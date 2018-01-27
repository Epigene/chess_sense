ab = User.where(email: "augusts.bautra@gmail.com").first_or_initialize
ab.update!(
  password: "secret", name: "Augusts Bautra"
) if ab.new_record?

puts "Seeded!"
