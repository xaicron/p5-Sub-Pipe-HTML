use inc::Module::Install;
name 'Sub-Pipe-HTML';
all_from 'lib/Sub/Pipe/HTML.pm';

requires 'Sub::Pipe', '0.03';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
