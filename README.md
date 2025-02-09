# This is a repository to store the various scripts I use on my linux Desktop.
For now they are all in bash but I may use python or something like that in the future. This will be where I keep most the things that I write to put in my "Tools" directory. I don't see any reason why these shouldn't be available to others for educational or personal use. I doubt you'll find any commercial use from these but if you do then by all means go for it. 


## Future Additions
1. ### [repo_gen.sh](./repo_gen.sh)
    doesn't currently generate a .git repository, just makes a cmake project using Ninja. in the future I plan to have it automatically create the .git repository. I may leave the up-stream to the user, I may automate that as well with proper error handling, I have not decided yet.
2. ### [compressHome.sh](./compressHome.sh)
    this script will destroy your `$USER` directory. I need to go back over this one and ensure it is doing what I expect it to do. it was behaving strangely the last time I messed with it and I looked back at it it's trash don't look. I'll fix it soon `;-;`
3. ### possibly Autorun scripts that run on startup
    this one is kinda self explanatory, I may also add an `idle.sh` script to run when my computer idles for x amount of time.