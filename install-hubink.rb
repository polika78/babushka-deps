dep 'install hubink' do
	requires [
		'path permission',
		'xcode commandline install',
		'homebrew',
		'rvm'.with("1.19.5"),
		'rvm bash'.with("1.19.5"),
		'ruby'.with("2.0.0"),
		'bundler'.with("1.3.4"),
		'cmake',
		'mysql',
		'install sequel pro',
		'myadbox',
		'bundle install',
		'pow',
		'pow start',
		'myadbox db init',
		'myadserver',
		'myadscripts',
		'nodejs'.with("v0.10.4"),
		'coffee-script'.with("1.6.2"),
		'java se',
		'sikuli',
		'indesign',
		'apache-MAMP',
		'dropbox'
	]
end

dep 'path permission' do
	path = '/usr/local/*'
	# met? {
	# 	result = false
	# 	paths.each do |path|
	# 		log("path permission chek #{path}")
	# 		result = File.writable?(path)
	# 		puts result
	# 		if result
	# 			log("already set path permission of #{path}")
	# 		else
	# 			log("need path permission of #{path}")
	# 		end
	# 	end
	# 	result
	# }
	# meet {
	# 	paths.each do |path|
	log_shell("Change permission of #{path}","echo volder | sudo -S chown -R hubink #{path}")
	# 	# end
	# }
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
	met? { 
		which 'llvm-gcc-4.2' 
	}
	meet {
		#log_shell("Install xcode","echo volder | sudo -S installer -pkg  ~/Downloads/DeveloperToolsCLI.pkg -target /")
		log_shell("Install xcode","echo volder | sudo -S installer -pkg  ~/Downloads/GCC-10.7-v2.pkg -target /")
		#source "https://s3-ap-southeast-2.amazonaws.com/myadbox-resources/DeveloperToolsCLI.pkg"
	}
end

dep 'rvm', :version do
	met? {
		"~/.rvm".p.exists?
	}
	meet {
		log_shell("Installing rvm..#{version}","curl -L https://get.rvm.io | bash -s -- --version #{version}")

	}
end

dep 'rvm bash', :version do
	met?{
		in_path? "rvm >= #{version}"
	}
	meet {
		log("Source bash")
		system("sh -c \"\`source \~\/.bash_profile\`\"")
	}
end

dep 'ruby', :version do
	met? {
		in_path? "ruby >= #{version}0p"
	}
	meet {
		#log_shell("Make sure latest RVM..","rvm get stable --autolibs=enable")
		log_shell("Installing ruby..#{version}","rvm install #{version} --autolibs=enable")
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

dep 'install sequel pro' do
	met? {
		"/Applications/Sequel\ Pro.app".p.exists?
	}
	meet {
		log("Installing Sequel Pro..")
		shell "curl -O http://sequel-pro.googlecode.com/files/sequel-pro-1.0.1.dmg"
		shell "hdiutil attach sequel-pro-1.0.1.dmg"
		#source("http://sequel-pro.googlecode.com/files/sequel-pro-1.0.1.dmg")
		shell('echo volder | sudo -S cp -Rfp /Volumes/Sequel\ Pro\ 1.0.1/ /Applications/')
		shell 'hdiutil detach /Volumes/Sequel\ Pro\ 1.0.1/'
	}
end

dep 'myadbox' do
	met? {
		"~/dev/myadbox".p.exists?
	}
	meet {
		log_shell("Cloning myadbox...","git clone git@github.com:myadbox/myadbox.git \~\/dev/myadbox")
	}
end

dep 'bundle install' do
	log_shell("Bundler installing...","bundle install --gemfile=\"\~/dev/myadbox/Gemfile\"")
end

dep 'pow' do
	met? {
		"~/Library/Application Support/Pow".p.exists?
	}
	meet {
		log_shell("Installing Pow...","echo volder | sudo -S curl get.pow.cx | sh")
	}
end

dep 'pow start' do
	met? {
		"~/.pow/myadbox".p.exists?
	}
	meet {
		log_shell("Start myadbox...","echo volder | sudo -S ln -s ~/dev/myadbox ~/.pow/myadbox")
	}
end

dep 'myadbox db init' do
	log_shell("myadbox_db create..","(cd ~/dev/myadbox && exec rake db:setup)")
	log_shell("myadbox_db migrate..","(cd ~/dev/myadbox && exec rake db:migrate)")
end

dep 'myadserver' do
	met? {
		"~/dev/myadserver".p.exists?
	}
	meet {
		log_shell("Cloning myadserver...","git clone git@github.com:myadbox/myadserver.git \~\/dev/myadserver")
	}
end

dep 'myadscripts' do
	met? {
		"~/dev/myadscripts".p.exists?
	}
	meet {
		log_shell("Cloning myadscripts...","git clone git@github.com:myadbox/myadscripts.git \~\/dev/myadscripts")
	}
end

dep 'nodejs', :version do
	met?{
		in_path? "node >= #{version}"
	}
	meet {
		log_shell("Install nodejs","echo volder | sudo -S installer -pkg  ~/Downloads/node-v0.10.4.pkg -target /")
	}
end

dep 'coffee-script', :version do
	met?{
		in_path? "coffee >= #{version}"
	}
	meet {
		log_shell("coffee scripts installing...","echo volder | sudo npm install -g coffee-script")
		log_shell("build script files in myadscripts...","(cd ~/dev/myadscripts && exec rake build)")
	}
end
dep 'java se' do
	met? {
		in_path{"java >= 1.6.0_45"}
	}
	meet {
		log_shell("Install java se..",'echo volder | sudo -S installer -pkg  ~/Downloads/Java\ 7\ Update\ 21.pkg -target /')
	}
end

dep 'sikuli' do
	met? {
		'/Applications/Sikuli-IDE.app'.p.exists?
	}
	meet {
		log("sikuli installing")
		shell('echo volder | sudo -S cp -Rfp ~/Downloads/Sikuli-IDE.app /Applications/')
	}
end

dep 'indesign' do
	met?{
		'/Applications/Adobe\ InDesign\ CS6\ Server/'.p.exists?
	}
	meet {
		log("Installing Indesign Server..")
		shell 'hdiutil attach ~/Downloads/InDesignServer_8_LS18.dmg'
		#source("http://sequel-pro.googlecode.com/files/sequel-pro-1.0.1.dmg")
		shell 'open -a /Volumes/Adobe\ InDesign\ CS6\ Server/Adobe\ InDesign\ CS6\ Server/Install.app'
		shell 'open -g /Applications/Sikuli-IDE.app --args ~/Downloads/Indesign-Install.sikul'
		#shell 'hdiutil detach /Volumes/Adobe\ InDesign\ CS6\ Server'
	}
end

dep 'dropbox' do
end

dep 'apache-MAMP' do
	met? {
		'/Applications/MAMP/'.p.exists?
	}
	meet {
		log_shell("Install nodejs","echo volder | sudo -S installer -pkg  ~/Downloads/MAMP_2.1.4.pkg -target /")
	}
end

dep 'apache-MAMP start' do
	httpdconf = File.read("/Applications/MAMP/conf/apache/httpd.conf")
	File.open("/Applications/MAMP/conf/apache/httpd.conf",'w') do |f|
		f.write(httpdconf.gsub("/Applications/MAMP/htdocs","/Library/WebServer/Documents"))
	end
	log_shell("Start MAMP..","/Applications/MAMP/bin/start.sh")
end


