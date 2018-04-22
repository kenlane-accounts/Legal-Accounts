class Company
  def self.current_company_id=(id)
    Thread.current[:current_company_id] = id
  end

  def self.current_company_id
    Thread.current[:current_company_id]
  end
end