# Equalizer
### Motivation

There are times when images provided by UI designers are not named the way you would like.

If this bothers you much, and you don't want to take the effort to modify file names and `Contents.json` files as well, you should try this little tool.

As you might already guessed, this tool will modify content in `Contents.json` file and change image asset file names to reflect the name you set to `.imageset` item in Xcode, resulting matching asset file name and name set in xcode.



### Usage

1. Download this repo
2. Open in Xcode
3. Build
4. Locate the built executable binary in `Product` section
5. Copy this binary to any directory which has `.xcassets` sub directory in it
6. Execute without any parameters



**Or**

1. Download this repo

2. Open in Xcode

3. Set the correct build destination  (in Build Settings— Build Locations— Build Product Path) to any directory which has `.xcassets` sub directory in it

4. Run

   ​

### Embed code

This is like a one-shot simple tool made in like half an hour, so in terms of  dependency, I don't take a serious way like introducing those fancy dependency manager, instead, just grab and drag the source file in. 

In this case it's [PathKit](https://github.com/kylef/PathKit), a fancy elegant library regarding path managing. 