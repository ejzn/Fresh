Fresh is a new approach to e-mail marketing and cold calling.

This command line tool automates some of the e-mail creation you would probably do by hand. The idea is that
we don't want to craft many similar e-mails, but we also want some personalization. While Mail Chimp allows us to send out
e-mails to "subscribers", what if we want to cold e-mail? Maybe we data minded their info? This is where Fresh comes in. Fresh
allows you to take your spreadsheets of emails and data, add in some custom Mustach Templating, and then send out to your contacts.

== WorkFlow ==

1. Create a CSV of your contacts Names, Emails, and in the future some other info
2. Create a Mustache Template, or use one of the premaid ones.
3. Input your csv, template, and the user information for your smtp server, Fresh will do the rest.

== Future ==

Right now Fresh is in its infancy. In the future it would be nice to build out more templates, add in a Web user interface and more.
Feel free to add some commits and help it along. A feature that is must needed is some sort of timing, or back off mechanism. Running this as part of a cron job is probably a good way to do it, since we don't want to get blacklisting in our e-mail address.
