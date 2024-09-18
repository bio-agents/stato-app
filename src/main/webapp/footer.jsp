<hr>

<div class="footer">
    <p>&copy; ISA-agents 2014</p>
</div>

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>



<script>

    function showPopup(id) {
        $(id).popover('show');
    }

    function hidePopup(id) {
        $(id).popover('hide');
    }

    $(".popper-upper").each(function(){
        $(this).popover();
    });

    $(function() {

        $('#myCarousel').carousel({
            interval: 3000,
            pause: "hover"
        });

        $('#playButton').click(function () {
            $('#myCarousel').carousel('cycle');
        });

        $('#pauseButton').click(function () {
            $('#myCarousel').carousel('pause');
        });
    });


    function askSTATO(j){
        var item = $('#myCarousel .carousel-inner .item.active');
        //$('#hiddenButton').val(item.index());
        $('#hiddenButton').val(item.attr('id'));
        $('#myCarousel').carousel('pause');
        $('#pauseButton').attr('active',true);
        var $askButton = $('#askButton_'+j);
        $askButton.attr('disabled', true);
        $("#askButton_"+j).toggleClass("active");
        queryForm.submit();
    };


    $('.btn-group[data-toggle=buttons]').each(function (i, e) {
        var default_class = $(e).data('toggle-default-class') || 'btn-default';

        $(e).find('label')
                .click(function (event) {
                    $(e).find('label')
                            .each(function (i, e) {
                                if (!(e == event.target)) {
                                    $(e).removeClass($(e).data('toggle-class'))
                                            .addClass(default_class);
                                    $(e).find('input')
                                            .removeAttr('checked');
                                } else {
                                    $(e).removeClass(default_class)
                                            .addClass($(e).data('toggle-class'));
                                    $(e).find('input')
                                            .attr('checked', 1);
                                }
                            });
                });
    });

    function selectQueryView(queryType){
      var views = document.getElementsByName('view');

      var viewValue;

      for (var i = 0, length = views.length; i < length; i++) {
          if (views[i].checked) {
              viewValue = views[i].value
              break;
          }
      }

      if (viewValue=="grid")
          selectQueryViewForm.action = "gridQueryForm.jsp?queryType="+queryType;
      else if (viewValue=="carousel")
          selectQueryViewForm.action = "carouselQueryForm.jsp?queryType="+queryType;
        selectQueryViewForm.submit();
    }

</script>

<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript">
    var sc_project=9857769;
    var sc_invisible=1;
    var sc_security="afb0bef7";
    var scJsHost = (("https:" == document.location.protocol) ?
            "https://secure." : "http://www.");
    document.write("<sc"+"ript type='text/javascript' src='" +
            scJsHost+
            "statcounter.com/counter/counter.js'></"+"script>");
</script>
<noscript><div class="statcounter"><a title="web stats"
                                      href="http://statcounter.com/free-web-stats/"
                                      target="_blank"><img class="statcounter"
                                                           src="http://c.statcounter.com/9857769/0/afb0bef7/1/"
                                                           alt="web stats"></a></div></noscript>
<!-- End of StatCounter Code for Default Guide -->


</body>
</html>