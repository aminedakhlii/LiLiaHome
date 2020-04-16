function send_message(message , current_user ,partner){
$.ajax({
  type:'POST',
  url:'/send_message',
  data: {'message' : message ,
          'current_user' : current_user,
          'partner' : partner
      },
  success : function(data){
    const html = data.map(function(message) {
      return '${message.message}'
    }).join('');
    const conversation = document.querySelector('.messages');
    conversion.innerHTML = html ;
    conversion.scrollTop = messages.scrollHeight ;
  }
});
}
