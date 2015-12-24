CarrierWave.configure do |config|
  # config.ignore_integrity_errors = false
  # config.ignore_processing_errors = false
  # config.ignore_download_errors = false

  config.storage = :upyun
  config.upyun_username = "bqqqq"
  config.upyun_password = 'qwertyuiop'
end
