$("#submit_btn").on("click", () => {
  let emailAddress = $("#email_input").val();
  
  if ( emailAddress && emailAddress.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]+\.)[a-zA-Z]{2,4}/)) {
    $("#share_from").submit();
  }
  else{
    $("#validation_error").html ('<div class="form-control font-italic text-danger"><strong>Error:</strong> email address is invalid </div>')
  }
});


