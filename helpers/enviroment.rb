def production?
  ENV.fetch('RACK_ENV') == 'production'
end
