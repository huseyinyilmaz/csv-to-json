CSV-TO-JSON
===========

Command line tool that converts csv files into json files in constant space.


Help output:

::

   $ csv-to-json --help
   Converts input csv file into a json file.

   Usage: csv-to-json (-i|--input INPUT) (-o|--output OUTPUT)

   Available options:
     -h,--help                Show this help text
     -i,--input INPUT         input csv file.
     -o,--output OUTPUT       output json file.

Usage:

::

   $ csv-to-json -i ~/test.csv -o output.json


Build the project:

::

   stack build

Run the test suite:

::

   stack test

Run the benchmarks:

::

   stack bench

Generate documentation:

::

   stack haddock
