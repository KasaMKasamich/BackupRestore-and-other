
-------------------------------------------------------------------------------------------------------

7zip-Parameter-Generator may be distributed freely and you're wellcome to give me suggestions for
improvements by mailing me on dummyddd@hotmail.com

-Dummy Da Dumb Dane


This program is made for the switches in version 2.30 beta 32 of 7-zip, newer help programs for newer
versions of 7-zip will be released shortly.
(I don't have an internet connection, floppy drive, usb ram or any way to send data in other way than
burning a CD or getting LAN connection with someone with either Internet connetion or floppy drive or
anything!!)

-------------------------------------------------------------------------------------------------------



Little help:


(FB) Fast Bytes
When incereased it will (most likely) improve compression rate of LZMA, Deflate and Deflate64 (however
it often gives worse compression ratio when values are above 128 as oposed to 128) .
Compression requires fast bytes * 128 kilobytes * passes (Deflate and Deflate64 only) , extra free ram.
Higher numbers make the compressing/decompression take longer.
The maximum value is 255.
For LZMA, Deflate and Deflate64 algorithms.
(if you have a desent amounth of ram then feel free to select 128 for this option)

(D) Dictionary Size
Selects how much data should be im memory for compressing when comparing for LZMA.
Value is equal to 2^value * bytes (20=1MB,21=2MB,22=4MB) , you can also define these by
adding a b (for bytes) k (for kilobytes) or m (for megabytes).
When decompressing you have to have at least an amounth of free ram equal to it's value if you don't
want your pagefile to slow down your system, for compressing you need far more!!
High values (most likely) improves compression ratio and make compressing/decompressing take longer
(very little if you have enough ram) .
The maximum value is 28(256M=0,25GB).
For LZMA algorithm.
(for normal use select below 1/10 of total memory, if you need better you can still use near 1/4
without becomming to slow)

(A) Mode
High values increases compression ratio and makes compression/decompression take longer.
Can use values 1, 2 and 3.
For LZMA algorithm.
(pays of to select high values)

(PASS) Passes
Defines the level of compression for deflate and deflate64 compressions.
Compression requires fast bytes * 128 kilobytes * passes, extra ram.
Higher numbers make the compressing/decompression take longer, and improves the compression level.
Can use values 1, 2, 3 and 4.
For Deflate and Deflate64
(if you have a desent amounth of ram then feel free to select 4 for this option)

(MEM) Memory
Selects how much data should be im memory for compressing when comparing for PMMd.
Value is equal to 2^value * bytes (20=1MB,21=2MB,22=4MB) , you can also define these by
adding a b (for bytes) k (for kilobytes) or m (for megabytes).
When compressing/decompressing you have to have at least an amounth of free ram equal to it's value
if you don't want your pagefile to slow down your system.
High values (most likely) improves compression ratio and make compressing/decompressing take longer
(very little if you have enough ram) .
The maximum value is 31 (2048M=2GB).
PMMd.
(I personly never use PMMd so I have no hints on this one, you're wellcome to give me suggestions
for improvements by mailing me on dummyddd@hotmail.com)

(O) Model Order
Selects which model order PMMd will use to compress data.
Lowest level is 2 and highest is 32.
(I don't know anything about setting this but I've heard that 16 is a good setting for this)

(LP) Literal Pos
I know nothing about this you're wellcome to give me suggestionsfor improvements by mailing me on
dummyddd@hotmail.com.
(0 or 1 usaually gives best result)

(LC) Literal Context
I know nothing about this you're wellcome to give me suggestionsfor improvements by mailing me on
dummyddd@hotmail.com.
(I'd recommend using default)

(PB) Pos Context
I know nothing about this you're wellcome to give me suggestionsfor improvements by mailing me on
dummyddd@hotmail.com.
(I'd recommend using default)

(S) Solid
Choose wether or not the archive should be solid or not.
That an archive is solid means that 7-zip treats all files it is about to compress as a continuous
data stream.
The effect is often better compression and slightly increased compression time. The downside of solid
is that the archive will not contain data about every files size (so you can't see the decompressed
file size in 7-zips filemanger) and when you decompress a single file from an archive 7-zip (aswell
as all other utilities) you have to decompress the whole archive to get to the file. Is set on or off.
For 7z.
(I'd recommend it)

(HC) Header Compression
Choose wether or not 7-zip should compress some of the archives header with LZMA method.
Usually gives better (little) compression ratio when on. Is set on or off. For 7z.
(I'd recommend)

(HCF) Full Header Compression
Choose wether or not 7-zip should compress the archives header with LZMA method. Sometimes full header
compressing gives better results than header compression. Is set on or off. For 7z.
(I'd recommend it)

(F) Compression Filter
Choose wether or not to automaticly use BCJ or BCJ2 on sertain files (dll, exe, ocx, sfx, sys in
3.09.01 beta) . If you use this program to make parameters for you it might not work that well.
(Using a full parameter might not work that well but it optimizes the compression ratio for those who
don't. I woldn't recommend it if you use this preogram to help you with the parameters)

(MF) Match Finder
Defines how the LZMA algorithm finds matches, the default is bt4.
Here are the different possible values:

  ---------------------------------------------------------------------------------------
 | value | extra memory requirement | explanaition                                       |
 |-------|--------------------------|----------------------------------------------------|
 | bt2   | d*9.5 + 1MB              | Binary Tree with 2 bytes hashing.                  |
 | bt3   | d*9.5 + 65MB             | Binary Tree with 2-3(full) bytes hashing.          |
 | bt4   | d*9.5 + 6MB              | Binary Tree with 2-3-4 bytes hashing.              |
 | bt4b  | d*9.5 + 34MB             | Binary Tree with 2-3-4(big) bytes hashing.         |
 | pat2r | d*26 + 1MB               | Patricia Tree with 2-bits nodes, removing.         |
 | pat2  | d*38 + 1MB               | Patricia Tree with 2-bits nodes.                   |
 | pat2h | d*38 + 77MB              | Patricia Tree with 2-bits nodes, 2-3 bytes hashing.|
 | pat3h | d*62 + 85MB              | Patricia Tree with 3-bits nodes, 2-3 bytes hashing.|
 | pat4h | d*110 + 101MB            | Patricia Tree with 4-bits nodes, 2-3 bytes hashing.|
 | hc3   | d*5.5 + 1MB              | Hash Chain with 2-3 bytes hashing.                 |
 | hc4   | d*5.5 + 6MB              | Hash Chain with 2-3-4 bytes hashing.               |
  ---------------------------------------------------------------------------------------

bt
All of the bt's give the same compression ratio but different compression time.
Bt4 or bt4b should be the ones offering you the fastest compression time but if you don't have quite
enough free ram compressing will most likely go faster if you select bt3 or bt2.
Bt offers a good compression ratio.
-------------------------------------------------------------------------------------------------------
pat
Pat requires a lot of ram for compression.
Theres a difference from path and pat or patr, path gives far better compression ratios.
All of the path's give the same compression ratio but different compression time.
Pat4h should be the one offering you the fastest compression time but if you don't have quite
enough free ram, (very likely as you will often need several GB's free ram) compressing will most
likely go faster if you select pat2h.
-------------------------------------------------------------------------------------------------------
hc
Hc gives the worst compression ratio, lowest ram requirements for compression and fastest compression
Hc4 should be the one offering you the fastest compression time but if you don't have quite
enough free ram, compressing will most likely go faster if you select hc3.
-------------------------------------------------------------------------------------------------------


(M) Methods
Defines which algorithm will be used for compression here are the different posible values:
-------------------------------------------------------------------------------------------------------
LZMA
Is the defaylt for and can only be used by 7z.
A rather new compression algorithm that allows usage of dictionary sizes up to 256MB (winrar allows up
to 4MB) , provides good compression for most files. Often gives better compression ratios if the files
have been precompressed by tar or another archive of the like.
Gives 7-zips so far best compression ratio for dll and exe files, however it's also quite lousy when it
comes to wav, bmp and precompressed data (zip, rar, ace) with the exception of tar and other archives
of the like. Decompressing usally takes about 10-20 times less time than compressing.
(recommended algorithm)
-------------------------------------------------------------------------------------------------------
PMMd
Can be used by 7z.
PPMd is a PPM-based algorithm, it's is mostly based on Dmitry Shkarin's PPMdH sources.
PPMd provides 7-zips so far best compression ratio for textfiles (txt rtf doc htm pdf ini and tons
others) and far from the worst on other datatypes.
(recommended algorithm for compressing textfiles)
-------------------------------------------------------------------------------------------------------
Deflate64
Can be used by zip and gzip.
A rather new compression algorithm released by PKZip, that isn't yet supported by all
compression/decompression programs/utilities, I think what it's supported by Windows Xp/2003.
It provides better compression rate than normal Deflate without increasing the compression time (as far
as I know) .
(NOT ALL COMPRESSION PROGRAMS SUPPORT ZIP WITH DEFLATE64)
-------------------------------------------------------------------------------------------------------
BZip2
Is the default for bz2 and can be used by 7z, bz2, zip and gzip.
A compression algorithm made for the LINUX project, that gives incredible compression ratios when
comparing to the compression time. Often gives better compression ratios if the files have been
precompressed by tar or another archive of the like.
Gives 7-zip so far best compression ratio on wav and bmp.
(recommended if you don't want to use to much time compressing or if you compress bmp or wav files, and
zip, bz2 and gzip)
-------------------------------------------------------------------------------------------------------
Tar/Copy
Tar is actualy a fileformat and not really an algorith.
Tar/Copy algorithm gives below zero compression ratio.
Tar/Copy sorts files into a single file. Some compression alogrithms are more effective if you first
tar the files into a file.
(before BZip2)
-------------------------------------------------------------------------------------------------------
Deflate
Is the default for zip and gzip can be used by 7z, zip and gzip.
Probarbly the most widespread and most supported compression method, it has been the standard for zip
for ages.
Gives a better than nothing compression that beats LZMA on wav.
(Standard for zip)
-------------------------------------------------------------------------------------------------------
BCJ/BCJ2
BCJ2 is Branch converter for 32-bit x86 executables. It converts some branch instructions for
increasing further compression.
It uses one input stream and 3 (for BCJ) to 4 (for BCJ2) . Each of these output streams can be
compressed further with another algorithm, this increases the compression ratio for dll and exe files.
Stream no. 3 (for BCJ) or 4 (for BCJ2) is allready fully compressed and it's therefore not recommended
that you try to compress it further and.
Stream no. 2 (for both) and 3 (for BCJ2) if compressed by LZMA does not benefit much from dictionary
sizes above 512KB (2^19) .
Stream no. 1 should be compressed as heavily as possible.
(more diffucult to use but gives better compression ratio on exe and dll files)


-------------------------------------------------------------------------------------------------------

You're wellcome to give me suggestions for improvements by mailing me on dummyddd@hotmail.com

This program is made to stop people botherring Igor for a more "beautifull" 7-zip, beacouse it's good
the way it is and he should focus on whatever he believes to be best.

This program makes parameters without any errors for 7-zip version 3.09.01 beta and newer (I choose the
7z parameters using this program so if you can read this it has to work) , but upcomming version of
this program will have the new switches that come in newer versions of 7-zip.