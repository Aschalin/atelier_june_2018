require 'rails_helper'

describe 'AppRouting' do
  it {
    expect(root: 'books', action: 'index')
  }

  it {
    expect(root: 'books', action: 'new')
  }
  
  it {
  	expect(get:'books/12').to route_to(controller:'books', action:'show', id:'12')
  }
  
  it {
  	expect(get:'books/12/edit').to route_to(controller:'books', action:'edit', id:'12')
  }
  
  it {
  	expect(post:'books').to route_to(controller:'books', action:'create')
  }

  it {
  	expect(patch:'books/12').to route_to(controller:'books', action:'update', id:'12')
  }

  it {
  	expect(put:'books/12').to route_to(controller:'books', action:'update', id:'12')
  }

  it {
  	expect(delete:'books/12').to route_to(controller:'books', action:'destroy', id:'12')
  }

  it {
  	expect(get:'books/12/reserve').to route_to(controller:'reservations', action:'reserve', book_id:'12')
  }

  it {
  	expect(get: reserve_book_path(book_id:'12')).to route_to(controller:'reservations', action:'reserve', book_id:'12')
  }
  
  it {
  	expect(get:'books/12/take').to route_to(controller:'reservations', action:'take', book_id:'12')
  }
  
  it {
  	expect(get:'books/12/give_back').to route_to(controller:'reservations', action:'give_back', book_id:'12')
  }
  
  it {
  	expect(get:'books/12/cancel_reservation').to route_to(controller:'reservations', action:'cancel', book_id:'12')
  }
  
  it {
  	expect(get:'users/12/reservations').to route_to(controller:'reservations', action:'users_reservations', user_id:'12')
  }
  
  it {
  	expect(get:'google-isbn').to route_to(controller:'google_books', action:'show')
  }



end
