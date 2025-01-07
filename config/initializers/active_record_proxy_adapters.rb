require "active_record_proxy_adapters/log_subscriber"

ActiveRecordProxyAdapters.configure do |config|
  # How long proxy should reroute all read requests to primary after a write
  config.proxy_delay = 5.seconds # defaults to 2.seconds

  # How long proxy should wait for replica to connect.
  config.checkout_timeout = 5.seconds # defaults to 2.seconds

  config.log_subscriber_primary_prefix = "PRIMARY"
  config.log_subscriber_replica_prefix = "REPLICA"
end

ActiveRecord::LogSubscriber.detach_from :active_record