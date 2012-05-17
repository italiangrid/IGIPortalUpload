<%@ include file="/jsp/init.jsp"%>

<!-- Bootstrap CSS Toolkit styles -->
<link rel="stylesheet" href="/IGIPortalUpload-0.0.1/css/bootstrap.min.css">
<!-- Generic page styles -->
<link rel="stylesheet" href="/IGIPortalUpload-0.0.1/css/style.css">
<!-- Bootstrap styles for responsive website layout, supporting different screen sizes -->

<!-- Bootstrap CSS fixes for IE6 -->
<!--[if lt IE 7]><link rel="stylesheet" href="/IGIPortalUpload-0.0.1/bootstrap-ie6.min.css"><![endif]-->
<!-- Bootstrap Image Gallery styles -->
<link rel="stylesheet" href="/IGIPortalUpload-0.0.1/css/bootstrap-image-gallery.min.css">
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="/IGIPortalUpload-0.0.1/css/jquery.fileupload-ui.css">
<!-- Shim to make HTML5 elements usable in older Internet Explorer versions -->
<!--[if lt IE 9]><script src="/IGIPortalUpload-0.0.1/js/html5.js"></script><![endif]-->

<div class="container">
    <br>
    <!-- The file upload form used as target for the file upload widget -->
    <form id="fileupload" action="https://gridlab07.cnaf.infn.it/jQueryFileUpload/server/php/" method="POST" enctype="multipart/form-data">
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <input type="hidden" id="subdir" name="subdir" value="<%= ((User) request.getAttribute(WebKeys.USER)).getUserId() %>" />
        <div class="row fileupload-buttonbar">
            <div class="span12">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <span><i class="icon-plus icon-white"></i> Add</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <!-- <button type="submit" class="btn btn-primary start">
                    <i class="icon-upload icon-white"></i> Start
                </button>  -->
                <button type="reset" class="btn btn-warning cancel">
                    <i class="icon-ban-circle icon-white"></i> Abort
                </button>
                <!-- <button type="button" class="btn btn-danger delete">
                    <i class="icon-trash icon-white"></i> Delete
                </button> 
                <input type="checkbox" class="toggle">  -->
            </div>
            <div class="span10">
                <!-- The global progress bar -->
                <div class="progress progress-success progress-striped active fade">
                    <div class="bar" style="width:0%;"></div>
                </div>
				<div id="fileupload-progress"></div>
            </div>
        </div>
        <!-- The loading indicator is shown during image processing -->
        <div class="fileupload-loading"></div>
        <br>
        <!-- The table listing the files available for upload/download -->
        <table class="table table-striped"><tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody></table>
    </form>
    <br>
</div>

<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, files=o.files, l=files.length, file=files[0]; i<l; file=files[++i]) { %}
    <tr class="template-upload fade">
        
        <td class="name">{%=file.name%}</td>
        <td class="size">{%=o.formatFileSize(file.size)%}</td>
        {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
            <td>
                <div class="progress progress-success progress-striped active"><div class="bar" style="width:0%;"></div></div>
            </td>
            <td></td>
        {% } else { %}
            <td colspan="2"></td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-warning">
                <i class="icon-ban-circle icon-white"></i> {%=locale.fileupload.cancel%}
            </button>
        {% } %}</td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, files=o.files, l=files.length, file=files[0]; i<l; file=files[++i]) { %}
    <tr class="template-download fade" id="{%=file.name.replace('.','')%}">
        {% if (file.error) { %}
            
            <td class="name">{%=file.name%}</td>
            <td class="size">{%=o.formatFileSize(file.size)%}</td>
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else { %}
            
            <td class="name">
                <a href="{%=file.url%}" title="{%=file.name%}" rel="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
            </td>
            <td class="size">{%=o.formatFileSize(file.size)%}</td>
            <td colspan="2"></td>
        {% } %}
        <td class="delete">
            <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                <i class="icon-trash icon-white"></i> {%=locale.fileupload.destroy%}
            </button>
            <input type="checkbox" name="delete" value="1">
        </td>
    </tr>
{% } %}
</script>
<script src="/IGIPortalUpload-0.0.1/js/jquery.min.js"></script>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="/IGIPortalUpload-0.0.1/js/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="/IGIPortalUpload-0.0.1/js/tmpl.min.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="/IGIPortalUpload-0.0.1/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="/IGIPortalUpload-0.0.1/js/canvas-to-blob.min.js"></script>
<!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->
<script src="/IGIPortalUpload-0.0.1/js/bootstrap.min.js"></script>
<script src="/IGIPortalUpload-0.0.1/js/bootstrap-image-gallery.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/IGIPortalUpload-0.0.1/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/IGIPortalUpload-0.0.1/js/jquery.fileupload.js"></script>
<!-- The File Upload image processing plugin -->
<script src="/IGIPortalUpload-0.0.1/js/jquery.fileupload-ip.js"></script>
<!-- The File Upload user interface plugin -->
<script src="/IGIPortalUpload-0.0.1/js/jquery.fileupload-ui.js"></script>
<!-- The localization script -->
<script src="/IGIPortalUpload-0.0.1/js/locale.js"></script>
<!-- The main application script -->
<script src="/IGIPortalUpload-0.0.1/js/main.js"></script>
<!-- Extend progress information -->

<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->
<!--[if gte IE 8]><script src="/IGIPortalUpload-0.0.1/js/cors/jquery.xdr-transport.js"></script><![endif]-->



