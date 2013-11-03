{*
 * $Revision: 17486 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}

<script type="text/javascript">
    // <![CDATA[
jQuery(document).ready(function() {ldelim}

    jQuery("#uploadify").uploadify({ldelim}
        'swf'       : '{g->url href="modules/uploadify/lib/uploadify.swf"}',
        'uploader'       : '{$ItemAddUploadify.submitUrl}',
        'buttonImage'      : '{g->url href="modules/uploadify/lib/browseBtnFlash.png"}',
        'width'          : 82,
        'height'         : 24,
        'queueID'        : 'fileQueue',
        'fileObjName'   : 'g2_userfile',
        'auto'           : false,
        'buttonText'     : '{g->text text="Select Media"}',
        {literal}onUploadError: function (file, errorCode, errorMsg, errorString) {
            //don't notify about cancelled upload, as these already have been announced by onCancel 
            if (errorCode == -280) return false;
	    jQuery.jGrowl('<p></p>'+ 'The file ' + file.name + ' could not be uploaded: ' + errorString, {
                theme:  'error',
                header: 'ERROR',
                sticky: true
            });
            return false;
        },
        onCancel: function (a) {
            var msg = "Cancelled uploading: "+ a.name;
            jQuery.jGrowl('<p></p>'+msg, {
                theme:  'warning',
                header: 'Cancelled Upload',
                life:   4000,
                sticky: false
            });
        },
        onClearQueue: function (a) {
            var msg = "Cleared "+ a +" files from queue";
            jQuery.jGrowl('<p></p>'+msg, {
                theme:  'warning',
                header: 'Cleared Queue',
                life:   4000,
                sticky: false
            });
        },
        onUploadSuccess: function (file, data, response) {
            jQuery.jGrowl('<p></p>'+ file.name, {
                theme:  'success',
                header: 'Upload Complete',
                life:   4000,
                sticky: false
            });
	  /*onError: function (e, q, f, o) {
    alert("ERROR: " + o.info);
	}*/
        }{/literal}
    {rdelim});
{rdelim});
{literal}
function startUpload(id){
    var $inputs = jQuery('#uploadOptions :input');
    var values = {};
    $inputs.each(function() {
        if(jQuery(this).attr('checked')){
            values[this.name] = 1;
        }else{
            values[this.name] = this.value;
        }
    });
    jQuery('#uploadify').uploadify('settings', 'scriptData', values);
    jQuery('#uploadify').uploadify('upload', '*');
}
{/literal}
  // ]]>
</script>

<div class="gbBlock">
    <div id="fileQueue"></div>
    <input type="file" name="uploadify" id="uploadify" />
    <input class="uploadifyButton" type="button" onclick="startUpload('uploadify');" value="{g->text text='Upload'}"/>
    <input class="uploadifyButton" type="button" onclick="$('#uploadify').uploadify('cancel', '*');" value="{g->text text='Clear'}"/>
</div>
</form>
<form id="uploadOptions">
<div class="gbBlock">
    <p class="giDescription">
      {g->text text="Copy base filenames to:"}
      <br/>
      <input type="checkbox" id="cbTitle" {if $form.set.title} checked="checked" {/if}
       name="{g->formVar var="form[set][title]"}"/>
      <label for="cbTitle"> {g->text text="Title"} </label>
      &nbsp;

      <input type="checkbox" id="cbSummary" {if $form.set.summary} checked="checked" {/if}
       name="{g->formVar var="form[set][summary]"}"/>
      <label for="cbSummary"> {g->text text="Summary"} </label>
      &nbsp;

      <input type="checkbox" id="cbDescription" {if $form.set.description} checked="checked" {/if}
       name="{g->formVar var="form[set][description]"}"/>
      <label for="cbDescription"> {g->text text="Description"} </label>
    </p>
</div>

{* Include our extra ItemAddOptions *}
{foreach from=$ItemAdd.options item=option}
  {include file="gallery:`$option.file`" l10Domain=$option.l10Domain}
{/foreach}
<div class="gbBlock">
  <h3> {g->text text="Resizes"} </h3>

  <p class="giDescription">
    {g->text text="Have gallery create resizes at upload time."}
  </p>

  <input type="checkbox" id="BuildResizes_cb" name="{g->formVar var="form[buildResizes]"}"/>
  <label for="BuildResizes_cb">
    {g->text text="Create resizes now"}
  </label>
</div>
