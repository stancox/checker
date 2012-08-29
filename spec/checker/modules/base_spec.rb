require 'spec_helper'

describe Checker::Modules::Base do
  describe "rvm_command method" do
    context "properly fetches the ruby version from the environment variables" do
      before do
        ENV.stub!(:fetch).with("rvm_path").and_return "/Users/test/.rvm"
      end

      it "uses no gemsets" do
        ENV.stub!(:fetch).with("GEM_HOME").and_return "/Users/test/.rvm/gems/some_ruby_version"

        Checker::Modules::Base.new.send(:rvm_command, "test").should == "/Users/test/.rvm/bin/rvm-shell 'some_ruby_version' -c 'test'"
      end

      it "uses global gemset" do
        ENV.stub!(:fetch).with("GEM_HOME").and_return "/Users/test/.rvm/gems/some_ruby_version@global"

        Checker::Modules::Base.new.send(:rvm_command, "test").should == "/Users/test/.rvm/bin/rvm-shell 'some_ruby_version@global' -c 'test'"
      end

      it "uses some other gemset" do
        ENV.stub!(:fetch).with("GEM_HOME").and_return "/Users/test/.rvm/gems/some_ruby_version@v2"

        Checker::Modules::Base.new.send(:rvm_command, "test").should == "/Users/test/.rvm/bin/rvm-shell 'some_ruby_version@v2' -c 'test'"
      end
    end
  end
end