# TeamLunch
This is demo project in Rails

####Steps to run the project

#####Clone the project:
`$ git clone https://github.com/kishankpatel/TeamLunch.git`
#####Install RVM
Click [here](https://rvm.io/) to see RVM documentation

#####Install Ruby-2.4.0 using RVM
`$ rvm install 2.4.0` or `$ rvm install ruby-2.4.0`
#####Navigate to the folder and create a _gemset_ for the project
`$ cd TeamLunch`

``rvm use 2.4.0@teamlunch --create``

##### DO bundle install
`$ bundle install`

#####Create and migrate database
`$ rake db:reset`

#####After running the seed it will create manager account
Manager credencial:

     Email: manager@test.com
     Password: test1234

#####Now it's time to start server and use the application
run the server by following command: 

`$ rails s` or `$ rails server`

Now you can login in to the application through above credencial.

#####Rspec commands,
* For User model: 
     `$ exec rspec spec/models/user_spec.rb`

* For Place model
     `$ exec rspec spec/models/place_spec.rb`
* For Place controller index method:
     `$ exec rspec spec/controllers/place_spec.rb/places_controller_spec.rb`

---

####Maintainers
[@kishankpatel](https://github.com/kishankpatel)
