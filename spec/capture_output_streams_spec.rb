require 'spec_helper'

describe CaptureOutputStreams do

  it 'should have a version number' do
    CaptureOutputStreams::VERSION.should_not be_nil
  end

  describe '.capture_output_streams' do

    it 'should accept a block' do
      expect {
        capture_output_streams{}
      }.to_not raise_error
    end

    it 'does not accept arguments' do
      expect {
        capture_output_streams(23)
      }.to raise_error ArgumentError
    end

  end

end
