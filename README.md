# Forward Into The Past
![ProjectLogo](https://raw.githubusercontent.com/AlexKalinin/forward_into_the_past/master/logo.jpg)

## or hacking GitHub-report on "Public contributions" with simple [ruby script](src/run.rb)
![ReportImage](https://raw.githubusercontent.com/AlexKalinin/forward_into_the_past/master/report_image.png)

## Preface
I have some my old projects which I would want publish on GitHub. I pushed some of them to the GitHub, but I was confused: The "Public contributions" GitHub-report showing only my last 
days activity, but I worked on these projects during several years. So I thought: it would
be nice to spread commits in history. 

In [this post](http://eddmann.com/posts/changing-the-timestamp-of-a-previous-git-commit/) I found that I can change date 
of commits locally:

```
$ git commit --date="Sat, 14 Dec 2013 12:40:00 +0000" # only author
$ GIT_COMMITTER_DATE="`date -R`" git commit --date "`date -R`" # for both
```

I made several commits and pushed them to GitHub. The GitHub-report showed wrong date on my commits. It works!

Ok, now need to implement this idea on practice. I just began study ruby programming language, so I decided to write 
simple ruby-scripts to automate this issue (see [src](src/) folder)

So that was done after pushing repository:
![ReportImage](https://raw.githubusercontent.com/AlexKalinin/forward_into_the_past/master/report_image_after_hack.png)
