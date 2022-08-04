class MyRailtie < Rails::Railtie
  server do
    Sidekiq.start
  end
end