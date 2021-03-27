class Crm::Company
        # KEY             = Rails.application.credentials.dig(:hubspot)[:access_key_id]

        attr_reader :company, :crm_company

    def initialize(client: Crm::Client.new, connection: Crm::Connection.new)
        @client         = client
        @connection     = connection        
        @crm_service    = @connection.activate_service(api_key: client.key)
        @crm_company    = @crm_service::Company
    end


    ## data methods
    # d = Hubspot::Company.create!("raptors", {domain: "raptors.com"})
    # found so far -- :batch_update!, :all, :all_with_offset, :add_contact!, :find_by_domain, :create!, :find_by_id
    ## public methods
# => [:batch_update!, :all, :all_with_offset, :add_contact!, :find_by_domain, :create!, :find_by_id,  :superclass, :json_creatable?, :descendants, :new, :class_attribute, :pretty_print, :thread_mattr_reader, :thread_cattr_reader, :thread_mattr_writer, :method_visibility, :thread_cattr_writer, :parents, :thread_cattr_accessor, :thread_mattr_accessor, :module_parent, :module_parents, :included_modules, :include?, :name, :ancestors, :attr, :attr_reader, :attr_writer, :attr_accessor, :instance_methods, :public_instance_methods, :protected_instance_methods, :private_instance_methods, :constants, :const_get, :const_set, :const_defined?, :class_variables, :remove_class_variable, :class_variable_get, :class_variable_set, :class_variable_defined?, :public_constant, :private_constant, :deprecate_constant, :singleton_class?, :include, :module_exec, :module_eval, :class_eval, :class_exec, :remove_method, :undef_method, :method_defined?, :<, :alias_method, :>, :private_class_method, :protected_method_defined?, :public_method_defined?, :private_method_defined?, :instance_method, :public_class_method, :autoload?, :delegate, :deprecate, :pretty_print_cycle, :public_instance_method, :define_method, :autoload, :silence_redefinition_of_method, :redefine_singleton_method, :rake_extension, :<=>, :<=, :>=, :==, :===, :alias_attribute, :parent_name, :mattr_reader, :cattr_reader, :mattr_writer, :cattr_writer, :cattr_accessor, :freeze, :inspect, :prepend, :const_missing, :parent, :remove_possible_method, :remove_possible_singleton_method, :autoload_without_bootsnap, :mattr_accessor, :attr_internal_reader, :attr_internal_writer, :attr_internal_accessor, :attr_internal, :to_s, :delegate_missing_to, :module_parent_name, :anonymous?, :redefine_method, :concerning, :concern, :guess_for_anonymous, :unloadable, :require_dependency, :to_json, :blank?, :html_safe?, :deep_dup, :acts_like?, :duplicable?, :to_param, :to_query, :present?, :presence, :dclone, :instance_values, :to_yaml, :instance_variable_names, :as_json, :in?, :presence_in, :with_options, :pretty_print_inspect, :pretty_print_instance_variables, :friendly_id?, :unfriendly_id?, :try, :try!, :load_dependency, :require_or_load, :instance_variable_defined?, :remove_instance_variable, :instance_of?, :kind_of?, :is_a?, :tap, :instance_variable_set, :protected_methods, :instance_variables, :instance_variable_get


    def all(opts = {})
        crm_company.all(opts = {})
    end

    def find_by_domain(domain_name)
        # as of 8/22/20, this is the only search method provided by hubspot
        crm_company.find_by_domain(domain_name)
    end

    def create(name, opts = {})
        crm_company.create!(name, opts)
        # properties available ["country", "city", "num_associated_contacts", "timezone", "facebook_company_page", "description", "hs_num_blockers", "industry", "total_money_raised", "web_technologies", "numberofemployees",  "linkedin_company_page", "hs_analytics_source", "num_contacted_notes", "annualrevenue", "founded_year", "state", "linkedinbio", "zip", "website", "address", "first_contact_createdate", "twitterhandle",   "hs_num_decision_makers", "notes_last_contacted", "phone", "domain", "hs_num_child_companies", "hs_num_contacts_with_buying_roles", "hs_object_id", "is_public", "name", "hs_analytics_source_data_2", "hs_analytics_source_data_1", "hs_sales_email_last_replied"]
    end

    def update(company, opts = {})
        companies = [company]
        crm_company.batch_update(companies, opts = {})
    end

    # def find_or_create_by(attributes, &block)
    #     find_by(attributes) || create(attributes, &block)
    # end

    def create_or_find_by_domain(domain_name:, 
        name:,
        attributes: {})

        attributes.merge(domain: domain_name)
        result = find_by_domain(domain_name).first ||  create(name, {website: domain_name})
    end
end
