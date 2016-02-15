require 'spec_helper'

describe ApiTester do

  before do
    described_class.configure { |config| config.endpoint = "http://fai.example.com" }
  end

  describe "#self.post" do
    before { allow_any_instance_of(ApiTester::Connection).to receive(:post) }
    before { allow_any_instance_of(ApiTester::Connection).to receive(:pretty_print) }
    it { expect{ described_class.post("/api", { 'a' => 'b' }.to_json) }.to_not raise_exception }
  end
end
