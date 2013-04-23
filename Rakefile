require "bundler"
Bundler.setup

gemspec = eval(File.read("core-data.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["core-data.gemspec"] do
  system "gem build core-data.gemspec"
end
