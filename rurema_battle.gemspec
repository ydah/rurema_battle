# frozen_string_literal: true

require_relative "lib/rurema_battle/version"

Gem::Specification.new do |spec|
  spec.name = "rurema_battle"
  spec.version = RuremaBattle::VERSION
  spec.authors = ["ydah"]
  spec.email = ["t.yudai92@gmail.com"]

  spec.summary = "🎮 A game in which you enter the name of the class and compete for the number of letters on rurima's page."
  spec.description = "RuremaBattle is a game in which you enter the name of the class and compete for the number of letters on rurima's page. The more letters you have, the more powerful you are. Let's compete with your friends and see who can get the most letters!"
  spec.homepage = "https://github.com/ydah/rurema_battle"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5"

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = spec.homepage
  spec.metadata['documentation_uri']     = spec.homepage
  spec.metadata['changelog_uri']         = "#{spec.homepage}/releases"
  spec.metadata['bug_tracker_uri']       = "#{spec.homepage}/issues"
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
