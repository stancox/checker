require 'spec_helper'

module Checker
  module Modules
    class Bogus < Base
      extensions '.test'
      private
      def check_one(file)
        true
      end

      def check_for_executable
        true
      end
    end
  end
end

describe Checker::CLI do
  before do
    @argv_copy = ARGV
  end
  after do
    ARGV = @argv_copy
  end

  context "running without arguments" do
    it "should run checks on modules from git config" do
      ARGV.stub(:size).and_return 0
      Checker::CLI.should_receive(:get_modules_to_check).and_return(["bogus"])
      Checker::CLI.should_receive(:exit).with(0).and_return true
      Checker::CLI.execute
    end
  end

  context "running with argument" do
    it "should run check on modules from argument" do
      ARGV = ["pry"]
      Checker::CLI.should_not_receive(:get_modules_to_check)
      Checker::CLI.should_receive(:exit).with(0).and_return true
      Checker::CLI.execute
    end
  end
end
