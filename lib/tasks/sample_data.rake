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
     
     20.times do 
     
     f_name = Faker::Name.first_name
     s_name = Faker::Name.last_name
     dob    = rand(70.years).ago
     email  = Faker::Internet.email
     mobile_no = 12345678
     landline_no = 12345678
     occupation = Faker::Lorem.sentence(1)
     interests  = Faker::Lorem.sentence(2)
     gender = ["male","female"].shuffle.first
     Patient.create!(:f_name => f_name,
                     :s_name => s_name,
                     :dob    => dob,
                     :email  => email,
                     :mobile_no => mobile_no,
                     :landline_no => landline_no,
                     :occupation => occupation,
                     :interests => interests,
                     :gender    => gender)
      end
                      
     

      20.times do
        Patient.all(:limit => 6).each do |patient|
           patient.treatments.create!(:notes => Faker::Lorem.sentence(3),
                                    :tests => Faker::Lorem.sentence(3),
                                    :treatment => Faker::Lorem.sentence(3))
        end
      end
    end
  end

