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


Here is a small test I did to see the performance of tool. (Done on my laptop)
TODO: Run the same test while laptop connected to a power source.

::

   $ ls -alh  data.csv
   -rw-r--r--  1 huseyinyilmaz  staff   620M Dec 20 20:06 data.csv
   $ wc -l data.csv
    1000000 data.csv
   $ time csv-to-json -i data.csv -o data.json

   real	0m50.869s
   user	1m23.033s
   sys	0m35.982s
   $ ls -alh data.json
   -rw-r--r--  1 huseyinyilmaz  staff   1.4G Dec 20 20:10 data.json
