# Going: The Facebook Calendar for iCal

[![Build Status](https://travis-ci.org/tubbo/going.svg?branch=master)][ci]

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
your data. We specifically store the most basic user information,
as your Facebook ID and access token given to the application when you
logged in for the first time. We persist this information to
authenticate you and grab events, we do not store events or track any
kind of user movement throughout the application.

## Help!

Please file an issue on our [issue tracker][issues] if you're having
problems with Going.

## Contributing

Going is an open-source project released under the [MIT License][license].
You can contribute to Going by [submitting a pull request][prs] through
GitHub. We run tests on all pull requests when they're submitted, and
will not merge PRs that fail the build.

### Installation

To install this application, make sure you have **Ruby 2.5** and
**Bundler** installed, then run the following script from the root of
this repo:

    ./bin/setup

Once that's complete, run the following command to start the server if
you're not using `puma-dev` (if you are, you can browse to
http://going.test to start the server instead):

    ./bin/rails server

Then go to <http://localhost:3000>.

[ci]: https://travis-ci.org/tubbo/going
[issues]: https://github.com/tubbo/going/issues
[license]: https://github.com/tubbo/going/blob/master/LICENSE.txt
[prs]: https://github.com/tubbo/going/pulls
