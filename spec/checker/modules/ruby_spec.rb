require 'spec_helper'

describe Checker::Modules::Ruby do
  it 'should only check .rb files' do
    files = ['a.rb', 'b.js.erb', 'c.r']
    mod = Checker::Modules::Ruby.new(files)
    mod.stub(:check_one).and_return(true)
    mod.should_receive(:check_one).once
    mod.check 
  end

  # 1.8
  if RUBY_VERSION < "1.9"
    it "should pass the syntax check" do
      files = [fixture("ruby", "1.8/good.rb")]
      mod = Checker::Modules::Ruby.new(files)
      mod.check.should be_true
    end

    it "should not pass the syntax check" do
      files = [fixture("ruby", "1.8/bad.rb")]
      mod = Checker::Modules::Ruby.new(files)
      mod.check.should be_false
    end

    it "should not pass the syntax check" do
      files = [fixture("ruby", "1.8/bad2.rb")]
      mod = Checker::Modules::Ruby.new(files)
      mod.check.should be_false
    end
  end

  if RUBY_VERSION >= "1.9"
    it "should pass the syntax check" do
      files = [fixture("ruby", "1.9/good.rb")]
      mod = Checker::Modules::Ruby.new(files)
      mod.check.should be_true
    end

    it "should not pass the syntax check" do
      files = [fixture("ruby", "1.9/bad.rb")]
      mod = Checker::Modules::Ruby.new(files)
      mod.check.should be_false
    end
  end
  # 1.9
end