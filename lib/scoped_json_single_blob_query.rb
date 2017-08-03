class ScopedJsonSingleBlobQuery
  def self.call
    company = Financial.where(company: '10001', year: 2010)
                            .select("data->1 AS data").first
    data = company.data
    # data.sort_by { |_,v| v['value'].to_i }
    p data
  end
end
