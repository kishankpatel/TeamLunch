steps to run the project

git clone https://github.com/kishankpatel/TeamLunch.git
cd TeamLunch
install rvm and install ruby-2.4.0 through rvm  if not
rvm use 2.4.0@teamlunch --create
bundle install
rake db:create
rake db:migrate
rake db:seed

After running the seed it will create manager account
	Manager credencial: 
		email: "manager@test.com"
		password: "test1234"
run the server by: rails s

Now you can login in to the application through above credencial.


Rspec commands,
	For User model: exec rspec spec/models/user_spec.rb
	For Place model: exec rspec spec/models/place_spec.rb
	For Place controller index method: exec rspec spec/controllers/place_spec.rb/places_controller_spec.rb