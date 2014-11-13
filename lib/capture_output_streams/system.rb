module CaptureOutputStreams

  Kernel.module_eval do

    def system(*args)
      command = args.join(' ')
      status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
        @pid=pid
        @stdin=command
        @stdout=""
        @stderr=""

        while(line=stdout.gets)
          @stdout+=line
          $stdout.puts line
        end

        while(line=stderr.gets)
          @stderr+=line
          $stderr.puts line
        end

        unless @stdout.nil?
          @stdout=@stdout.strip
        end

        unless @stderr.nil?
          @stderr=@stderr.strip
        end

      end
      @status = status.to_i
      @status == 0 ? true : false
    end

  end
end
