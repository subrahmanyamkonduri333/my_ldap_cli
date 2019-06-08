require_relative 'ldap_cli'

LdapCli.create_csv("sample", [["cn", "sn", "mail", "uid", "homeDirectory", "uidNumber", "gidNumber"], ["common1", "surname1", "common1_surname1@test.com", "test1", "exampleDir", "1", "1"], ["common2", "surname2", "common2_surname2@test.com", "test2", "exampleDir", "2", "2"]])

LdapCli.add_entries_from_csv("sample")
puts "Enter search parameter for common name"
param = gets.chomp
LdapCli.search_ldap(param)