class Tweet < ActiveRecord::Base
  belongs_to :stock

  def get_tweets
    consumer_key ||= OAuth::Consumer.new "LXJkKuXoRJzeyQzAx0TGoCZli", "yL3P69PF41OUObm2dPVFQujVKpxeNdtqwKMSAzSyHopA1VQOu4"
    access_token ||= OAuth::Token.new "3085560635-6gwFUx4pavCbblpFtlibvO4JYdFn6G5ugZk0nPi", "4AnySTXszbZOA9t74M0tIoH3Z0rbCvcsqnYwgz9VnQTg1"

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    tweets = nil
    if response.code == '200' then
      tweets = JSON.parse(response.body)
      print_timeline(tweets)
    end
    nil
  end

end
