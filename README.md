# BSC-Workshift-Manager

<a href="https://codeclimate.com/github/Celia0/bsc-workshift-manager/maintainability"><img src="https://api.codeclimate.com/v1/badges/98f4fd2b4774b4306c1f/maintainability"></a>

<a href="https://codeclimate.com/github/Celia0/bsc-workshift-manager/test_coverage"><img src="https://api.codeclimate.com/v1/badges/98f4fd2b4774b4306c1f/test_coverage"></a>

<a href="https://travis-ci.org/Celia0/bsc-workshift-manager"><image src="https://travis-ci.org/Celia0/bsc-workshift-manager.svg?branch=master"/></a>

# Overview

The customers needed to revamp their workshift management system to a more user-friendly and efficient application. Their current system has all the needed functionality, but, it takes a meticulous amount of time to do each individual task. Our application will  revamp their entire workshift system so that there would be more accessible interface for both members and managers. The link to our customer’s website:
https://workshift.bsc.coop/caz/

Our project is currently deployed at:
https://bsc-workshift-manager.herokuapp.com

# Setup

First of all, you have to fork this repo, and then clone it onto your local computer.

- Local

To run and test the app locally, you have to install the required gems
```bash
bundle install --without production
```
Then you need to initialize the database tables with seeds
```bash
./database_reset
```
Which runs the following three commands at once
```bash
rake db:drop
rake db:migrate
rake db:seed
```
Additionally, to run javascript involved cucumber tests (some of our tests with @javascript tag),
we use a webdriver called "Poltergeist" which has dependency of "PhantomJS"

You can find guides to install it <a href="https://github.com/teampoltergeist/poltergeist">here</a>.

Then you're all set.
You can run the tests by using the following commands
```bash
bundle exec rspec
bundle exec cucumber
```

- Deploy

To deploy onto heroku, you have to login and create an app for it on heroku
```bash
heroku login
heroku create <name-of-the-app-you-want>
```
Then you can just push it onto heroku to deploy
```bash
git push heroku master
```
Again, you need to initialize the database
```bash
./heroku_database_reset
```
Which runs the following three commands at once
```bash
heroku pg:reset DATABASE --confirm bsc-workshift-manager # replace this with your app name
heroku run rake db:migrate
heroku run rake db:seed
```
Then you're all set.

Finally, we recommend you to add your own badges for CodeClimate and Travis CI.
And you don't have to worry about PhantomJS on Travis CI, it's built-in.
