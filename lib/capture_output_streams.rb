require 'open4'

require_relative 'capture_output_streams/system'
require_relative 'capture_output_streams/backticks'

module CaptureOutputStream

  Kernel.module_eval do

    def capture_output_streams(&block)
      original_stdout = $stdout
      original_stderr = $stderr
      $stdout = fake_stdout = StringIO.new
      $stderr = fake_stderr = StringIO.new
      begin
        yield
      ensure
        $stdout = original_stdout
        $stderr = original_stderr
      end
      {
        :stdout => fake_stdout.string,
        :stderr => fake_stderr.string,
      }
    end

  end

end
