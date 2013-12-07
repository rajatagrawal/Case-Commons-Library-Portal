require 'spec_helper'

describe 'routes for application controller' do
  it 'routes /error to application#error' do
    expect(get('error')).to route_to(controller: 'application', action: 'error')
  end
end
