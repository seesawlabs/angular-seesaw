### Deployment

to make a new release:  
1. make sure `git-flow` is installed  
2. git-flow release start v0.1.x  
3. run `gulp dist`  
4. update **bower.json** and **package.json** with new version  
5. commit your changes  
6. run `git-flow release finish v0.1.x`  
7. push changes to master  
8. push tags: `git push --tags`  
9. Open project and run `bower update angular-seesawlabs`  
