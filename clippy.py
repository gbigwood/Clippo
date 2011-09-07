"""
Prints you a clippy using the input text you give it
"""

import sys
import math

words_list =sys.argv[1:] 
length_of_input =  sum(len(x)+1 for x in words_list)
max_length = 204 #70 - width of clippy and bubble * 4
clippy = r"""
 __  
/  \ 
|  | 
@  @ 
|| ||
|| ||
|\_/|
\___/
"""

boxy = r"""

      _
     / 
     | 
     | 
  <--| 
     | 
     \_
"""

post_text = r"""


\
|
|
|
|
/
"""
clippy = "\n __  \n/  \ \n|  | \n@  @ \n|| ||\n|| ||\n|\_/|\n\___/\n"
boxy = "\n \n      _\n     / \n     | \n     | \n  <--| \n     | \n     \_\n"
post_text = "\n \n \n\\\n|\n|\n|\n|\n/\n"



boxy = boxy.split("\n")
clippy = clippy.split("\n")
post_text = post_text.split("\n")

if (length_of_input < max_length):#if we dont have to extend the depth of the speech bubble
    words_per_line = math.ceil(len(words_list) / 4.0) #there are 4 lines
#length_of_line = (max(len(x) for x in words_list) + 1) * int(words_per_line) # 
length_of_line = 0
#so there is enough space
#print words_per_line,length_of_line
outgoinglines = []#the strings that will be printed out
usedwords = 0
for line in xrange(len(clippy)):
    if (line >= 3) and not(line ==8):#put words
        usedstring = 0
        currwords = 0
        while (currwords < words_per_line) and (usedwords < len(words_list)):
            this_word = words_list[usedwords]
            #outstring.append((length_of_line - len(this_word) ) * " ")
            currwords += 1
            usedwords +=1
            usedstring += (len(this_word)+1)
            if usedstring > length_of_line:
                length_of_line = usedstring
for line in xrange(len(clippy)):
    if (line==2) or (line == 8):
        spacer = "_"
    else:
        spacer = " "
    if (line < 4) or (line == 8):#none of other words 
        #print clippy[line],boxy[line] + (length_of_line * spacer) + 
        #post_text[line]
        s = clippy[line]+" "+boxy[line] + ((length_of_line * spacer) + post_text[line])
        print s
    elif line >= 3:#put words
        outstring = []
        outstring.append(clippy[line]+" ")
        outstring.append(boxy[line])
        #TODO make this a function so that we can work out the max line length 
        #before printing 
        currwords = 0
        usedstring = 0
        while (currwords < words_per_line) and (len(words_list) > 0):
            this_word = (words_list).pop(0)
            outstring.append(this_word + " ")
            #outstring.append((length_of_line - len(this_word) ) * " ")
            currwords += 1
            usedstring += len(this_word)+1
        outstring.append((length_of_line - usedstring) * " ")
        outstring.append(post_text[line])
        print "".join(outstring)
