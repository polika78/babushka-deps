dep 'install hubink' do
	requires [
		'bundler',
		'xcode commandline tools',
		'homebrew',
		'rvm',
		'ruby',
		'mysql',
		'pow',
		'myadbox',
		'myadserver',
		'nodejs',
		'myadscripts',
		'indesign',
		'dropbox',
		'apache-MAMP'
	]
end

dep 'bundler', :version do
	version.default!('1.3.4')
	met? {
		in_path? "bundle >= #{version}"
	}
	meet {
		log_shell("Installing Bundler..#{version}","gem install bundler")
	}
end

dep 'xcode commandline tools', :template => 'external' do
	expects %w[cc gcc c++ g++ llvm-gcc llvm-g++ clang] # compilers
	expects %w[ld libtool] # linkety link
	expects %w[make] # configure and build tools
	expects %w[cpp m4 nasm yacc bison] # misc - the preprocessor, assembler, grammar stuff
	otherwise {
		log "Install Command Line Tools for Xcode, and then run Babushka again."
		log "Official pacakge at http://developer.apple.com/downloads"
		confirm "Open in browser now" do
			shell "open http://developer.apple.com/downloads"
		end
	}
end

dep 'rvm', :version do
	version.default!('1.19.0')
	met? {
		"/usr/local/rvm/scripts/rvm".p.file?
	}
	meet {
		log_shell("Installing rvm..#{version}","curl -L https://get.rvm.io | bash -s -- --version #{version}")
	}
end

dep 'ruby', :version do
	version.default!('2.0.0')
	met? {
		in_path? "ruby >= #{version}"
	}
	meet {
		log_shell("Installing ruby..#{version}","rvm install ruby-#{version}")
	}
end

dep 'mysql' , :version do

end

dep 'pow' do
end

dep 'myadbox' do
end

dep 'myadserver' do
end

dep 'nodejs' do
end

dep 'myadscripts' do
end

dep 'indesign' do
end

dep 'dropbox' do
end

dep 'apache-MAMP' do
end