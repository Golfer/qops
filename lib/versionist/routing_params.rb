module Versionist
  module Routing
    def api_version_params(number, options = {})
      {
        module: "V#{number}",
        header: { name: 'Accept', value: "application/vnd.qops.com; version=v#{number}" },
        path: { value: "v#{number}" },
        parameter: { name: 'version', value: "v#{number}" }
      }.merge(options)
    end
  end
end
