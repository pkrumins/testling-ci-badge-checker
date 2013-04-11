This program retrieves http://ci.testling.com/commits.json and then checks all github repositories for badges.

Usage:

    perl badge-checker.pl

Example output:

    $ perl badge-checker.pl
    https://github.com/ashnur/momentum as a badge (total repos having badges: 1)
    https://github.com/ashnur/rationals as a badge (total repos having badges: 2)
    https://github.com/azu/busterjs_testling-ci as a badge (total repos having badges: 3)
    https://github.com/bmccune/bmccune.com as a badge (total repos having badges: 4)
    Processed: 11/270
    Processed: 22/270
    https://github.com/clebert/strict as a badge (total repos having badges: 5)
    Processed: 33/270
    https://github.com/clebert/strict as a badge (total repos having badges: 6)
    https://github.com/colingo/element as a badge (total repos having badges: 7)
    Processed: 44/270
    https://github.com/colingo/sorted-list as a badge (total repos having badges: 8)
    Processed: 55/270
    https://github.com/devendram/mocha-testling-ci-example as a badge (total repos having badges: 9)
    Processed: 66/270
    https://github.com/dfellis/async-cancelable-events as a badge (total repos having badges: 10)
    https://github.com/dfellis/is-async as a badge (total repos having badges: 11)
    ...

