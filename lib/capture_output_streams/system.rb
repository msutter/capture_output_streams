module CaptureOutputStream
Kernel.module_eval <<-EOV

  def system(*args)
    command = args.join(' ')
    status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
      @pid=pid
      @stdin=command
      @stdout=""
      @stderr=""

      while(line=stdout.gets)
        @stdout+=line
        puts line
      end

      while(line=stderr.gets)
        @stderr+=line
        puts line
      end

      unless @stdout.nil?
        @stdout=@stdout.strip
      end
      unless @stderr.nil?
        @stderr=@stderr.strip
      end

    end
    @status = status.to_i
    @status == 0 ? true : nil
  end

  EOV
end
