use inc::Module::Install;
name 'Sample-VendingMachine';
all_from 'lib/Sample/VendingMachine.pm';
readme_from 'lib/Sample/VendingMachine.pm';
readme_markdown_from 'lib/Sample/VendingMachine.pm';
readme_pod_from 'lib/Sample/VendingMachine.pm';
githubmeta;

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
