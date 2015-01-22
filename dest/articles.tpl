{if $mode=="view" || $mode == "folder"}
    {capture assign=path}{if $article_category.path}{section name=foo loop=$article_category.path step=-1} {$article_category.path[foo].folder_name}{/section}{/if}{/capture}
    {if $mode=='view'}
        {assign var="pn" value=""}
        {assign var='default_name' value=$article_post.title}
    {else}
        {if isset($smarty.get.p)}{assign var="pn" value=" #PAGE_TITLE_PAGES# `$p+1`"}{/if}
        {assign var='default_name' value=''}
    {/if}
    {if $site.settings.seo_fields}
        {if $page.seo_title}{assign_hash var=page.title value="`$page.seo_title``$path` `$page.title` `$pn`"}{else}{assign_hash var=page.title value="`$default_name``$path` `$page.title` `$pn`"}{/if}
        {if $page.seo_keywords}{assign_hash var=page.keywords value="`$page.seo_keywords``$path` `$page.keywords` `$pn`"}{else}{assign_hash var=page.keywords value="`$default_name``$path` `$page.keywords` `$pn`"}{/if}
        {if $page.seo_description}{assign_hash var=page.description value="`$page.seo_description``$path` `$page.description` `$pn`"}{else}{assign_hash var=page.description value="`$default_name``$path` `$page.description` `$pn`"}{/if}
    {else}
        {assign_hash var=page.title value="`$default_name``$path` `$page.title` `$pn`"}
        {assign_hash var=page.keywords value="`$default_name``$path` `$page.keywords` `$pn`"}
        {assign_hash var=page.description value="`$default_name``$path` `$page.description` `$pn`"}
    {/if}
{/if}
{include file="db:header.tpl" h1=$article_post.title|default:$folder.folder_name|default:$article_category.category_name}
{if $article_category}
    {if $mode=="view"}

        <div class="posts-single">
            <div class="posts-singleImage">
                {if $article_post.filename}
                    <img src="{s3_img src=$article_post.filename width=122 height=122 method="r"}" alt="">
                {else}
                    <img src="images/noimage.jpg" width=100 alt="">
                {/if}
            </div>
            <div class="posts-singleBody">
               {$article_post.body}
               <div class="posts-singleBack">
                   <a href="{$page.url}">&lt; Назад</a>
               </div>
            </div>
            {if isset($comments)}
                {include file="db:comments.tpl"}
            {/if}
        </div>

    {else}

        <div class="posts">
            {foreach from=$article_posts item=e}
                <div class="posts-item">
                
                  <div  class="posts-itemImage">
                    {if $e.filename}
                        <img src="{s3_img src=$e.filename width=100 height=100 method="r"}" alt="">
                    {else}
                        <img src="images/noimage.jpg" width=100 alt="">
                    {/if}
                  </div>
                  
                  <div class="posts-itemBody">
                    <div class="posts-itemTitle">
                        <a href="{get_seo_url mode="article_post" id=$e.post_id}">
                            {$e.title}
                        </a>
                    </div>
                    <div class="posts-itemText">
                        {if $article_category.view_type=="anonce"}
                            {$e.anonce}
                        {else}
                            {$e.body}
                        {/if}
                    </div>
                  </div>
                </div>
            {/foreach}
        </div>
        {include file="db:pagelist2.tpl"}

    {/if}
{/if}
{include file="db:bottom.tpl"}