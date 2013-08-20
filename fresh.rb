#!/usr/bin/env ruby

# Fresh is a new approach to email, it allow you to send marketing campaigns out in mass w/ templating
# the emails are fresh in that it accepts a simple idea, a name, and a template. Fresh does the res
# @erikjohnzon erik@erikjohnson.ca

require 'mail'
require 'csv'
require 'trollop'
require 'mustache'

# Command line parsing of the options
opts = Trollop::options do
    version "Fresh 0.1 (c) 2013 @erikjohnson"
    banner <<-EOS
This program sends emails to the defined CSV by customizing each email based on the template and the csv file names

Usage:
    fresh [options]
where [options] are:
EOS

    opt :recipients_file, "CSV File of names that are the recipients of our mass compaign",
        :type => String
    opt :template_file, "A Yaml template file defining what the content of the email should be",
        :type => String
    opt :username, "The username for logging into the smtp server",
        :type => String
    opt :password, "The password for the smpt gmail server",
        :type => String
    opt :from, "The from address to use as the initiator of the e-mail",
        :type => String
end

print "Recipients file: " , opts[:recipients_file] , "\n"
print "Template: " , opts[:template_file] , "\n"

#Trollop::die :template_file, "Template file must exist"
#Trollop::die :recipients_file, "Recipients list must exist"

#For our entire file, let's create an email and send it
rows = CSV.read (opts[:recipients_file])
rows.each do |row|
    @name = row[0]
    @email = row[1]
    @subject = row[2]
    @company = row[3]

    Mustache.template_file = "./templates/" + opts[:template_file]

    # Set up delivery defaults to use Gmail
    Mail.defaults do
      delivery_method :smtp, {
        :address => 'smtp.gmail.com',
        :port => '587',
        :user_name => opts[:username],
        :password => opts[:password],
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    end

    print "Sending mail to ", @email , "\n"
    message = Mail.new({:from => opts[:from],
                        :to   => @email,
                        :subject => @subject})
    message.html_part = Mail::Part.new({
                :content_type => 'text/html; charset=UTF-8',
                :body  => "\n" + Mustache.render(:name => @name, :company => @company) + "\n"})

    # Don't forget delivery
    message.deliver!
    sleep(1)
end

