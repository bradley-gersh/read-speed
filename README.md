# Read Speed
A bash script to predict how long you will need to read a document.

## Usage
Execute the script directly in bash via

```bash
./readspeed.sh
```

Once the program begins:

1. Follow the prompt to enter the number of pages you plan to read.
2. Press the Enter key to start a timer when you begin to read.
3. Every time you finish a page, press the Enter key to log the amount of time you spent reading that page. The page timer will automatically restart, under the assumption that you are continuing to the next page.

Whenever you press Enter to signal the end of a page, a small display is shown with the following information:

```
---------------------------------------------
   1 of 400 pages read (399 remaining)
   Time on last page:    0 h 01 m 27 s
   Average:              87.0 sec/page

   Reading time so far:  0 h 01 m 27 s
   Estimated total time: 9 h 40 m 00 s
   Estimated time left:  9 h 38 m 33 s
---------------------------------------------
```

The last line estimates the amount of time remaining for your reading, based on the average duration per page and the number of pages left.

At any time, press `x` to exit to the command prompt.
