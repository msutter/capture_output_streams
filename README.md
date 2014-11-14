# CaptureOutputStreams

Control output streams of third party gems or libraries.

There are so many cool ruby gems and libraries out there.
What if you want to use one of them in your cli application
without having a way to capture or modify the output streams.

While writing my own cli tool (gitlab_admin), i wanted to use the
great gitup gem to update my local git branches.

I also wanted to control and format the console output of my own cli tools,
but the author of the git-up gem uses 'puts' and 'system' statement in his
code and I did not want to alter his code.

Here an example with the git-up gem.

git-up is a command line utility, but I wanted to use it in my code.
So, to sync a repo, one would do:

    [1] pry(main)> require 'git-up'
    => true
    [2] pry(main)> GitUp.new.run([])
    Fetching origin
    master up to date
    => nil

My repo is synced now, but the method is only returning nil and the
outputs are directly pushed to the console.

So if I want to hide the output from the console, I could do something like:

    [3] pry(main)> require 'capture_output_streams'
    => true
    [4] pry(main)> cos = capture_output_streams {GitUp.new.run([])}
    => #<struct  stdout="Fetching origin\n\e[1mmaster \e[0m\e[32mup to date\e[0m\n", stderr="">
    [5] pry(main)> cos.stdout
    => "Fetching origin\n\e[1mmaster \e[0m\e[32mup to date\e[0m\n"
    [6] pry(main)> puts cos.stdout
    Fetching origin
    master up to date
    => nil

## Installation

Add this line to your application's Gemfile:

    gem 'capture_output_streams'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capture_output_streams

## Usage

Pass your code within a block to capture_output_streams, and you'll get a
Struct back with the output streams.

a simple puts statment

    [1] pry(main)> require 'capture_output_streams'
    => true
    [2] pry(main)> capture_output_streams { puts "hello world" }
    => #<struct  stdout="hello world\n", stderr="">

a more complete example:

    [3] pry(main)> cos = capture_output_streams do
    [3] pry(main)*   system('date')
    [3] pry(main)*   puts "--------------------"
    [3] pry(main)*   $stderr.puts "i'm a failure"
    [3] pry(main)* end
    => #<struct  stdout="Fri Nov 14 11:37:23 CET 2014\n--------------------\n", stderr="i'm a failure\n">
    [4] pry(main)> puts cos.stdout
    Fri Nov 14 11:37:23 CET 2014
    --------------------
    => nil
    [5] pry(main)> puts cos.stderr
    i'm a failure
    => nil

## Note
The kernel system and backticks (``) methods are also dynamically mocked
during the block code execution as they don't use $stdout.

Open4 is used for these mockings.

## Contributing

1. Fork it ( http://github.com/msutter/capture_output_streams/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
