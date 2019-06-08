require_relative 'ldap_cli'

describe LdapCli do
  describe 'Creating CSV' do
    context 'using test data' do
      before(:each) do
        LdapCli.create_csv("sample_from_spec", [["cn", "sn", "mail", "uid", "homeDirectory", "uidNumber", "gidNumber"], ["common1", "surname1", "common1_surname1@test.com", "test1", "exampleDir", "1", "1"], ["common2", "surname2", "common2_surname2@test.com", "test2", "exampleDir", "2", "2"]])
      end

      it 'needs to generate a CSV file' do
        expect(File.file?("sample_from_spec.csv")).to be true
      end
    end
  end

  describe 'Creating CSV' do
    context 'with search results data using a filter' do
      before(:each) do
        LdapCli.search_ldap("common")
      end

      it 'needs to generate a CSV file' do
        expect(File.file?("ldap_search.csv")).to be true
      end
    end
  end
end