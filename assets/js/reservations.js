window.viewFunctions = window.viewFunctions || {};
viewFunctions.ajax_reservation = function(csrf_token, request_url) {
  $('.submit-reservation').click( function(e) {
    e.preventDefault();
    $('.errors').html('');
    $('.success').html('');
    var date = $('.reserved-at').val().split('-');
    var from = $('.from').val();
    var to = $('.to').val();

    $.ajax({
      url: request_url,
      type: 'POST',
      dataType: 'json',
      data: {
        text: date[2]+'/'+date[1]+'-'+ from +'-'+ to,
        '_csrf': csrf_token
       },
      error: function(data){
        $('.errors').append(data['responseText']);
      },
      success: function(data) {
        $('.success').append(data['responseText']);
        window.location.reload();
      }
    });
  });
}
