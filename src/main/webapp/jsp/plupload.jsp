<%@ include file="/jsp/init.jsp"%>

<link rel="stylesheet" href="/IGIPortalUpload-0.0.1/css/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="/IGIPortalUpload-0.0.1/css/jquery.ui.plupload.css" type="text/css" />

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/browserplus-min.js"></script>

<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.gears.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.silverlight.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.flash.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.browserplus.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.html4.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/plupload.html5.js"></script>
<script type="text/javascript" src="/IGIPortalUpload-0.0.1/js/jquery.ui.plupload.js"></script>



<form  method="post" action="submitform();">
	
	<div id="uploader">
		<input type="hidden" id="subdir" name="subdir" value="<%= ((User) request.getAttribute(WebKeys.USER)).getUserId() %>" />
		<p>You browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p>
	</div>
</form>
<script type="text/javascript">
// Convert divs to queue widgets when the DOM is ready
$(function() {
	$("#uploader").plupload({
		// General settings
		runtimes : 'silverlight',
		url : 'http://gridlab06.cnaf.infn.it/plupload/examples/upload.php?subdir=<%= ((User) request.getAttribute(WebKeys.USER)).getUserId() %>',
		max_file_size : '10240mb',
		max_file_count: 20, // user can add no more then 20 files at a time
		chunk_size : '10mb',
		//unique_names : true,
		multiple_queues : true,

		// Resize images on clientside if we can
		//resize : {width : 320, height : 240, quality : 90},
		
		// Rename files by clicking on their titles
		//rename: true,
		
		// Sort files
		sortable: true,

		// Specify what files to browse for
		filters : [
			{title : "Image files", extensions : "jpg,gif,png,pdf"},
			{title : "Zip files", extensions : "zip,avi"}
		],

		// Flash settings
		flash_swf_url : '/IGIPortalUpload-0.0.1/js/plupload.flash.swf',

		// Silverlight settings
		silverlight_xap_url : '/IGIPortalUpload-0.0.1/js/plupload.silverlight.xap'
	});

	// Client side form validation
	$('form').submit(function(e) {
        var uploader = $('#uploader').plupload('getUploader');

        // Files in queue upload them first
        if (uploader.files.length > 0) {
            // When all files are uploaded submit form
            uploader.bind('StateChanged', function() {
                if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
                    $('form')[0].submit();
                }
            });
                
            uploader.start();
        } else
            alert('You must at least upload one file.');

        return false;
    });
	 

});

</script>