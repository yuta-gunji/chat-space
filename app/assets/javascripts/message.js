$(function(){

  function buildHTML(message){
    if (message.image != null) {
      var html = `<li class="message">
                    <p class="message__name">${ message.name }</p>
                    <p class="message__date">${ message.date }</p>
                    <p class="message__text">${ message.body }</p>
                    <div class="message__image">
                      <img src=${ message.image }>
                    </div>
                  </li>`
    }
    else {
      var html = `<li class="message">
                    <p class="message__name">${ message.name }</p>
                    <p class="message__date">${ message.date }</p>
                    <p class="message__text">${ message.body }</p>
                  </li>`
    }
    return html;
  }

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = $(this).attr('action');
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
  })
});
