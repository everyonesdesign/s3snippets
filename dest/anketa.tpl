{include file="db:header.tpl" h1=$anketa.name}

{if $anketa}

    {if !$anketa.posted}

        <form method="post" action="{$page.url}" class="anketaForm">

            {if $anketa && $anketa.dictionaries}

                {foreach from=$anketa.dictionaries item=e}

                    <div class="anketaForm-field">

                        {if $e.type_code=="TEXT"} {* ======================= *}

                            {if $e.name}<label class="anketaForm-label" for="d[{$e.dictionary_position}]">{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}</label><br>{/if}
                            <input type="text"{if $e.size} style="width: {$e.size*10}px;"{/if} maxlength="{$e.maxlength}" value="{$e.value|htmlspecialchars}" name="d[{$e.dictionary_position}]" id="d[{$e.dictionary_position}]">
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="TEXTAREA"} {* ======================= *}

                            {if $e.name}<label class="anketaForm-label" for="d[{$e.dictionary_position}]">{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}</label><br>{/if}
                            <textarea{if $e.cols} style="width: {$e.cols*10}px;"{/if} rows="{$e.rows}" name="d[{$e.dictionary_position}]" id="d[{$e.dictionary_position}]">{$e.value|htmlspecialchars}</textarea>
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="DIV"}  {* ======================= *}

                            <span style="font-weight:bold;">{$e.name}</span>
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            <hr>

                        {elseif $e.type_code=="SELECT"}  {* ======================= *}

                            {if $e.name}{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}<br>{/if}
                            <select name="d[{$e.dictionary_position}]" id="d[{$e.dictionary_position}]" >
                                {if $e.requered!=1}<option></option>{/if}
                                {foreach from=$e.options item=option}
                                    <option value="{$option.name}" {if $option.selected==true}selected{/if} >{$option.name}</option>
                                {/foreach}
                            </select>
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="MULTI_SELECT"} {* ======================= *}

                            {if $e.name}{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}<br>{/if}
                            <select multiple name="d[{$e.dictionary_position}][]" id="d[{$e.dictionary_position}][]">
                                {foreach from=$e.options item=option}
                                    <option value="{$option.name}" {if $option.selected==true}selected{/if} >{$option.name}</option>
                                {/foreach}
                            </select>
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="MULTI_CHECKBOX"} {* ======================= *}

                            {if $e.name}{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}<br>{/if}
                            {foreach from=$e.options item=option}
                                <label class="anketaForm-label"><input type="checkbox" value="{$option.name}" {if $option.selected==true}checked{/if} id="d[{$e.dictionary_position}][]" name="d[{$e.dictionary_position}][]">{$option.name}</label><br>
                            {/foreach}

                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="CHECKBOX"} {* ======================= *}

                            <input type="checkbox" value="{$e.name}" {if $e.value==$e.name}checked{/if} id="d[{$e.dictionary_position}]" name="d[{$e.dictionary_position}]">
                            <label class="anketaForm-label" for="d[{$e.dictionary_position}]">{$e.name}</label><br>
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="RADIO_GROUP"} {* ======================= *}

                            {if $e.name}{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}<br>{/if}
                            {foreach from=$e.options item=option}
                                <label class="anketaForm-label"><input type="radio" name="d[{$e.dictionary_position}]" value="{$option.name}" {if $option.selected==true}checked{/if}>{$option.name}</label><br>
                            {/foreach}
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="HTML_BLOCK"}

                            {$e.html}

                        {elseif $e.type_code=="UPLOAD"} {* ========================= *}

                            {if !$_upload_css_attached}
                                {assign var="_upload_css_attached" value="1"}
                                <link rel="stylesheet" type="text/css" href="/shared/s3/swfupload/default.css">
                                <script type="text/javascript" src="/shared/s3/swfupload/swfupload.upload.pack.js"></script>
                            {/if}
                            <span class="anketa-flash-upload">
                            {if $e.error}
                                <span style="background: #FFEEEE; color:red; border: 1px solid red; padding:5px">{$e.error}</span>
                            {elseif $e.uploaded}
                                <div class="fieldset flash"><span class="legend">{$e.name}</span>
                                    {foreach from=$e.uploaded item=upload}
                                        <div class="progressWrapper"><div class="progressContainer blue"><div class="progressName">{$upload.filename}</div><div class="progressBarStatus">{#UPLOADED#}...</div><div class="progressBarComplete"></div></div></div>
                                    {/foreach}
                                    <input type="hidden" name="d[{$e.dictionary_position}]" value="{$e.uploaded_str|escape}">
                                </div>
                            {else}
                                <script type="text/javascript">
                                var JS_FORM_REQUIRED_FIELD = '{#BOARD_FILL_REQUIRED_FIELDS#}';
                                newSWFU({$e.dictionary_position}, {if $e.required==1}true{else}false{/if},  {$e.count}, "{$e.upload_url}", "{$e.upload_field}", "{$e.maxsize} MB",  "{$e.filetypes.1}", "{$e.filetypes.0}", "{$e.buttontitle}");
                                </script>
                                {$e.name}
                                <div class="fieldset flash" id="fsUploadProgress{$e.dictionary_position}"></div>
                                <span class="buttonUpload" id="spanButtonPlaceHolder{$e.dictionary_position}"></span>
                                {if $e.required==1}<span class="anketaForm-required">*</span>{/if}
                                {if $e.count}<span class="no-more">{#NO_MORE#}: {$e.count}</span>{/if}
                                <input type="hidden" name="d[{$e.dictionary_position}]" id="hidUploadField{$e.dictionary_position}" value="">
                                    {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                                </span>
                            {/if}
                            {* ==DON`T_REMOVE_END_OF_CONTROL_SWITCH== *}
                            {* ======================= *}

                        {elseif $e.type_code=="CALENDAR"} {* ========================= *}

                            {if $e.name}{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}<br>{/if}
                            <input type="text" name="d[{$e.dictionary_position}]" id="d[{$e.dictionary_position}]" value="{$e.value|escape}" readonly="true" class="init-calendar">
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                        {elseif $e.type_code=="CALENDAR_INTERVAL"} {* ========================= *}

                            {if $e.name}{$e.name}:{if $e.required==1}<span class="anketaForm-required">*</span>{/if}<br>{/if}
                            {$e.label_from|default:#ANKETA_CALENDAR_INVERVAL_FROM#}
                            <span><input type="text" readonly="true" id="d[{$e.dictionary_position}][0]" value="{$e.value|regex_replace:"/^(d+.d+.d+)[^~]+/":"1"}"></span>
                            &nbsp;{$e.label_to|default:#ANKETA_CALENDAR_INVERVAL_TO#}
                            <span><input type="text" readonly="true" id="d[{$e.dictionary_position}][1]" value="{$e.value|regex_replace:"/[^~]+?(d+.d+.d+)$/":"1"}"></span>
                            <input class="init-calendar-interval" type="hidden" value="{$e.value|escape}" name="d[{$e.dictionary_position}]" id="d[{$e.dictionary_position}]">
                            {if $e.note!=""}<div class="anketaForm-note">{$e.note}</div>{/if}
                            {if $e.error!=""}<div class="anketaForm-error">{$e.error}</div>{/if}

                            {* ======================= *}

                        {/if}

                    </div>

                {/foreach}

                {* == CAPTCHA == *}
                {* Don't remove nor CAPTCHA, nor captcha/captcha end markers!!! *}
                {if $anketa.captcha}
                    <div class="anketaForm-captcha">
                        <span class="anketaForm-required">*</span>#FORM_ENTER_CAPTCHA_CODE#:
                        {captcha name="_cn"}
                        {if $anketa.captcha_error}<div class="anketaForm-error">#WRONG_CAPTCHA_ERROR#</div>{/if}
                    </div>
                {/if}
                {* == captcha_end == *}

                <div class="anketaForm-submit">
                    <input type="submit" class="anketaForm-submit" value="{$anketa.submit_name}">
                </div>

            </form>

        {/if}

    {else}
        <div class="anketaForm-success">
            <p>{$anketa.success_note}</p>
        </div>
    {/if}
{/if}

<script src="/shared/misc/calendar.gen.js" type="text/javascript" language="javascript" charset="utf-8"></script>
{include file="db:bottom.tpl"}