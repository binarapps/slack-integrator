namespace :generate do
  desc 'Generate a timestamped, empty Sequel migration.'
  # based on https://gist.github.com/DevL/4285948
  task :migration, :name do |_, args|
    if args[:name].nil?
      puts 'You must specify a migration name (e.g. rake generate:migration[create_events])!'
      exit false
    end

    migration_name = args[:name].downcase.split.join('_') # remove whitespace
    content = "Sequel.migration do\n  up do\n    \n  end\n\n  down do\n    \n  end\nend\n"
    timestamp = DateTime.now.strftime('%Y%m%d%H%M%S')
    filename = File.join(
      File.dirname(File.dirname(File.expand_path(__FILE__))), 
      'migrations',
      "#{timestamp}_#{migration_name}.rb")

    File.open(filename, 'w') do |f|
      f.puts content
    end

    puts "Created the migration #{filename}"
  end
end

