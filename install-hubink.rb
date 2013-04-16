dep 'install hubink' do
	requires [
		'bundler'
		'rubygems'
		'homebrew'
		'mysql'
		'pow'
		'myadbox'
		'myadserver'
		'nodejs'
		'myadscripts'
		'indesign'
		'dropbox'
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