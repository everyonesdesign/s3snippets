{if $news_post}
    {if $site.settings.seo_fields}
        {if $page.seo_title}{assign_hash var=page.title value="`$page.seo_title`"}{else}{assign_hash var=page.title value="`$news_post.title` `$page.title`"}{/if}
        {if $page.seo_keywords}{assign_hash var=page.keywords value="`$page.seo_keywords`"}{else}{assign_hash var=page.keywords value="`$news_post.keywords` `$page.keywords`"}{/if}
        {if $page.seo_description}{assign_hash var=page.description value="`$page.seo_description`"}{else}{assign_hash var=page.description value="`$news_post.description` `$page.description`"}{/if}
    {else}
        {assign_hash var=page.title value="`$news_post.title` `$page.title`"}
        {assign_hash var=page.keywords value="`$news_post.title` `$page.keywords`"}
        {assign_hash var=page.description value="`$news_post.title` `$page.description`"}
    {/if}
{else}
    {if isset($smarty.get.p)}
        {if $invert_pages}{assign var="pnum" value=$pages-$smarty.get.p}{else}{assign var="pnum" value=$smarty.get.p+1}{/if}
        {assign_hash var=page.title value="`$page.title` #PAGE_TITLE_PAGES# `$pnum`"}
        {assign_hash var=page.description value="`$page.description` #PAGE_DESCRIPTION_PAGES# `$pnum`"}
    {/if}
{/if}
{if $news_post}
    {include file="db:header.tpl" h1=$news_post.title}
{else}
    {include file="db:header.tpl"}
{/if}
{if $news_lenta}

    {if $news_post}

        <div class="posts-single">
            <div class="posts-singleImage">
                {if $news_post.image_filename}
                    <img src="{s3_img src=$news_post.image_filename width=100 height=100 method="c"}" alt="">
                {else}
                    <img src="images/noimage.jpg" width=100 alt="">
                {/if}
            </div>
            <div class="posts-singleBody">
                <div class="posts-singleDate">{$news_post.news_date|date_format_ex:"%d %B %Y в %H:%M"}</div>
                {$news_post.body}
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
            {foreach from=$news item=e}
                <div class="posts-item">
                  <div class="posts-itemImage">
                    {if $e.image}
                        <img src="{s3_img src=$e.image width=100 height=100 method="c"}" alt="">
                    {else}
                        <img src="images/noimage.jpg" width=100 alt="">
                    {/if}
                  </div>
                  <div class="posts-itemBody">
                    <div class="posts-itemTitle">
                        <a href="{if $site.settings.sef_url}{get_seo_url mode="news_post" id=$e.post_id alias=$e.alias}{else}{$news_post}?mode=news_post&view={$e.news_id}{/if}">
                            {$e.title}
                        </a>
                    </div>
                    <div class="posts-date">{$news_post.news_date|date_format_ex:"%d %B %Y в %H:%M"}</div>
                    <div class="posts-itemText">
                        {if $news_lenta.view_type=="anonce"}
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