class DailyDigest
  include Sidekiq::Worker
  include Sidetiq::Schedulabel

  recurrence { daily(1) }

  def perform
    User.send_daily_digest
  end
end