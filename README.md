# Microblog

https://github.com/chpeters/microblog
microblog homepage: http://microblog.cs4550.fun

I added the ability to like messages. Liking messages is similar to Insta where the heart becomes filled on a message when you have liked something (and you can only like it once), or it is empty when you haven't liked something. I added the ability to unlike a post by clicking on the heart again, and each time you click on the heart, the page should show the correct heart immediately after.

The deploy script works on the remote server by building and creating a release. You still have to manually copy the output command of the script and add either start or foreground to the end to run the server, but it drastically reduces the amount of time to run the app. Next week, I'll add the finishing touches so you don't have to type start or foreground after, but instead takes it as an argument to the command.