require 'spec_helper'

describe ApiTester::Connection do

  let(:url) { "http://fai.example.com" }
  let(:connection) { described_class.new(url) }
  let(:faraday) { Faraday.new(url: url) }

  before do
    allow(connection).to receive(:connection).and_return(faraday)
  end

  describe "#post" do
    it { expect{ connection.post("/api", { 'a' => 'b' }.to_json) }.to raise_error(Faraday::ConnectionFailed) }
  end

  describe "#get" do
    it { expect{ connection.get("/api", { 'a' => 'b' }.to_json) }.to raise_error(Faraday::ConnectionFailed) }
  end

  describe "#put" do
    it { expect{ connection.put("/api", { 'a' => 'b' }.to_json) }.to raise_error(Faraday::ConnectionFailed) }
  end

  describe "#delete" do
    it { expect{ connection.delete("/api", { 'a' => 'b' }.to_json) }.to raise_error(Faraday::ConnectionFailed) }
  end
end

