require 'spec_helper'

describe 'routes for books' do

  it 'routes /checkout to books#checkout' do
    expect(post('books/:id/checkout')).to route_to(controller: 'books', action: 'checkout', id: ':id')
  end
end
