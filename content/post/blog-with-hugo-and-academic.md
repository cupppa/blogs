---
title: "Blog with Hugo and Academic"
subtitle: ""
tags: ["hugo", "academic"]
categories: ["blog"]
date: 2020-07-01T23:07:31+08:00

summary: "Record opeation steps of building personal site with academic for hugo."

draft: false
---

## Install Hugo

- Windows
```
scoop install hugo
# or
choco install hugo
```

- Mac
```
brew install hugo
```

- Linux
```
snap install hugo
```

## Create New Site
```
hugo new site blogs
```

## Add Submodule

```
cd blogs
git submodule add https://github.com/gcushen/hugo-academic.git .\themes\academic
git submodule init
git submodule update
```

## Config Academic

#### config/_default/config.toml

```
cp -p config.toml config.backup.toml
cp /dev/null config.toml
cp -r themes/academic/exampleSite/config ./
sed -i 's/title = "Academic"/title = "CUPPPA"/' config/_default/config.toml
sed -i 's/hasCJKLanguage = false/hasCJKLanguage = true/' config/_default/config.toml
```

#### config/_default/params.toml

```
sed -i 's/theme = "minimal"/theme = "dark"/' config/_default/params.toml
sed -i 's/email = "test@example.org"/email = "cupppa@gmail.com"/' config/_default/params.toml
sed -i 's/^date_format = "Jan 2, 2006"/date_format = "2006-01-02"/' config/_default/params.toml
sed -i 's/^time_format = "3:04 PM"/time_format = "15:04"/' config/_default/params.toml
sed -i 's/sharing = true/sharing = false/' config/_default/params.toml
sed -i 's/netlify_cms = true/netlify_cms = false/' config/_default/params.toml
```
and change or comment lines start with `phone`, `address`, `coordinates`, `directions`, `office_time`, `appointment_url`, `contact_links`

#### config/_default/menus.toml

```
cat >config/_default/menus.toml <<EOF
[[main]]
  name = "Posts"
  url = "post"
  weight = 10

[[main]]
  name = "Tags"
  url = "tags"
  weight = 20

[[main]]
  name = "Categories"
  url = "categories"
  weight = 30
EOF
```

#### homepage

```
mkdir content/home/
cp themes/academic/exampleSite/content/home/index.md content/home/
cp themes/academic/exampleSite/content/home/posts.md content/home/
```

now your can view the site with:

```
hugo server --watch --verbose
```

## Custom Homepage

```
mkdir -p layouts/partials/widgets
cp themes/academic/layouts/partials/widgets/pages.html layouts/partials/widgets/
```

refer to `theme/academic/layouts/partials/widgets/tag_cloud.html`, replace "Recent Post" partial (`<div class="col-12 col-lg-4 section-headeing">...</div>`) with below content and move it from left to right side on homepage:

```
  <div class="col-12 col-lg-4 section-heading">

    {{ $fontSmall := $st.Params.design.font_size_min | default 0.8 }}
    {{ $fontBig := $st.Params.design.font_size_max | default 2.5 }}
    {{ $fontDelta := sub $fontBig $fontSmall }}

    {{ range $taxonomy, $values := site.Taxonomies }}

      {{ $tags := (index site.Taxonomies $taxonomy).ByCount }}
      {{ $count := len $tags }}

      {{/* Warning: Hugo's `Reverse` function appears to operate in-place, hence the order of performing $max/$min matters. */}}
      {{ $max := add (len (index $tags 0).Pages) 1 }}
      {{ $min := len (index ($tags).Reverse 0).Pages }}
      {{ $delta := sub $max $min }}

    <div class="row card-simple">
      <div class="col-12 section-heading">
        <h1>{{ with $taxonomy }}{{ . | markdownify | emojify | title }}{{ end }}</h1>
      </div>
      <div class="col-12">
        {{ if ne $count 0 }}
          <div class="tag-cloud">
            {{ range $name, $term := (sort $tags ".Page.Title" "asc") }}
              {{ $tagCount := len $term.Pages }}
              {{ $weight := div (sub (math.Log $tagCount) (math.Log $min)) (sub (math.Log $max) (math.Log $min)) }}
              {{ $fontSize := add $fontSmall (mul (sub $fontBig $fontSmall) $weight) }}
              <a href="{{ .Page.RelPermalink }}" style="font-size:{{ $fontSize }}rem"><span class="badge badge-light">{{ $tagCount }}</span> {{ .Page.Title }}</a>
            {{ end }}
          </div>
        {{ end }}
      </div>
    </div>
    {{ end }}

  </div>
```

## Localize css/js/font

Edit params.toml to change font to "native" 

```
sed -i 's/font = ""/font = "native"/' params.toml
```

Install [Academic Admin](https://github.com/sourcethemes/academic-admin) tool and import JS and CSS assets to static/

```
pip3 install academic
academic import --assets
```

Add Font Awesome font assets to static/

```
wget https://github.com/FortAwesome/Font-Awesome/releases/download/5.12.0/fontawesome-free-5.12.0-web.zip -o ~/Downloads/
unzip ~/Downloads/fontawesome-free-5.12.0-web.zip
rsync -av fontawesome-free-5.12.0-web/webfonts static/css/
```

## Custom Axonomy term list page

Refer to `themes/academic/layouts/partials/widgets/{tag_cloud,pages}.html`, add template `layouts/_default/terms.html`

```
cat >layouts/_default/terms.html <<EOF>
{{- define "main" -}}

{{ partial "page_header.html" . }}

<div class="universal-wrapper">
  {{ with .Content }}
  <div class="article-style">{{ . }}</div>
  {{ end }}

  {{ if eq .Type "tags" }}

    {{ $st := . }}
    {{ $tags := .Data.Pages }}
    {{ $count := len $tags }}

    {{ $fontSmall := $st.Params.design.font_size_min | default 0.8 }}
    {{ $fontBig := $st.Params.design.font_size_max | default 2.5 }}

    <div class="card-simple">

      {{ if ne $count 0 }}
    
        {{ $fontDelta := sub $fontBig $fontSmall }}
        {{/* Warning: Hugo's `Reverse` function appears to operate in-place, hence the order of performing $max/$min matters. */}}
        {{ $max := add (len (index $tags 0).Pages) 1 }}
        {{ $min := len (index ($tags).Reverse 0).Pages }}
        {{ $delta := sub $max $min }}
        {{ $fontStep := div $fontDelta $delta }}
    
        <div class="tag-cloud">
          {{ range $name, $term := (sort $tags ".Page.Title" "asc") }}
            {{ $tagCount := len $term.Pages }}
            {{ $weight := div (sub (math.Log $tagCount) (math.Log $min)) (sub (math.Log $max) (math.Log $min)) }}
            {{ $fontSize := add $fontSmall (mul (sub $fontBig $fontSmall) $weight) }}
            <a href="{{ .Page.RelPermalink }}" style="font-size:{{ $fontSize }}rem">{{ .Page.Title }}</a>
          {{ end }}
        </div>
      {{ end }}
    
    </div>

  {{ else if eq .Type "categories" }}

    {{ $view := .Params.design.view }}

    {{ range .Data.Pages }}
      {{ $link := .RelPermalink }}
      {{ $target := "" }}
      {{ with .Params.external_link }}
        {{ $link = . }}
        {{ $target = "target=\"_blank\" rel=\"noopener\"" }}
      {{ end }}

      {{ $st := . }}
      {{ $count := len $st.Pages }}

      {{ $view = $st.Params.design.view | default $view }}

      {{ $items_count := $st.Params.content.count }}
      {{ if eq $items_count 0 }}
        {{ $items_count = 65535 }}
      {{ else }}
        {{ $items_count = $items_count | default 5 }}
      {{ end }}

      <div class="card-simple">

        <div class="row">
          <div class="col-12 col-lg-4">
            <h2>
              <a href="{{$link}}" {{ $target | safeHTMLAttr }}>
                <i class="fas fa-folder mr-1"></i>
                {{ .Title }}
                [<span class="">{{ if ge $count $items_count }}{{ $items_count }}/{{ end }}{{ $count }}</span>]</a>
            </h2>
            {{ with $st.Content }}{{ . }}{{ end }}
          </div>
          <div class="col-12 col-lg-8">

            {{ range first $items_count .Pages }}
              {{ if eq $view 1 }}
                {{ partial "li_list" . }}
              {{ else if eq $view 3 }}
                {{ partial "li_card" . }}
              {{ else }}
                {{ partial "li_compact" . }}
              {{ end }}
            {{end}}

          </div>
        </div>

      </div>
      
    {{ end }}

  {{ end }}

</div>

{{- end -}}
EOF
```

Add `content/{tags,categories}/_index.md` to appoint list style to `card`

```
cat >content/categories/_index.md <<EOF
+++
title = "Categories"

[design]
  # 1: list
  # 2: compact
  # 3: card
  view = 3
```

## Custom axonomy term page

Refer to `themes/academic/_default/list.html` and `themes/academic/_default/partials/widgets/pages.html`, add template `layouts/_default/term.html`

```
cat >layouts/_default/term.html <<EOF
{{- define "main" -}}

{{ partial "page_header.html" . }}

<div class="universal-wrapper">

  {{ with .Content }}
  <div class="article-style">{{ . }}</div>
  {{ end }}

  {{ $view := .Parent.Params.design.view }}

  {{ $paginator := .Paginate .Data.Pages }}
  {{ range $paginator.Pages }}
    {{ if eq $view 1 }}
      {{ partial "li_list" . }}
    {{ else if eq $view 3 }}
      {{ partial "li_card" . }}
    {{ else }}
      {{ partial "li_compact" . }}
    {{ end }}
  {{ end }}

  {{ partial "pagination" . }}

</div>

{{- end -}}
EOF
```
