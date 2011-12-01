/**
 * 
 * @depends /admin/core.js
 * 
 */

jQuery(document).ready(function() {
	
    var skuCount = jQuery('tr[id^="Sku"]').length;
	
    $("#addSKU").click(function() {
        var current = jQuery('tr[id^="Sku"]').length;
        current++;
        var $newSKU= jQuery( "#tableTemplate tbody>tr:last" ).clone(true);
        $newSKU.children("td").children("input").each(function(i) {
            var $currentElem= $(this);
            if ($currentElem.attr("type") != "radio") {
                $currentElem.attr("name", "skus[" + current + "]." + $currentElem.attr("name"));
            }
        });
        $newSKU.children("td").children("select").each(function(i) {
            var $currentElem= $(this);
            $currentElem.attr("name","skus["+current+"]."+$currentElem.attr("name"));
        });
        $('#remSKU').attr('style','');
        $('#skuTable > tbody:last').append($newSKU);
        $newSKU.attr("id","Sku" + current);
        // add stripe to row
        if(current % 2 == 1) {
            $newSKU.addClass("alt");
        }
    });
    
    $('#remSKU').click(function() {
        var num = jQuery('tr[id^="Sku"]').length;
        $('#Sku' + num).remove();
        // can't remove more skus than were originally present
        if(num-1 == skuCount) {
            jQuery('#remSKU').attr('style','display:none;');
        }
    });
	
    $("#addImage").click(function() {
        var current = jQuery('input.imageid').length;
        current++;
        var $newImage= jQuery( "#imageUploadTemplate" ).clone(true);
        $newImage.children("dd").children("input").each(function(i) {
            var $currentElem= $(this);
            $currentElem.attr("name", "images[" + current + "]." + $currentElem.attr("name"));
            if ($currentElem.attr("type") == "hidden") {
                $currentElem.attr("class", "imageid");
            }
        });
        $newImage.children("dd").children("select").each(function(i) {
            var $currentElem= $(this);
            $currentElem.attr("name","images["+current+"]."+$currentElem.attr("name"));
        });
        $newImage.children("dd").find("textarea").each(function(i) {
			var $currentElem = $(this);
			$currentElem.attr("name","images["+current+"]."+$currentElem.attr("name"));
			$currentElem.attr("id",$currentElem.attr("id") + current);
			$currentElem.addClass("wysiwyg").addClass("Basic");
        });
		if($('.alternateImageUpload').length == 0) {
			$('.buttons:last').before($newImage);
		} else {
			$('.alternateImageUpload:last').after($newImage);	
		}
		$newImage.children("dd").find("textarea.wysiwyg").each(function(i){
			setRTE($(this));
		});
        $newImage.removeAttr("id");
		$newImage.attr("class","alternateImageUpload");
    });
	
    $(".uploadImage").colorbox({
        onComplete: function() {
			// upload button is disabled unless file field is filled
            $('input.imageFile').change(function(){
                    if($(this).val()) {
                        $('input.uploadImage').removeAttr('disabled');
                    } 
            });         
        }
    });
});