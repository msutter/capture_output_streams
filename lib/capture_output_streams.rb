require 'open4'

module CaptureOutputStreams

  Kernel.module_eval do

    def capture_output_streams(&block)
      path = File.dirname(__FILE__)

      # save original kernel methods
      Kernel.module_eval do
        alias_method :orig_system,    :system
        alias_method :orig_backticks, :`
      end

      # save original output streams
      original_stdout = $stdout
      original_stderr = $stderr

      # override original kernel methods
      load File.join(path, 'capture_output_streams/system.rb')
      load File.join(path, 'capture_output_streams/backticks.rb')

      # override original output streams
      $stdout = fake_stdout = StringIO.new
      $stderr = fake_stderr = StringIO.new

      begin
        yield

      ensure
        # restore original kernel methods
        Kernel.module_eval do
          alias_method :system, :orig_system
          alias_method :`,      :orig_backticks
        end

        # restore original output streams
        $stdout = original_stdout
        $stderr = original_stderr

      end

      capture = Struct.new :stdout, :stderr
      capture.new(fake_stdout.string, fake_stderr.string)

    end

  end

end
