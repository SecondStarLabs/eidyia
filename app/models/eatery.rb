class Eatery < ApplicationRecord
  belongs_to :city

  def sync_with_crm
    if self.website.blank?
      _update_blank_website_to_unique_placeholder
    end
    company = Crm::Company.new

    # newco = company.create("Fake Test Co Too", {website: "faketestcotoo.com"})
    # crm_company = 
    company.create_or_find_by_domain(domain_name)
  end

  def _update_blank_website_to_unique_placeholder
    base_domain = "bayarea.pizza"
    domain = [self.name.parameterize.downcase, base_domain].join(".")
    self.website = domain
    self.save!
    self
  end
end
