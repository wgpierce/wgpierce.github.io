---
layout: page
title: Projects
permalink: /projects/
---

Here is a list of the projects I have done

### In college:
<ul class="post-list">
{% assign sorted_projects = site.projects | sort:"order" %}
{% for project in sorted_projects %}
{% if project.time_period == "college" %}
  <li>
    <h2>
      <a class="post-link" href="{{ project.url | prepend: site.baseurl }}">{{ project.title }}</a>
    </h2>
  </li>
{% endif %} 
{% endfor %}
  <li>
    <h2>
      <a class="post-link" href="https://devpost.com/software/whattowatch">HackIllinois 2015</a>
    </h2>
    <a href="https://github.com/wgpierce/HackIllinois2015">Github</a>
  </li>
  <li>
    <h2>
      <a class="post-link" href="https://github.com/wgpierce/Cruise-Control-HUD">Cruise Control HUD</a>
    </h2>
  </li>
</ul>

### In high school:
<ul class="post-list">
{% for project in site.projects %}
{% if project.time_period == "high school" %}
  <li>
    <h2>
      <a class="post-link" href="{{ project.url | prepend: site.baseurl }}">{{ project.title }}</a>
    </h2>
  </li>
{% endif %}
{% endfor %}
</ul>

### Computers I have built:
<ul class="post-list">
  <li>
    <h2>
      <a class="post-link" href="https://pcpartpicker.com/user/JudgeVanadium/builds/">Computers</a>
    </h2>
  </li>
</ul>

### My github:
<ul class="post-list">
  <li>
    <h2>
      <a class="post-link" href="https://github.com/{{ site.github_username }}">Github</a>
    </h2>
  </li>
</ul>

<a>
