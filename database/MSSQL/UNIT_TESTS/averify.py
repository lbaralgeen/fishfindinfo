#c:\Python27 

import os, sys
import hashlib
import pickle
import configparser

settings = configparser.ConfigParser()
settings.read('config.ini')

hash_lines = []
fs = open('result.txt', encoding='utf-8', errors='ignore')
hash_lines = fs.readlines()
z = pickle.dumps(hash_lines)
checksum = hashlib.md5(z).hexdigest()

# -------------------   remove lines with garbidge patterns ----------------------
main_file = open('result.txt', encoding='utf-8', errors='ignore').read()   # your main dataBase file
filter_file = open('error.txt', 'w')
filter_file.write(main_file)
filter_file.close()

main_file = open('cleaned.txt', 'w')
for line in open('error.txt'):
    if 'PASSED' not in line and 'Warning: Null value' not in line and '(0 rows affected)' not in line and '(1 rows affected)' not in line and '----' not in line and line != '\n':
        main_file.write(line.lstrip())                # put all strings back to your db except deleted
    else: pass
main_file.close()

# -------------------   calc crc and do not match saved then send email with attach error file ----------------------
savedhash = settings.get('mail','crcstate')
if savedhash != checksum:
    print (savedhash)
    print (checksum)
    os.system('python smtppart.py') 
