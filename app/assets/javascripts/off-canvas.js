$( document ).on('turbolinks:load', function() {
   $('[data-toggle="offcanvas"]').click(function(){
        $('.sidebar-offcanvas').toggleClass('active');
   })
});
