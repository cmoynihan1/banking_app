
if NewUserOffer.all.count == 0
  NewUserOffer.create(amount: 100)
  puts 'Created new user offer.'
end