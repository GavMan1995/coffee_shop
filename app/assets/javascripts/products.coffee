$(document).ready ->
  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1'


  $.ajax
    url: "#{baseUrl}/products"
    type: 'GET'
    success: (data) ->
      for product in data.products
        $.ajax
          url: '/product_card'
          type: 'GET'
          data:
            product: product
          success: (data) ->
            $('#products').append data
          error: (data) ->
            console.log data
    error: (data) ->
      console.log data
