Superlocal
==========

Superlocal is a reddit-style message board system that allows you to turn your address into a message board.  It was envisioned as a digital corkboard for apartment buildings as an easy way to broadcast building-wide notices, offer and seek ride-sharing opportunities, or just to complain about the asshole in #B10.


Dependencies
============
Superlocal was developed on Ruby v2.0 and Rails v4.0.  Several gems were utilized to make development easier:

```ruby
gem 'figaro'
gem 'devise'
gem 'ancestry'
gem 'thumbs_up'
gem 'acts_as_follower'
gem 'draper'
```

Additionally, the app uses the USPS Webtools API to standardize postal addresses to prevent duplicate message boards.


Installation
============

1. Clone the repository.
2. Create a `/config/application.yml` file with environmental variables holding all your secret keys (see [figaro's](https://github.com/laserlemon/figaro) documentation for more details) and add it to your `.gitignore` file.

   ```ruby
   RAILS_SECRET_KEY_BASE: '<rails secret key>'
   NEW_RELIC_LICENSE_KEY: '<newrelic license key>'
   DEVISE_SECRET_KEY:     '<devise secret key>'
   USPS_API_USERNAME:     '<usps api username>'
   USPS_API_PASSWORD:     '<usps api password>'
   SENDGRID_USERNAME:     '<sendgrid username>'
   SENDGRID_PASSWORD:     '<sendgrid password>'
   ```
3. If deploying to Heroku, add these environmental variables to your production environment: `$ heroku config:set RAILS_SECRET_KEY_BASE=1234abcd`
4. If deploying to Heroku, pick an email provider.  Sendgrid is easy: `$ heroku addons:add sendgrid:starter`
5.  Copy the new sendgrid configuration variables to your `/config/application.yml` file.
6. Add the following to your `config/environment.rb` file:

    ```ruby
    ActionMailer::Base.smtp_settings = {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV['SENDGRID_USERNAME'],
      :password       => ENV['SENDGRID_PASSWORD'],
      :domain         => 'heroku.com',
      :enable_starttls_auto => true
    }
    ```
7. As of v3.1.0, Devise requires the secret key be available during asset precompilation.  Heroku's Cedar stack doesn't support this by default, but you can enable it using the `$ heroku labs:enable user-env-compile -a <appname>` command.


TODO
====

* Board admins
* Submitted links are currently not displayed
* Sorting algorithms (currently sorts by most recent)
* Private messaging


Credits
=======

Superlocal is the product of [Ryan Ringler](http://github.com/rringler).  It was developed largerly as a pet project to continue to learn and better understand rails.


License
=======

Superlocal is licensed under the MIT License.  Please see the [LICENSE](http://github.com/rringler/superlocal/LICENSE) file for additional details.