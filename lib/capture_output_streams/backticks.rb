module CaptureOutputStreams

  Kernel.module_eval do

    def `(*args)
      command = args.join(' ')
      status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
        @pid=pid
        @stdin=command
        @stdout=""
        @stderr=""

        while(line=stdout.gets)
          @stdout+=line
        end

        while(line=stderr.gets)
          @stderr+=line
        end

        unless @stdout.nil?
          @stdout=@stdout.strip
        end

        unless @stderr.nil?
          @stderr=@stderr.strip
        end

      end
      @status = status.to_i
      $stderr.puts @stderr unless @stderr.empty?
      @stdout
    end

  end
end
