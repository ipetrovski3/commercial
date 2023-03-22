class ApplePayController < ApplicationController
  def apple_developer_merchantid_domain_association
    render file: 'public/.well-known/apple-developer-merchantid-domain-association'
  end
end
