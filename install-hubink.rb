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
		log "Install Command Line Tools for Xcode."
		log "xcode gcc-installer for xos 10.7 at http://cloud.github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.7-v2.pkg"
		shell "installer -pkg \"\`curl -O http://cloud.github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.7-v2.pkg\`\" -target /"
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
		in_path? "ruby >= #{version}0p"
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