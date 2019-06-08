class LdapCli
  require 'rubygems'
  require "csv"
  require 'net/ldap'

  # Creating CSV file from the input

  def self.create_csv(file_name, contents)
    csv = CSV.open("#{file_name}.csv", "w") do |csv|
      contents.each do |content|
        csv << content
      end
    end
  end

  # Authenticate with LDAP

  def self.authenticate
    ldap = Net::LDAP.new host: 'localhost',
                         port: 389,
                         auth: {
                          method: :simple,
                          username: 'cn=root,dc=example,dc=org',
                          password: 'testp@sswd'
                        }
  end

  # Parsing data from CSV file and adding attributes to ldap

  def self.add_entries_from_csv(file_name)
    ldap = LdapCli.authenticate
    if ldap.bind
      begin
        CSV.foreach("#{(file_name)}.csv", headers: true) do |csv|
          dn = "cn=#{csv['cn']}, ou=people, dc=example, dc=org"
          attributes = csv.to_h
          attributes['objectclass'] = ['OrgPerson']

          @ldap.add(dn: dn, attributes: attributes)
          if @ldap.get_operation_result['message'] == 'Success'
            puts "Successfully added #{csv['cn']} #{ldap.get_operation_result['message']}"
          else
            puts "Error while adding #{csv['cn']} #{ldap.get_operation_result['message']}"
          end
        end
        ldap.unbind
      rescue
        ldap.perror("Issue while adding ldap attributes.")
      end
    else
      puts "Issue with Ldap connection"
    end
  end

  # Search LDAP using a command line input

  def self.search_ldap(param)
    ldap = LdapCli.authenticate

    search_results = []
    filter = Net::LDAP::Filter.eq( "cn", "#{param}*" )
    treebase = "dc=example,dc=org"

    if ldap.bind
      begin
        search_results << ["cn", "sn", "mail", "uid", "homeDirectory", "uidNumber", "gidNumber"]
        ldap.search( :base => treebase, :filter => filter ) do |entry|
          search_results << ["#{entry.cn}", "#{entry.sn}", "#{entry.mail}", "#{entry.uid}", "#{entry.homeDirectory}", "#{entry.uidNumber}", "#{entry.gidNumber}"]
        end
        search_results
        ldap.unbind
        LdapCli.create_csv("ldap_search", search_results) if search_results.size > 0
        puts "Please find the search results in ldap_search.csv file."
      rescue
        ldap.perror("Issue while performing ldap search.")
      end
    else
      puts "Issue with Ldap connection"
    end
  end
end