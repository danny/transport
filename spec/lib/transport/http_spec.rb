require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "lib", "transport", "http"))
require 'logger'

describe Transport::HTTP do

  before :each do
    @uri = mock URI, :host => "host", :port => 1234
    @request = mock Net::HTTPRequest, :path => "/path"
    @logger = mock ::Logger, :info => nil
    @options = { :expected_status_code => 200, :logger => @logger }

    @response = mock Net::HTTPResponse, :code => "200", :body => "test\ntest"
    Net::HTTP.stub(:start).and_return(@response)

    @formatter = mock described_class::Formatter, :log_transport => nil
    described_class::Formatter.stub(:new).and_return(@formatter)

    @transport = described_class.new @uri, @request, @options
  end

  describe "perform" do

    it "should perform the request" do
      Net::HTTP.should_receive(:start).with("host", 1234).and_return(@response)
      @transport.perform
    end

    it "should initialize the formatter" do
      described_class::Formatter.should_receive(:new).and_return(@formatter)
      @transport.perform
    end

    it "should log the transport" do
      @formatter.should_receive(:log_transport).with(@uri, @request, @response)
      @transport.perform
    end

    it "should raise UnexpectedStatusCodeError if responded status code is wrong" do
      @transport.options.merge! :expected_status_code => 201
      lambda do
        @transport.perform
      end.should raise_error(Transport::UnexpectedStatusCodeError)
    end

  end

  describe "response" do

    before :each do
      @transport.perform
    end

    it "should return the response body" do
      @transport.perform
      @transport.response.should == "test\ntest"
    end

  end

end
