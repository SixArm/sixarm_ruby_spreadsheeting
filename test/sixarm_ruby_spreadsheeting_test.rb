# -*- coding: utf-8 -*-
require 'simplecov'
SimpleCov.start
require 'test/unit'
require 'date'
require 'sixarm_ruby_spreadsheeting'

class SpreadsheetingTest < Test::Unit::TestCase

  include Spreadsheeting

  DATE_STR="2007/12/31"
  DATE=Date.parse(DATE_STR)

  def test_import_flag
    assert_equal(true,    import_flag('X'))
    assert_equal(false,   import_flag(''))
    assert_equal(true,    import_flag('yes'))
    assert_equal(false,   import_flag('no'))
    assert_equal(true,    import_flag('+'))
    assert_equal(false,   import_flag('-'))
    assert_equal(nil,     import_flag('hello'))
    assert_equal(true,    import_flag(true))
    assert_equal(false,   import_flag(false))
    assert_equal(nil,     import_flag(nil))
  end

  def test_import_flag_or_note
    assert_equal([true,''],     import_flag_or_note('X'))
    assert_equal([false,''],    import_flag_or_note(''))
    assert_equal([true,''],     import_flag_or_note('yes'))
    assert_equal([false,''],    import_flag_or_note('no'))
    assert_equal([true,''],     import_flag_or_note('+'))
    assert_equal([false,''],    import_flag_or_note('-'))
    assert_equal([nil,'hello'], import_flag_or_note('hello'))
    assert_equal([true,''],     import_flag_or_note(true))
    assert_equal([false,''],    import_flag_or_note(false))
    assert_equal([nil,nil],     import_flag_or_note(nil))
  end

  def test_import_date_or_note
    d=Date.parse('2007/12/31')
    assert_equal([d,''],        import_date_or_note('2007/12/31'))
    assert_equal([nil,'hello'], import_date_or_note('hello'))
  end

  def test_export_flag
    assert_equal('+',     export_flag(true))
    assert_equal('-',     export_flag(false))
  end

  def test_export_flag_or_note
    assert_equal('+',     export_flag_or_note(true,'hello'))
    assert_equal('-',     export_flag_or_note(false,'hello'))
    assert_equal('hello', export_flag_or_note(nil,'hello'))
  end

  def test_export_date
    assert_equal(DATE_STR,export_date(DATE))
  end

  def test_export_date_or_note
    assert_equal(DATE_STR, export_date_or_note(DATE,'hello'))
    assert_equal('hello',  export_date_or_note(nil,'hello'))
  end

end
