namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "David Hope",
                 email: "dmhope1106@gmail.com",
                 password: "gloria",
                 password_confirmation: "gloria")
                 admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end