require 'spec_helper'

describe 'routes for books' do

  it 'routes /checkout to books#checkout' do
    expect(post('books/:id/checkout')).to route_to(controller: 'books', action: 'checkout', id: ':id')
  end

  it 'routes /checkin to books#checkin' do
    expect(post('books/:id/checkin')).to route_to(controller: 'books', action: 'checkin', id: ':id')
  end
end
