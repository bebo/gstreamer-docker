#!/usr/bin/env ruby
# vim: set sw=4 ts=4 et :

require 'optparse'
require 'open3'
include Open3

JENKINS_URL = "https://jenkins-stretch.bebo-dev.com/job/docker-public"
JENKINS_TOKEN = 'sHMErmAgeAdspOUsiE'
PROJECT_NAME = 'gstreamer-docker'

def bump_version(t)
    elems = t.split(".").map{|x| x.to_i}
    elems[-1] += 1
    elems.join(".")
end

def require_clean_work_tree
    # do a git pull to make sure we are current
    system("git pull") or raise "Something went wrong with git pull"
    # update the index
    system("git update-index -q --ignore-submodules --refresh")  or raise "Something went wrong with git update-index"

    #no unstaged files allowed
    changed_files, _stderr_str, status = capture3('git status --short')
    unless status.success?
        puts "cannot check git status, exiting"
        exit(1)
    end
    unless changed_files.empty?
        puts "no unstaged files allowed. exiting"
        puts changed_files
        exit(1)
    end
end

# get options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: deploy.rb [options]"

  opts.on("-n", "--[no-]dry-run", "Dry run") do |n|
      options[:dryrun] = n
  end
  options[:environment] = "dev"
  opts.on("-e", "--env ENV", "Environment to deploy to: dev, prod, local") do |e|
      options[:environment] = e
  end
  opts.on("-t", "--tag TAG", "tag to deploy") do |t|
      options[:tag] = t
  end
  options[:live] = false
  opts.on("-l", "--live", "live deploy to hosts") do
      options[:live] = true
  end
  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end

end.parse!

# make sure there are no uncommited changes before we tag
unless options[:dirty] or options[:dryrun]
    require_clean_work_tree
end

test_response=%x(curl -L --write-out %{http_code} -so /dev/null #{JENKINS_URL})
# check for 200, if not, then exit
unless test_response == '200'
    puts "cannot contact jenkins, did you forget to connect to the VPN? #{test_response}"
    exit(1)
end

# generate tag
new_tag = ''
unless options[:tag]
    time = Time.new
    current_branch=%x(git rev-parse --abbrev-ref HEAD).chomp
    new_tag = current_branch + "-" + time.strftime("%Y%m%d%H%M%s")
else
    new_tag = options[:tag]
end

if options[:dryrun]
    puts "Would have tagged #{new_tag} but dry-run is activated"
else
    system("git tag #{new_tag}") or raise "Cannot set tag: #{new_tag}"
    system("git push --tags") or raise "Cannot push tags, something went wrong"
end

# trigger new build
jenkins_build_url="#{JENKINS_URL}/buildWithParameters?token=#{JENKINS_TOKEN}&ENV=#{options[:environment]}&TAG=#{new_tag}&LIVE=#{options[:live]}&PROJECT_NAME=#{PROJECT_NAME}"

puts "jenkins url: #{jenkins_build_url}"
unless options[:dryrun]
    build_response=%x(curl -sL --write-out %{http_code} '#{jenkins_build_url}')
    if build_response == '200' || build_response == '201'
        puts "building #{new_tag}"
    else
        puts "contacting jenkins failed with status code #{build_response}"
        exit(1)
    end
end
