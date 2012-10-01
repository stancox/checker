require 'spec_helper'

describe Checker::Modules::ConsoleLog do
  it 'checks coffee and js files' do
    files = ['a.rb', 'b.js.erb', 'c.r', 'd.yaml', 'e.yml', 'f.coffee', 'g.js']
    mod = Checker::Modules::ConsoleLog.new(files)
    mod.stub(:check_one).and_return(true)
    mod.should_receive(:check_one).exactly(2).times
    mod.check 
  end

  describe "does find console.log" do
    before do
      files = [fixture("console_log", "with_console_log.js")]
      @mod = Checker::Modules::ConsoleLog.new(files)
    end

    it "results to be true" do
      @mod.check.should be_true
    end

    it "prints proper message" do
      @mod.should_receive(:print_warning_message)
      @mod.check
    end
  end

  describe "does not find console.log" do
    before do
      files = [fixture("console_log", "without_console_log.js")]
      @mod = Checker::Modules::ConsoleLog.new(files)
    end

    it "results to be true" do
      @mod.check.should be_true
    end

    it "prints proper message" do
      @mod.should_receive(:print_success_message)
      @mod.check
    end
  end
end
