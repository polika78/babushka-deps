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
		'clone myadbox',
		'clone myadserver',
		'clone myadscripts',
		'clone indesign',
		'bundle install',
		'pow',
		'pow start',
		'myadbox db init',
		'myadbox db import',
		'nodejs'.with("v0.10.4"),
		'coffee-script'.with("1.6.2"),
		'myadscripts build',
		'java se',
		#'sikuli',
		#'indesign',
		#'dropbox',
		'apache-MAMP',
		'apache-MAMP start',
		#CI Server
		'tomcat 7',
		'teamcity',
		"import build project",
		'teamcity build agent',
		'teamcity server start',
		'indesign server start'
	]
end

dep 'path permission' do
	path = '/usr/local/*'
	log_shell("Change permission of #{path}","echo volder | sudo -S chown -R hubink #{path}")
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
		log_shell("Install xcode","echo volder | sudo -S installer -pkg  ~/Setup_package/GCC-10.7-v2.pkg -target /")
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
		log("setting auto start")
		shell("echo volder | sudo -S cp com.mysql.mysqld.plist /Library/LaunchDaemons")
		shell("echo volder | sudo -S chown -R hubink /Library/LaunchDaemons/*")
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
		shell('echo volder | sudo -S cp -Rfp /Volumes/Sequel\ Pro\ 1.0.1/ /Applications/')
		shell 'hdiutil detach /Volumes/Sequel\ Pro\ 1.0.1/'
	}
end

dep 'clone myadbox' do
	met? {
		"~/dev/myadbox".p.exists?
	}
	meet {
		log_shell("Cloning myadbox...","git clone git@github.com:myadbox/myadbox.git \~\/dev/myadbox")
	}
end

dep 'clone myadserver' do
	met? {
		"~/dev/myadserver".p.exists?
	}
	meet {
		log_shell("Cloning myadserver...","git clone git@github.com:myadbox/myadserver.git \~\/dev/myadserver")
	}
end

dep 'clone myadscripts' do
	met? {
		"~/dev/myadscripts".p.exists?
	}
	meet {
		log_shell("Cloning myadscripts...","git clone git@github.com:myadbox/myadscripts.git \~\/dev/myadscripts")
	}
end

dep 'clone indesign' do
	met? {
		"~/dev/indesign".p.exists?
	}
	meet {
		log_shell("Cloning indesign...","git clone git@github.com:myadbox/indesign.git \~\/dev/indesign")
	}
end

dep 'bundle install' do
	log_shell("Bundler installing...","(cd ~/dev/myadbox && exec bundle install)")
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
	log_shell("Starting mysql..","mysql.server start")
	log_shell("myadbox_db create..","(cd ~/dev/myadbox && exec rake db:setup)")
end

dep 'myadbox db import' do
	if File.exists? "#{Dir.home}/dev/myadbox/db/base.sql"
		log("base.sql file exists..")
		log_shell("delete base.sql..","echo volder|sudo -S rm -rf ~/dev/myadbox/db/base.sql")
	end
	log_shell("unzip sql file..", "(cd ~/dev/myadbox/db && exec gunzip -c base.sql.gz > base.sql)")
	log_shell("Importing myadbox_development db","(cd ~/dev/myadbox/db && exec mysql -u root --password=new-password myadbox_development < base.sql)")
	log_shell("myadbox_db migrate..","(cd ~/dev/myadbox && exec rake db:migrate)")
end

dep 'nodejs', :version do
	met?{
		in_path? "node >= #{version}"
	}
	meet {
		log_shell("Install nodejs","echo volder | sudo -S installer -pkg  ~/Setup_package/node-v0.10.4.pkg -target /")
	}
end

dep 'coffee-script', :version do
	met?{
		in_path? "coffee >= #{version}"
	}
	meet {
		log_shell("coffee scripts installing...","echo volder | sudo npm install -g coffee-script")
	}
end

dep 'myadscripts build' do
	log_shell("myadscripts build script files in myadscripts...","(cd ~/dev/myadscripts && exec rake build)")
end

dep 'java se' do
	met? {
		"/Library/Java/Home".p.exists?
	}
	meet {
		log_shell("Install java se..",'echo volder | sudo -S installer -pkg  ~/Setup_package/JavaForOSX.pkg -target /')
	}
end

dep 'sikuli', :template => 'installer' do
	met? {
		'/Applications/Sikuli-IDE.app'.p.exists?
	}
	meet {
		log("sikuli installing")
		shell('echo volder | sudo -S cp -Rfp ~/Setup_package/Sikuli-IDE.app /Applications/')
	}
end

dep 'indesign' do
	met?{
		'/Applications/Adobe\ InDesign\ CS6\ Server/InDesignServer'.p.exists?
	}
	meet {
		log("Installing Indesign Server..")
		shell 'hdiutil attach ~/Setup_package/InDesignServer_8_LS18.dmg'
		shell 'open -a /Volumes/Adobe\ InDesign\ CS6\ Server/Adobe\ InDesign\ CS6\ Server/Install.app'
		shell 'touch /tmp/installing_indesign'
		shell 'open -g /Applications/Sikuli-IDE.app --args ~/Setup_package/Indesign-Install.skl'
		count = 0
		while File.exists? "/tmp/installing_indesign"
			count = count + 1
			if(count%10000 == 0)
				log(".")
			end
		end
		shell 'hdiutil detach /Volumes/Adobe\ InDesign\ CS6\ Server'
	}
end

dep 'dropbox' do
	met? {
		'/Applications/Dropbox.app'.p.exists?
	}
	meet {
		log("Dropbox installing")
		shell 'touch /tmp/installing_dropbox'
		shell('echo volder | sudo -S cp -Rfp ~/Setup_package/Dropbox.app /Applications/')
		shell 'open -a /Applications//Dropbox.app'
		shell 'open -g /Applications/Sikuli-IDE.app --args ~/Setup_package/Dropbox-Install.skl'
		count = 0
		while File.exists? "/tmp/installing_dropbox"
			count = count + 1
			if(count%40 == 0)
				log(".")
			end
		end
	}
end

dep 'apache-MAMP' do
	met? {
		'/Applications/MAMP/'.p.exists?
	}
	meet {
		log_shell("Install MAMP","echo volder | sudo -S installer -pkg  ~/Setup_package/MAMP_2.1.4.pkg -target /")
	}
end

dep 'apache-MAMP start' do
	httpdconf = File.read("/Applications/MAMP/conf/apache/httpd.conf")
	File.open("/Applications/MAMP/conf/apache/httpd.conf",'w') do |f|
		httpdconf = httpdconf.gsub("/Applications/MAMP/htdocs","/Library/WebServer/Documents")
		f.write(httpdconf.gsub("severin","hubink"))
		f.close
	end
	log_shell("Start MAMP..","/Applications/MAMP/bin/start.sh")
	if File.exists? "#{Dir.home}/Dropbox"
		log("Drobox folder will be symbolic linked...")
		if File.exists? "/Library/WebServer/Documents/vw"
			log("Already exists Symlink of /Libray/WebServer/Documents/vw")
		else
			log_shell("Linking /Library/WebServer/Documents/vw folder","echo volder | sudo -S ln -s ~/Dropbox/myadbox /Library/WebServer/Documents/vw")	
		end
		if File.exists? "/Library/WebServer/Documents/vw/production_templates"
			log("Already exists Symlink of ~/Dropbox/myadbox/production_templates")
		else
			log_shell("Linking Document folder","echo volder | sudo -S ln -s ~/Dropbox/myadbox/templates ~/Dropbox/myadbox/production_templates")	
		end
	else
		log("Dropbox is not installed")
	end
end

dep 'indesign server start' do
	if File.exists? '/Applications/Adobe\ InDesign\ CS6\ Server/InDesignServer'
		config = File.read("#{Dir.home}/dev/myadbox/config/config.yml")
		File.open("#{Dir.home}/dev/myadbox/config/config.yml",'w') do |f|
			f.write(config.gsub("/Volumes/Hubink/myadscripts/build/indesign/server","#{Dir.home}/dev/myadscripts/build/indesign/server"))
			f.close
		end
		shell '/Applications/Adobe\ InDesign\ CS6\ Server/IndesignServer -port 12345'
	else
		log("InDesign Server is not installed")
	end
end

#CI Setting with TeamCity
dep "tomcat 7" do
	met? {
		"/Library/Tomcat".p.exists?
	}
	meet {
		unless File.exists? "/usr/local/apache-tomcat-7.0.39"
			log_shell("unzip apache-tomcat-7.0.39.tar","tar xvf apache-tomcat-7.0.39.tar")
			log_shell("move to /usr/local","echo volder | sudo -S mv ~/Setup_package/apache-tomcat-7.0.39 /usr/local")
		end
		log_shell("make symlink /Library/Tomcat","echo volder | sudo -S ln -s /usr/local/apache-tomcat-7.0.39 /Library/Tomcat")
		log("changing permission")
		shell("echo volder | sudo -S chown -R hubink /Library/Tomcat")
		shell("echo volder | sudo -S chmod +x /Library/Tomcat/bin/*.sh")
	}
end

dep "teamcity" do
	met? {
		"/Library/TeamCity".p.exists?
	}
	meet {
		unless File.exists? "/usr/local/TeamCity"
			log_shell("unzip TeamCity-7.1.5.tar.gz","gzip -d < TeamCity-7.1.5.tar.gz | tar xvf -")
			log("installing..")
			shell("echo volder | sudo -S mv ~/Setup_package/TeamCity /usr/local")
		end
		shell("echo volder | sudo -S ln -s /usr/local/TeamCity /Library/TeamCity")
		shell("echo volder | sudo -S chown -R hubink /Library/TeamCity")
		shell("echo volder | sudo -S chmod +x /Library/TeamCity/bin/*.sh")
	}
end

dep "import build project" do
	met? {
		"~/.BuildServer/config/myadbox".p.exists?
	}
	meet {
		log("myadbox build configuration importing..")
		shell("unzip ~/Setup_package/.BuildServer.zip -d ~/")
		shell("echo volder | sudo chown -R hubink ~/.BuildServer")
	}
end

dep "teamcity build agent" do
	log_shell("Start TeamCity build agent","/Library/TeamCity/buildAgent/bin/agent.sh start")
	log("Auto start setup")
	shell("echo volder |sudo -S cp jetbrains.teamcity.BuildAgent.plist /Library/TeamCity/buildAgent/bin")
	shell("echo volder | sudo -S chmod +x /Library/TeamCity/buildAgent/launcher/bin/*")
	shell("/Library/TeamCity/buildAgent/bin/mac.launch.sh load")
end

dep "teamcity server start" do
	log_shell("Start TeamCity server","/Library/TeamCity/bin/teamcity-server.sh start")
	log("Teamcity Server Auto start setup")
	shell("echo volder |sudo -S cp jetbrains.teamcity.server.plist /Library/LaunchDaemons")
	shell("launchctl load /Library/LaunchDaemons/jetbrains.teamcity.server.plist")
end



