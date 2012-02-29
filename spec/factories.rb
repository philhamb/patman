  # By using the symbol ':user', we get Factory Girl to simulate the User model.
  Factory.define :user do |user|
    user.name                   "Phil Hambly"
    user.email                  "philhambly@example.com"
    user.password               "foobar"
    user.password_confirmation  "foobar"
  end
  Factory.sequence :email do |n|
    "person-#{n}@example.com"
  end
  Factory.define :patient do |patient|
    
    patient.f_name                  "Phil"
    patient.s_name                 "Hambly"
    patient.email                  "philhambly@example.com"
    patient.dob                    "15-7-1961"
    patient.gender                 "male"   
              
  end
    
  Factory.define :treatment do |treatment|
  treatment.notes "Foo bar"
  treatment.tests "Foo bar"
  treatment.treatment "Foo bar"
  treatment.association :patient
  end
  
  Factory.define :evaluation do |eval|
  eval.symptoms "Foo bar Foo bar"
  eval.onset  "Foo bar"
  eval.trauma_history "Foo bar"
  eval.medical_history "Foo bar"
  eval.current_health "Foo bar"
  eval.evaluation "Foo bar"
  eval.association :patient
  end
  
  
   
