require 'spec_helper'

describe 'routes for users' do

  it 'routes users/:id/profile to users#profile' do
    expect(get('users/:id/profile')).to route_to(controller: 'users', action: 'profile', id: ':id')
  end
end
