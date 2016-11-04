class golang (
	$version 		  = '1.7.3',
	$arch    		  = 'linux-amd64',
	$workspace 		  = '/usr/local/workspace',
	$download_dir     = '/tmp/golang',
	$download_timeout = 300,
) {
	package { 'git': }
	package { 'wget': }

	$download_url = "https://storage.googleapis.com/golang/go${version}.${arch}.tar.gz"
	$archive      = "go${version}.${arch}.tar.gz"

	$golang_profile_template = @(END)
GOPATH="<%= @workspace %>"
PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
export GOPATH PATH
	END

	exec { 'download':
		path    => '/bin:/usr/bin:/usr/local/bin',
		command => "wget ${download_url} -P ${download_dir}",
		timeout => $download_timeout,
		creates => "${download_dir}/${download_url}",
		unless  => "which go && go version | grep '${version}'",
    	require => Package['wget'],
	} ->

	exec { 'unarchive':
		path    => '/bin:/usr/bin:/usr/local/bin',
		command => "tar -C /usr/local -xzf ${download_dir}/${archive}",
    	onlyif  => "test -f ${download_dir}/${archive}",
	} ->

	exec { 'cleanup':
		path    => '/bin:/usr/bin:/usr/local/bin',
		command => "rm -f ${download_dir}/${archive}",
		onlyif  => "test -f ${download_dir}/${archive}",
	} ->

	file { '/etc/profile.d/golang.sh':
		content => inline_template($golang_profile_template),
		owner   => root,
		group   => root,
		mode    => 'a+x',
	} ->

	exec { 'install-godep':
		path    	=> '/bin:/usr/bin:/usr/local/bin:/usr/local/go/bin',
		environment => ["GOPATH=${workspace}"],
		command 	=> 'go get github.com/tools/godep',
		require 	=> Package['git'],
	}
}

include golang

package { 'vim': }
