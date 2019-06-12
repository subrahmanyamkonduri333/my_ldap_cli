# my_ldap_cli

my_ldap_cli is used to read/write data from/to LDAP. We can write data from a CSV to LDAP and also write data from LDAP to CSV using this program.

We need to install net-ldap gem to execute this program. Also, we need to install rspec gem in order to run the specs.

Setup OpenLDAP server and create node people by using the below reference:

https://help.ubuntu.com/lts/serverguide/openldap-server.html.en

Import data into LDAP using:

$ ldapadd -x -D "cn=root,dc=example,dc=com" -W -f data.ldif

Following command will generate a sample csv file, add sample csv contents to LDAP, performing search based on 'cn' attribute and will write search results to ldap_search csv file.

$ ruby sample.rb

To run the rspecs use below command:

$ rspec ldap_cli_rspec.rb

Following are the references used to develop the LDAP CLI program:

https://www.rubydoc.info/gems/ruby-net-ldap/Net/LDAP

https://www.tutorialspoint.com/ruby/ruby_ldap.htm
