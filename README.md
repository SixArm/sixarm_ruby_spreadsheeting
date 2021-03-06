# SixArm.com → Ruby → <br> Spreadsheeting gem has import & export helpers for CSV, TSV, Excel, etc.

* Doc: <http://sixarm.com/sixarm_ruby_spreadsheeting/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_spreadsheeting>
* Repo: <http://github.com/sixarm/sixarm_ruby_spreadsheeting>
<!--header-shut-->


## Introduction

String helpers for importing, exporting, and parsing spreadsheet data.

This is useful for reading and writing files in CSV, TSV, Excel, etc.

For docs go to <http://sixarm.com/sixarm_ruby_spreadsheeting/doc>

Want to help? We're happy to get pull requests.


<!--install-open-->

## Install

### Gem

To install this gem in your shell or terminal:

    gem install sixarm_ruby_spreadsheeting

### Gemfile

To add this gem to your Gemfile:

    gem 'sixarm_ruby_spreadsheeting'

### Require

To require the gem in your code:

    require 'sixarm_ruby_spreadsheeting'

<!--install-shut-->


## Details

Some spreadsheet programs use cells that can have different types of data, such as:

  * a date like "2010/12/31"
  * a boolean flag like "+" or "-"
  * a freeform text note like "Hello"

This gem has methods for parsing and printing these individually and in combinations.


## Example

Require:

    require "sixarm_ruby_spreadsheeting"

To import a spreadsheet cell's text that may be a date or a freeform note:

    date, note = import_date_or_note("2010/12/31") 
    => [<Date: 2010-12-31>, nil]

    date, note = import_date_or_note("Hello") 
    => [nil, "Hello"]

To export either a date or a note to spreadsheet cell text:

    date = Date.today
    note = nil
    export_date_or_note(date, text)  #=> "2010/12/31"

    date = nil
    note = "Hello"
    export_date_or_note(date, text)  #=> "Hello"
