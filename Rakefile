require "gemsmith/rake/setup"
Dir.glob("lib/tocer/tasks/*.rake").each { |file| load file }

task default: %w(spec rubocop)
