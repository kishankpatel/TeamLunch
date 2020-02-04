# TeamLunch
This is demo project in Rails

#### Steps to run the project

##### Clone the project:
`$ git clone https://github.com/kishankpatel/TeamLunch.git`
##### Install RVM
Click [here](https://rvm.io/) to see RVM documentation

##### Install Ruby-2.7.0 using RVM
`$ rvm install 2.7.0` or `$ rvm install ruby-2.7.0`
##### Navigate to the folder and create a _gemset_ for the project
`$ cd TeamLunch`

``$ rvm use 2.4.0@teamlunch --create``

##### Do bundle install
`$ bundle install`

##### Database setup
    $ rails db:migrate:reset
    $ rails db:seed

##### After running the seed it will create manager account
Manager credencial:

     Email: manager@test.com
     Password: test1234

##### Now it's time to start server and use the application
run the server by following command: 

`$ rails s` or `$ rails server`

Now you can login in to the application through above credencial.

##### Rspec commands,
* For User model: 
     `$ exec rspec spec/models/user_spec.rb`

* For Place model
     `$ exec rspec spec/models/place_spec.rb`
* For Place controller index method:
     `$ exec rspec spec/controllers/place_spec.rb/places_controller_spec.rb`


### WorkFlow
* **Admin Login**
  - Manager can login with created account from seed file.
  - After login, Manager can create place for lunch.
  - Only Manager gets an email after addition of the place.
  - Manager can create an event for lunch.
  - Manager will choose places for an event create/edit event page.
  - Manager can add team members (name, email) from the website.
  - Once added, team member should get an email (using letter_opener gem for dev) with a link. Clicking on the link will ask user to reset password.
  - Manager can approve a place created by team members.
  - Manager can also vote a place.
  - Only manager should be able to see the finalize button, and can finalize a place.

* **Employee Login**
    - Employee will get an email with invitation token, throught that link an employee can set his/her password and can login to the application.
    - After login, team member can see all the events.
    - Team member can vote a place from selected places for the event by manager.
    - Team member can also add an place but that need to be approve by manager, after approving manager can add the place in an existing event.

---

#### Maintainers
[@kishankpatel](https://github.com/kishankpatel)
