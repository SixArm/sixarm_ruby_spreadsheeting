=begin rdoc

= SixArm Ruby Gem: Spreadsheeting has import & export helpers for CSV, TSV, Excel, etc.

Author:: Joel Parker Henderson, joelparkerhenderson@gmail.com
Copyright:: Copyright (c) 2006-2010 Joel Parker Henderson
License:: CreativeCommons License, Non-commercial Share Alike
License:: LGPL, GNU Lesser General Public License

=end


module Spreadsheeting


  # Convert true/false to "+"/"-"
  # 
  # @param [Boolean] flag
  # @return [String] "+" or "-"

  def export_flag(flag)
    flag ? '+' : '-'
  end


  # Corresponds to import_flag_or_note
  #
  # - flag==true => "+"
  # - flag==false => "-"
  # - flag==nil => note
  #
  # @return [String] "+" or "-" or freeform string note
  #
  # @example
  #   export_flag_or_note(true,"hello") => "+"
  #   export_flag_or_note(false,"hello") => "-"
  #   export_flag_or_note(nil,"hello") => "hello"
  #
  # @see #import_flag_or_note
  # @see #export_flag

  def export_flag_or_note(flag,note=nil)
    return flag==nil ? note : export_flag(flag)
  end


  # Convert a date to a string format "YYYY/MM/DD"
  #
  # @param [Boolean] flag
  # @return [String] "+" or "-"

  def export_date(date)
    date.strftime("%Y/%m/%d")
  end


  # Corresponds to import_date_or_note
  #
  # - date is non-null => "2007/12/31"
  # - date is null => note
  #
  # @return [String] a date formatted like "2007/12/31" or freeform string note
  #
  # @example
  #   d=Date.parse('1/1/2007')
  #   export_date_or_note(d,'hello') => '2007-01-01'
  #   export_date_or_note(nil,'hello') => 'hello'
  #
  # @see #import_date_or_note

  def export_date_or_note(date,note=nil)
    return date==nil ? note : export_date(date)
  end


  # Parse a string to a date, with some cleanup.
  #
  # @param [String, #to_s, nil] input to parse, e.g. "2007/12/31"
  # @return [Date] the parsed date
  #
  # @see #import_date_or_note

  def import_date(input)
    return nil if input==nil
    input_s = input.to_s.strip
    return nil if input==''
    return Date.parse(input_s)
  end


  # Parse an imput that may be a date (e.g. "2007/12/31") or a note (e.g. freeform text) into an array.
  # 
  # There's a common import use case where a column can be of two types:
  # - a date, in a variety of format like "Jan 1, 2008", "1/1/2008", etc.
  # - a note, in plain text
  #
  # @param [Boolean, String, #to_s, nil] input typically "Yes", "No", "On", "Off", etc.
  # @return [Array<Date, String>] the parsed output [date, note]
  #
  # @example
  #   import_date_or_note('1/1/2007') => [Date(2007,01,01),'']
  #   import_date_or_note('hello') => [nil,'hello']
  #
  # @see #export_date_or_note
  # @see #import_date
  
  def import_date_or_note(input)
    begin
      d=import_date(input)
    rescue
      d=nil
    end
    return d ? [d,''] : [nil,input]
  end


  # Parse various input words (e.g. "Yes", "No", "On", "Off") to true or false.
  #
  # There's a typical import use case where a column is
  # a boolean, in a variety of formats like "X" for on,
  # "Y" for yes, "T" for true, etc.
  #
  # We use these rules:
  # - x y yes t true on +  => true
  # - blank n no f false off -  => false
  # - anything else => nil
  #
  # @param [Boolean, String, #to_s, nil] input typically "Yes", "No", "On", "Off", etc.
  # @return [Boolean] the parsed output
  #
  # @example
  #   import_flag("Yes") => true
  #   import_flag("No") => false
  #   import_flag("X") => true
  #   import_flag("") => false
  #   import_flag("Hello") => nil
  #   import_flag(true) => true
  #   import_flag(false) => true
  #   import_flag(nil) => nil
  #
  # @see #import_flag_or_note

  def import_flag(input)
    return input if (input==true or input==false or input==nil)
    case input.to_s.strip.downcase
    when 'x','y','yes','t','true','on','+'
      return true
    when '','n','no','f','false','off','-'
      return false
    else 
      return nil
    end
  end


  # Parse an imput that may be a flag (e.g. true/false) or a note (e.g. freeform text) into an array.
  #
  # There's a typical import use case where a column
  # can contain two different data types:
  # - a boolean, in a variety of formats (see _import_flag_)
  # - a note, in plain text
  #
  # We need to separate these two.
  #
  # We use these rules:
  # - x y yes t true on +  => [true, '']
  # - blank n no f false off -  => [false, '']
  # - any other string => [nil, note]
  # - nil => [nil, nil]
  #
  # @param [Boolean, String, #to_s, nil] input typically "Yes", "No", "On", "Off", etc.
  # @return [Array<Boolean, String>] the parsed output [flag, note]
  #
  # @example
  #   import_flag_or_note("Yes") => [true,""]
  #   import_flag_or_note("No") => [false,""]
  #   import_flag_or_note("X") => [true,""]
  #   import_flag_or_note("") => [false,""]
  #   import_flag_or_note("Hello") => [nil,"Hello"]
  #   import_flag_or_note(true) => [true,""]
  #   import_flag_or_note(false) => [false,""]
  #   import_flag_or_note(nil) => [nil,nil]
  #
  # @see #export_flag_or_note
  # @see #import_flag

  def import_flag_or_note(input)
    return [nil, nil] if (input==nil)
    flag = import_flag(input)
    return [flag, flag==nil ? input : '']
  end


end
