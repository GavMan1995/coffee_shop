$(document).ready ->
  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/products'

  getProducts = ->
    $('#products').empty()
    $.ajax
      url: baseUrl
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

  getProducts()

  $(document).on "click", ".delete_product", (e) ->
    e.preventDefault()

    $.ajax
      url: "#{baseUrl}/#{$(this).attr('href')}"
      type: 'DELETE'
      success: (data) ->
        alert "product deleted"
        getProducts()
      error: (data) ->
        console.log data

  $(document).on "click", ".new_product", (e) ->
    newProduct = $('#new_pro')
    e.preventDefault()
    newProduct.removeClass('hide')

    $('#new_pro').submit (e) ->
      e.preventDefault()
      name = $(this).find('#product_name').val()
      description = $(this).find('#product_description').val()

      $.ajax
        url: baseUrl
        type: 'POST'
        data: (product: {name: name, description: description})
        success: (data) ->
          getProducts()
        error: (data) ->
          console.log data
