require "test_utils"
require "logstash/filters/grok"

describe LogStash::Filters::Grok do
  extend LogStash::RSpec

  config <<-CONFIG
    filter {
      #{File.read("target/100-googlebot-maxcdn.conf")}
    }
  CONFIG

  describe "Parse MaxCDN Googlebot JSON" do

    sample("@type" => "googlebot-maxcdn", "@message" => '{"bytes":0,"client_asn":"AS16509 Amazon.com, Inc.","client_city":"-","client_continent":"EU","client_country":"IE","client_dma":"0","client_ip":"54.247.60.162","client_latitude":53,"client_longitude":-8,"client_state":"-","company_id":85,"cache_status":"MISS","hostname":"cdn.yoast.com","method":"HEAD","origin_time":0.471,"pop":"lhr","protocol":"HTTP\/1.1","query_string":"","referer":"-","scheme":"https","status":200,"time":"2014-07-01T05:10:50.388Z","uri":"\/wp-content\/uploads\/2007\/12\/blogmetrics02.png","user_agent":"Googlebot\/2.1 (+http:\/\/www.google.com\/bot.html)","zone_id":33008}') do

      #puts subject.to_yaml # for debugging

      insist { subject["@type"] } == "googlebot-maxcdn"
      insist { subject["@timestamp"] } == Time.iso8601("2014-07-01T05:10:50.388Z")

      # Add more insists here
      # insist { subject["uri"] } == "/wp-content/uploads/2007/12/blogmetrics02.png"
      
    end

  end



end
