/*
 * jQuery File Upload Plugin JS Example 6.5
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
            'option',
            'redirect',
            window.location.href.replace(
                /\/[^\/]*$/,
                '/cors/result.html?%s'
            )
        );

    	$('#fileupload').fileupload('option', {
    		maxChunkSize: 10000000, 
    		add: function (e, data) {
    			var subdir = $("#subdir").val();
    			
    		    var that = this;
    	        $.getJSON('http://gridlab06.cnaf.infn.it/jQueryFileUpload/server/php/index.php', {file: data.files[0].name, subdir: subdir}, function (file) {
    	            data.uploadedBytes = file && file.size;
    				//alert(file.size);
    				//alert(data.uploadedBytes);
    				//alert(data.files[0].size);
    				//if(data.uploadedBytes!=data.files[0].size){
    					//alert('Click start for complete the upload.');
    					//alert(file.name);
    					//$('#'+file.name).remove();
    	            	$.blueimpUI.fileupload.prototype.options.add.call(that, e, data);
    					/*if(file!=null){
    						$("#"+file.name.replace('.','')).remove();
    					}*/
    				//}
    	        }).done(function (file) {
                        data.uploadedBytes = file && file.size;
                        data.submit();
                    })
    	    },
    		maxRetries: 100,
    		retryTimeout: 500,
    	    fail: function (e, data) {
    	        var fu = $(this).data('fileupload'),
                retries = data.context.data('retries') || 0,
                retry = function () {
                    $.getJSON('http://gridlab06.cnaf.infn.it/jQueryFileUpload/server/php/index.php', {file: data.files[0].name, subdir: subdir})
                        .done(function (file) {
                            data.uploadedBytes = file && file.size;
                            data.submit();
                        })
                        .fail(function () {
                            fu._trigger('fail', e, data);
                        });
                };
    	        if (data.errorThrown !== 'abort' &&
    	                data.errorThrown !== 'uploadedBytes' &&
    	                retries < fu.options.maxRetries) {
    	            retries += 1;
    	            data.context.data('retries', retries);
    	            window.setTimeout(retry, retries * fu.options.retryTimeout);
    	            return;
    	        }
    	        data.context.removeData('retries');
    	        $.blueimpUI.fileupload.prototype
    	            .options.fail.call(this, e, data);
    	    },
    		
    		stop:function (e, data) {
    			var that=this;
    			var subdir = $("#subdir").val();
    	         $.getJSON('http://gridlab06.cnaf.infn.it/jQueryFileUpload/server/php/index.php', {file: data.files[0].name, subdir: subdir}, function (file) {
    		            $(that).fileupload('option', 'done')
    	                    .call(that, null, {result: result});
    		        });
    	    }
        });


	$('#fileupload').bind('fileuploadstart', function () {
	    var widget = $(this),
	        progressElement = $('#fileupload-progress').fadeIn(),
	        interval = 500,
	        total = 0,
	        loaded = 0,
	        loadedBefore = 0,
	        progressTimer,
	        progressHandler = function (e, data) {
	            loaded = data.loaded;
	            total = data.total;
	        },
	        stopHandler = function () {
	            widget
	                .unbind('fileuploadprogressall', progressHandler)
	                .unbind('fileuploadstop', stopHandler);
	            window.clearInterval(progressTimer);
	            progressElement.fadeOut(function () {
	                progressElement.html('');
	            });
	        },
	        formatTime = function (seconds) {
	            var date = new Date(seconds * 1000);
	            return ('0' + date.getUTCHours()).slice(-2) + ':' +
	                ('0' + date.getUTCMinutes()).slice(-2) + ':' +
	                ('0' + date.getUTCSeconds()).slice(-2);
	        },
	        formatBytes = function (bytes) {
	            if (bytes >= 1000000000) {
	                return (bytes / 1000000000).toFixed(2) + ' GB';
	            }
	            if (bytes >= 1000000) {
	                return (bytes / 1000000).toFixed(2) + ' MB';
	            }
	            if (bytes >= 1000) {
	                return (bytes / 1000).toFixed(2) + ' KB';
	            }
	            return bytes + ' B';
	        },
	        formatPercentage = function (floatValue) {
	            return (floatValue * 100).toFixed(2) + ' %';
	        },
	        updateProgressElement = function (loaded, total, bps) {
	            progressElement.html(
	                formatBytes(bps) + 'ps | ' +
	                    formatTime((total - loaded) / bps) + ' | ' +
	                    formatPercentage(loaded / total) + ' | ' +
	                    formatBytes(loaded) + ' / ' + formatBytes(total)
	            );
	        },
	        intervalHandler = function () {
	            var diff = loaded - loadedBefore;
	            if (!diff) {
	                return;
	            }
	            loadedBefore = loaded;
	            updateProgressElement(
	                loaded,
	                total,
	                diff * (1000 / interval)
	            );
	        };
	    widget
	        .bind('fileuploadprogressall', progressHandler)
	        .bind('fileuploadstop', stopHandler);
	    progressTimer = window.setInterval(intervalHandler, interval);
	});
	
	
	// Load existing files:
    /*$('#fileupload').each(function () {
        var that = this;
        var subdir = $("#subdir").val();
        $.getJSON(this.action, {subdir: subdir},  function (result) {
            if (result && result.length) {
                $(that).fileupload('option', 'done')
                    .call(that, null, {result: result});
            }
        });
    });*/

});
