---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: splash
permalink: /
hidden: true
read_time: false
header:
  overlay_color: "#5e616c"
  overlay_image: /assets/images/mm-home-page-feature.jpg
excerpt: >
    I research things I find interesting,<br />
    then document my research with a public blog post, <br />
    which I can easily find and refer to later.<br /><br />
    Hopefully other people will find these posts helpful,<br/> relevant, or interesting.
feature_row:
  - image_path: /assets/images/mm-customizable-feature.png
    alt: "customizable"
    title: "Awesome shell"
    excerpt: "Configure a beautiful terminal on Unix with Zsh."
    url: "/hello_shell/hello_shell/"
    btn_class: "btn--primary"
    btn_label: "Read more"
  - image_path: /assets/images/mm-responsive-feature.png
    alt: "fully responsive"
    title: "Setup k8s cluster"
    excerpt: "Follow this documentation to set up a Kubernetes cluster on Ubuntu."
    url: "/hello_kubernetes/setup_k8s_cluster/"
    btn_class: "btn--primary"
    btn_label: "Read more"
  - image_path: /assets/images/mm-free-feature.png
    alt: "omnibus gitlab"
    title: "Omnibus Gitlab"
    excerpt: "Creates full-stack platform-specific downloadable packages for GitLab."
    url: "/hello_gitlab/Omnibus/"
    btn_class: "btn--primary"
    btn_label: "Read more"
---

{% include feature_row %}
