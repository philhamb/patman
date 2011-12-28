  namespace :db do
  desc "Fill database with sample data"
    task :populate => :environment do
      Rake::Task['db:reset'].invoke
      admin = User.create!(:name => "Example User",
                           :email => "example@railstutorial.org",
                           :password => "foobar",
                           :password_confirmation => "foobar")
      admin.toggle!(:admin)
    
      3.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      end
     
     10.times do 
     

      20.times do
        Patient.all(:limit => 6).each do |patient|
           patient.treatments.create!(:notes => Faker::Lorem.sentence(3),
                                    :tests => Faker::Lorem.sentence(3),
                                    :treatment => Faker::Lorem.sentence(3))
        end
      end
    end
  end

