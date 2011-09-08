
if !has('python')
    "echo "Error: Required vim compiled with +python"
    finish
endif

" Vim comments start with a double quote.
" Function definition is VimL. We can mix VimL and Python in
" function definition.
function! Clippy() range

" We start the python code like the next line.
python << EOF

# the vim module contains everything we need to interface with vim from
import vim
import math

words_list = ["it", "looks", "like", "you", "are", "writing", "a", "letter"]
words_list = []
#print int(vim.eval("a:firstline")), int(vim.eval("a:lastline"))
for line in xrange(int(vim.eval("a:firstline"))-1, int(vim.eval("a:lastline"))):
    line = vim.current.buffer[line]
    #print line
    for word in line.split():
        #print word
        words_list.append(word)

length_of_input =  sum(len(x)+1 for x in words_list)
max_length = 204 #70 - width of clippy and bubble * 4
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
        s = clippy[line]+" "+boxy[line] + ((length_of_line * spacer) + post_text[line])
        outgoinglines.append(s)
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
        outgoinglines.append("".join(outstring))


        #vim.current.buffer.append(outgoinglines)
#pos = (vim.current.window.cursor)[0]
pos = int(vim.eval("a:lastline"))
newbuff = vim.current.buffer[:pos] + outgoinglines + vim.current.buffer[pos:]

vim.current.buffer[0:len(newbuff)] = newbuff
EOF
" Here the python code is closed. We can continue writing VimL or python again.
endfunction
command! -range -nargs=* Clippy <line1>,<line2>call Clippy()

