require "bundler"
Bundler.setup

gemspec = eval(File.read("core_data.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["core_data.gemspec"] do
  system "gem build core_data.gemspec"
end
