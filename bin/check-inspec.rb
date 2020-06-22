#! /usr/bin/env ruby
# frozen_string_literal: false

#
# check-inspec
#
# DESCRIPTION:
#   Runs inspec controls against your servers.
#   Fails with a critical if controls are failing.
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: inspec
#
# USAGE:
#   Run entire suite of testd
#   check-inspec -d /etc/my_tests_dir
#
#   Run only one set of tests
#   check-inspec -d /etc/my_tests_dir -t spec/test_one
#
# NOTES:
#   Does it behave differently on specific platforms, specific use cases, etc
#
# LICENSE:
#   Copyright 2019 Sensu, Inc. and contributors. <support@sensu.io>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'json'
require 'socket'
require 'inspec'
require 'sensu-plugin/check/cli'
require 'pry'

class CheckInspec < Sensu::Plugin::Check::CLI
  option :tests_dir,
         short: '-d /tmp/dir',
         long: '--tests-dir /tmp/dir',
         required: true

  # option :spec_tests,
  #       short: '-t spec/test',
  #       long: '--spec-tests spec/test',
  #       default: nil

  option :handler,
         short: '-l HANDLER',
         long: '--handler HANDLER',
         default: 'default'

  def sensu_client_socket(msg)
    u = UDPSocket.new
    u.send(msg + "\n", 0, '127.0.0.1', 3030)
  end

  def send_ok(check_name, msg)
    d = { 'name' => check_name, 'status' => 0, 'output' => 'OK: ' + msg, 'handlers' => [config[:handler]] }
    sensu_client_socket d.to_json
  end

  def send_warning(check_name, msg)
    d = { 'name' => check_name, 'status' => 1, 'output' => 'WARNING: ' + msg, 'handlers' => [config[:handler]] }
    sensu_client_socket d.to_json
  end

  def send_critical(check_name, msg)
    puts "sent critical for #{check_name}"
    d = { 'name' => check_name, 'status' => 2, 'output' => 'CRITICAL: ' + msg, 'handlers' => [config[:handler]] }
    sensu_client_socket d.to_json
  end

  def opts
    {
      logger: Logger.new(nil)
    }
  end

  def control_check_name(control)
    file_path = control[:source_location][:ref].gsub('/', '__')
    "#{file_path}_line#{control[:source_location][:line]}"
  end

  def run
    runner = ::Inspec::Runner.new(opts)
    runner.add_target(config[:tests_dir])
    exit_code = runner.run
    runner.report[:profiles].each do |profile|
      profile[:controls].each do |control|
        control[:results].each do |result|
          check_name = control_check_name(control)
          send_critical(check_name, result[:code_desc]) unless %w[passed].include?(result[:status])
        end
      end
    end
    # 101 is a success as well (exit with no fails but has skipped controls)
    exit_with(:ok, 'applicable controls passed') if [0, 101].include?(exit_code)
    exit_with(:critical, 'exit code no bueno')
  end

  def exit_with(sym, message)
    case sym
    when :ok
      ok message
    when :critical
      critical message
    else
      unknown message
    end
  end
end
