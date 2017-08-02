namespace :memory_usage do
  desc "Measure the memory usage for a given object using Object::call"
  task :measure, [:class_name] => :environment do |_, args|
    class_name = args[:class_name] or fail "Oops! No class name specified."
    target_class = class_name.classify.constantize

    report = MemoryProfiler.report(top: 1) do
      puts "Running"
      target_class.send(:call)
    end
    puts "Done! Here are the results:\n"
    report.pretty_print
  end
end
