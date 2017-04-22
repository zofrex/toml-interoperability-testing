require 'yaml'
require 'open3'
require 'json'

subjects = YAML.load_file "subjects.yml"

results = {}

subjects.each do |subject|
  puts "Testing #{subject["name"]}:"
  stdout, stderr, status = Open3.capture3("../toml-test/toml-test -all -json ../subjects/#{subject["dir"]}/#{subject["exe"]}")

  result = {
    stderr: stderr
  }

  if status == 0
    begin
      test_results = JSON.parse(stdout).map do |result|
        failure = result["Failure"]
        errored = !result["Err"].nil?
        out = {
          name: result["TestName"],
          errored: errored,
          passed: failure.empty? && !errored
        }
        out[:details] = failure if !failure.empty?

        if out[:passed]
          print "."
        elsif out[:errored]
          print "E"
        else
          print "F"
        end

        out
      end
      puts

      total = test_results.length

      result[:tests_passed] = test_results.select {|r| r[:passed]}.count
      result[:tests_failed] = test_results.select {|r| !r[:passed]}.count
      result[:tests_errored] = test_results.select {|r| r[:errored]}.count

      result[:passed] = result[:tests_passed] == total

      puts (result[:passed] ? "PASSED" : "FAILED")
      puts "Passed: #{result[:tests_passed]} Failed: #{result[:tests_failed]} (Errored: #{result[:tests_errored]})"
      puts

      result[:tests] = test_results
      result[:error] = false
    rescue JSON::ParserError => e
      result[:error] = true
      result[:error_type] = :json_parse
      result[:error_details] = e
    end
  else
    result[:error] = true
    result[:error_type] = :status_code
    result[:error_details] = status
  end

  results[subject["name"]] = result
end
