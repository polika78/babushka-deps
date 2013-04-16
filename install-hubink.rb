dep "install hubink", :version do
	version.default!('1.3.4')
	requires "rubygems"
	met? {
		in_path "bundle >= #{version}"
	}
	meet {
		log_shell("Installing Bundler..#{version}", "gem install bundler")
	}
end
