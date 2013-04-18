dep 'install hubink' do
	requires [
		#'path permission',
		'xcode commandline install',
		'homebrew',
		'rvm'.with("1.19.0"),
		'ruby'.with("2.0.0"),
		'bundler'.with("1.3.4"),
		'cmake',
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

dep 'path permission' do
	paths = ['/usr/bin','/Library'] 
	met? {
		result = false
		paths.each do |path|
			log("path permission chek #{path}")
			result = File.writable?(path)
			puts result
			if result
				log("already set path permission of #{path}")
			else
				log("need path permission of #{path}")
			end
		end
		result
	}
	meet {
		paths.each do |path|
			log_shell("Change permission of #{path}","echo volder | sudo -S chown -R hubink #{path}")
		end
	}
end

dep 'bundler', :version do
	met? {
		in_path? "bundle >= #{version}"
	}
	meet {
		log_shell("Installing Bundler..#{version}","gem install bundler")
	}
end

dep 'xcode commandline install', :template => 'installer' do
	# expects %w[cc gcc c++ g++ llvm-gcc llvm-g++ clang] # compilers
	# expects %w[ld libtool] # linkety link
	# expects %w[make] # configure and build tools
	# expects %w[cpp m4 nasm yacc bison] # misc - the preprocessor, assembler, grammar stuff
	# otherwise {
	# 	log "Install Command Line Tools for Xcode."
	# 	log "https://s3-ap-southeast-2.amazonaws.com/myadbox-resources/DeveloperToolsCLI.pkg"
	# 	#source "https://s3-ap-southeast-2.amazonaws.com/myadbox-resources/xcode461_cltools_10_86938245a.dmg"
	# 	shell "\"\`curl -O https://s3-ap-southeast-2.amazonaws.com/myadbox-resources/DeveloperToolsCLI.pkg\`\""
	# 	#shell "\"\`curl -O http://cloud.github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.7-v2.pkg\`\""
	# 	shell "sudo installer -pkg  DeveloperToolsCLI.pkg -target /"
	# }
	source "https://s3-ap-southeast-2.amazonaws.com/myadbox-resources/DeveloperToolsCLI.pkg"
end

dep 'rvm', :version do
	met? {
		"/usr/local/rvm/scripts/rvm".p.file?
	}
	meet {
		log_shell("Installing rvm..#{version}","curl -L https://get.rvm.io | bash -s -- --version #{version}")
		
	}
end

dep 'ruby', :version do
	met? {
		in_path? "ruby >= #{version}0p"
	}
	meet {
		log_shell("Make sure latest RVM..","rvm get stable --autolibs=enable")
		log_shell("Installing ruby..#{version}","rvm install #{version} ")
		log_shell("Set ruby-#{version} as default","rvm --default use #{version}")
	}
end
dep 'cmake' do
	met? {
		"/usr/local/opt/cmake".p.exists?
	}
	meet {
		log_shell("Installing cmake... by homebrew", "brew install cmake")
	}
end

dep 'mysql' do
	met? {
		"/usr/local/var/mysql".p.exists?
	}
	meet {
		log_shell("Installing MySQL... by homebrew","brew install mysql")
		log_shell("Starting mysql","mysql.server start")
		log_shell("Setting root password","mysqladmin -u root password 'new-password'")
	}
end

dep 'pow' do
	met? {
		"~/Library/Application\ Support/Pow".p.exists?
	}
	meet {
		log_shell("Installing Pow...","sh -c \"\`curl get.pow.cx\`\"")
	}
end

dep 'myadbox' do
	log_shell("Cloning myadbox...","git clone git@github.com:myadbox/myadbox.git")
	log_shell("Bundler installing...","bundle install")
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