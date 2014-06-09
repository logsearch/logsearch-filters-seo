require "test_utils"
require "logstash/filters/grok"

describe LogStash::Filters::Grok do
  extend LogStash::RSpec

  config <<-CONFIG
    filter {
      #{File.read("target/100-googlebot.conf")}
    }
  CONFIG

  describe "Parse Googlebot JSON" do
    
    sample("@type" => "googlebot", "@message" => '{ "@timestamp": "2014-06-07T01:53:14-07:00", "remote_addr": "66.249.67.102", "body_bytes_sent": 9943, "request_time": 0.770, "status": 200, "request_method": "GET", "scheme": "https", "server_name": "yoast.com", "request_uri": "/hire-us/website-review/", "document_uri": "/index.php", "http_user_agent": "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" }') do
      insist { subject["@type"] } == "googlebot"
      insist { subject["@timestamp"] } == Time.iso8601("2014-06-07T08:53:14.000Z")

      insist { subject["remote_addr"] } == "66.249.67.102"
      insist { subject["body_bytes_sent"] } == 9943
      insist { subject["request_time"] } == 0.770
      insist { subject["status"] } == 200
      insist { subject["request_method"] } == "GET"
      insist { subject["scheme"] } == "https"
      insist { subject["server_name"] } == "yoast.com"
      insist { subject["request_uri"] } == "/hire-us/website-review/"
      insist { subject["document_uri"] } == "/index.php"
      insist { subject["http_user_agent"] } == "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    end

  end

  describe "Parse Googlebot JSON - add DNS resolution remote_addr" do

    sample("@type" => "googlebot", "@message" => '{ "@timestamp": "2014-06-07T01:53:14-07:00", "remote_addr": "66.249.67.102", "body_bytes_sent": 9943, "request_time": 0.770, "status": 200, "request_method": "GET", "scheme": "https", "server_name": "yoast.com", "request_uri": "/hire-us/website-review/", "document_uri": "/index.php", "http_user_agent": "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" }') do

      insist { subject["remote_addr"] } == "66.249.67.102"

      insist { subject["remote_addr_dns"] } == "crawl-66-249-67-102.googlebot.com"

    end
 
    sample("@type" => "googlebot", "@message" => '{ "@timestamp": "2014-06-08T00:17:39-07:00", "remote_addr": "66.249.69.125", "body_bytes_sent": 8146, "request_time": 0.832, "status": 200, "request_method": "GET", "scheme": "https", "server_name": "yoast.com", "request_uri": "/cat/wordpress/", "document_uri": "/index.php", "http_user_agent": "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" }') do

      insist { subject["remote_addr"] } == "66.249.69.125"

      insist { subject["remote_addr_dns"] } == "crawl-66-249-69-125.googlebot.com"

    end   

    
  end

end
