# Going: The Facebook Calendar for iCal

[![Build Status](https://travis-ci.org/tubbo/going.svg?branch=master)](https://travis-ci.org/tubbo/going)

Going is a Facebook Calendar reader that converts Facebook Events to
iCal format, so you can subscribe in your calendar. It automatically
filters out events you haven't explicitly said you are "Going" to, or
have ignored/removed from your events list.

## Why?

Facebook has an iCal subscription option, but its calendar includes
events you are "Interested" in, and even "Ignore". Some events give you
no other option except to "Remove from Guest List", which makes managing
an active events calendar painful. Going solves this problem, and
provides a slightly more manageable Facebook events calendar
for iCalendar-compatible calendaring users.

## How?

Going is available at https://going.psychedeli.ca/. Log in with Facebook
and click the next button to subscribe to your calendar in iCal
automatically. It's hosted on Heroku, and open-sourced under the MIT
License, so you can be sure that we're not doing anything tricky with
your data. In fact, only the most basic user information is saved, such
as your Facebook ID and access token given to the application when you
logged in for the first time. We persist this information only to
authenticate you and grab events, we do not store events or track any
kind of user movement throughout the application.

## Help!

Please file an issue in our GitHub issue tracker if you're having
problems with Going.
