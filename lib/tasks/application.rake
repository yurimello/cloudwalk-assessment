task :import, [:file_path] => :environment do |t, args|
  file = File.open(args.file_path, 'r')
  filename = File.basename(args.file_path)
  ImportGameLogService.call(file, filename)
end