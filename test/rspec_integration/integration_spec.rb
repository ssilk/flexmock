#!/usr/bin/env ruby

#---
# Copyright 2003-2013 by Jim Weirich (jim.weirich@gmail.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#+++

if defined?(RSpec)
  RSpec.configure do |config|
    config.mock_with :flexmock
  end
else
  Spec::Runner.configure do |config|
    config.mock_with :flexmock
  end
end

describe "FlexMock in a RSpec example" do
  specify "should be able to create a mock" do
    m = flexmock()
  end

  specify "should have an error when a mock is not called" do
    m = flexmock("Expectation Failured")
    m.should_receive(:hi).with().once
    lambda {
      flexmock_verify
    }.should raise_error(RSpec::Expectations::ExpectationNotMetError, /\bhi\b.*incorrect.*times/i)
  end

  specify "should be able to create a stub" do
    s = "Hello World"
    flexmock(:base, s).should_receive(:downcase).with().once.and_return("hello WORLD")

    s.downcase.should == "hello WORLD"
  end

  specify "Should show an example failure" do
    lambda {
      1.should == 2
    }.should raise_error(RSpec::Expectations::ExpectationNotMetError,
      /expected: 2.*got: 1/m)
  end

  specify "Should show how mocks are displayed in error messages" do
    m = flexmock("x")
    lambda {
      m.should == 2
    }.should raise_error(RSpec::Expectations::ExpectationNotMetError, /got: <FlexMock:x>/)
  end

end
