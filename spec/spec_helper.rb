require_relative "../lib/edf.rb"
require_relative "../lib/task.rb"
require_relative "../lib/rmff.rb"
require_relative "../lib/global.rb"
require_relative "../lib/helper.rb"
require "minitest/reporters"
require "minitest/spec"
require "minitest/autorun"
MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new, MiniTest::Reporters::GuardReporter.new]
require "pry"
