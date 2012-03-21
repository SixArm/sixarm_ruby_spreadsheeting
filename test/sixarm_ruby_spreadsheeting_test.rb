# -*- coding: utf-8 -*-
require 'minitest/autorun'
require 'simplecov'
SimpleCov.start
require 'date'
require 'sixarm_ruby_spreadsheeting'

describe Spreadsheeting do

  include Spreadsheeting

  before do
    DATE_STR ||= "2007/12/31"
    DATE ||= Date.parse(DATE_STR)
  end


  describe "#import_flag" do

    it "with X or blank" do
      import_flag('X').must_equal true
      import_flag('').must_equal false
    end

    it "with yes or no" do
      import_flag('yes').must_equal true
      import_flag('no').must_equal false
    end

    it "with + or -" do
      import_flag('+').must_equal true
      import_flag('-').must_equal false
    end

    it "with true or false" do
      import_flag(true).must_equal true
      import_flag(false).must_equal false
    end

    it "with text => nil" do
      import_flag('hello').must_equal nil
    end

    it "with nil => nil" do
      import_flag(nil).must_equal nil
    end

  end

  describe "#import_flag_or_note" do

    it "with X or blank" do
      import_flag_or_note('X').must_equal [true,'']
      import_flag_or_note('').must_equal [false,'']
    end

    it "with yes or no" do
      import_flag_or_note('yes').must_equal [true,'']
      import_flag_or_note('no').must_equal [false,'']
    end

    it "with + or -" do
      import_flag_or_note('+').must_equal [true,'']
      import_flag_or_note('-').must_equal [false,'']
    end

    it "with true or false" do
      import_flag_or_note(true).must_equal [true,'']
      import_flag_or_note(false).must_equal [false,'']
    end

    it "with text => note" do
      import_flag_or_note('hello').must_equal [nil,'hello']
    end

    it "with nil => nil" do
      import_flag_or_note(nil).must_equal [nil,nil]
    end

  end

  describe "#import_date_or_note" do
    
    it "date text  => date" do
      import_date_or_note(DATE_STR).must_equal [DATE,'']
    end

    it "freeform text => note" do
      import_date_or_note('hello').must_equal [nil,'hello']
    end

  end

  describe "#export_flag" do

    it "true or false" do
      export_flag(true).must_equal '+'
      export_flag(false).must_equal '-'
    end

  end

  describe "#export_flag_or_note" do

    it "true or false => + or -" do
      export_flag_or_note(true,'hello').must_equal '+'
      export_flag_or_note(false,'hello').must_equal '-'
    end

    it "note => freeform text" do
      export_flag_or_note(nil,'hello').must_equal 'hello'
    end

  end

  describe "#export_date" do

    it "date => date text" do
      export_date(DATE). must_equal DATE_STR
    end

  end

  describe "#export_date_or_note" do
  
    it "date => date text" do
      export_date_or_note(DATE,'hello').must_equal DATE_STR
    end

    it "note => freeform text" do
      export_date_or_note(nil,'hello').must_equal 'hello'
    end

  end

end
