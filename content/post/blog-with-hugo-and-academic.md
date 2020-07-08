---
title: "Blog with Hugo and Academic"
subtitle: ""
tags: ["hugo", "academic"]
categories: ["blog"]
date: 2020-07-01T23:07:31+08:00

summary: "记录使用Hugo和Academic主题搭建博客系统的步骤。"

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

- refer to `theme/academic/layouts/partials/widgets/tag_cloud.html`, replace "Recent Post" partial (`<div class="col-12 col-lg-4 section-headeing">...</div>`) with below content and move it from left to right side on homepage:

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
