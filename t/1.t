# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 1;
BEGIN { use_ok('Time::Consts') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

use Time::Consts qw/
	MSEC
	SEC
	MIN
	HOUR
	DAY
	WEEK
/;

ok(MSEC == 1 / 1000, "Default base (SEC)");
ok(SEC  == 1);
ok(MIN  == 60);
ok(HOUR == 60 * 60);
ok(DAY  == 60 * 60 * 24);
ok(WEEK == 60 * 60 * 24 * 7);
