$(function(){

  function buildHTML(message){
    var image_view = (message.image != null)?  `<img src=${message.image}>` : ``;
    var html = `<li class="message" message_id="${ message.id }">
                  <p class="message__name">${ message.name }</p>
                  <p class="message__date">${ message.date }</p>
                  <p class="message__text">${ message.body }</p>
                  <div class="message__image">
                    ${ image_view }
                  </div>
                </li>`
    return html;
  }

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var body = $('.new_message__text').val();
    var image = $('#message_image').val();
    var formData = new FormData(this);
    var href = $(this).attr('action');
    if(body == "" && image == "") {
      return false;
    }
    else{
      $.ajax({
        url: href,
        type: "POST",
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        var html = buildHTML(data);
        $('.messages').append(html)
        $('.new_message__text').val('')
        $('#message_image').val('')
        $('.middle_content').animate({scrollTop: $('.middle_content')[0].scrollHeight});
      })
      .fail(function(){
        alert('送信できませんでした');
      })
      return false;
    }
  });

  $(function(){
    if (window.location.href.match(/\/groups\/\d+\/messages/)) {
      var interval = setInterval(update, 5000);
    }
    else {
      clearInterval(interval);
    }
  });
  function update(){
    if ($('.message')[0]){
      var message_id = $('.message:last').attr('message_id');
    }
    else {
      var message_id = 0
    }
    $.ajax({
      url: window.location.href,
      type: 'GET',
      data: {
        message: { id: message_id }
      },
      dataType: 'json'
    })
    .always(function(messages) {
      messages.forEach(function(message) {
        var html = buildHTML(message);
        $(".messages").append(html);
        $('.middle_content').animate({scrollTop: $('.middle_content')[0].scrollHeight});
      })
    })
  };
});
