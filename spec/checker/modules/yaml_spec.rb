require 'spec_helper'

describe Checker::Modules::Yaml do
  it 'should only check .yaml and .yml files' do
    files = ['a.rb', 'b.js.erb', 'c.r', 'd.yml', 'e.yaml']
    mod = Checker::Modules::Yaml.new(files)
    mod.stub(:check_one).and_return(true)
    mod.should_receive(:check_one).twice
    mod.check 
  end

  it "should properly fetch yaml files" do
    files = [fixture("yaml", "good.yaml")]
    mod = Checker::Modules::Yaml.new(files)
    mod.check.should be_true
  end

  it "should not pass the syntax check" do
    files = [fixture("yaml", "bad.yaml")]
    mod = Checker::Modules::Yaml.new(files)
    mod.check.should be_false
  end
end
