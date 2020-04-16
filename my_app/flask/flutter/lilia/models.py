import requests
import os , subprocess
import json , socket
#url = 'http://192.168.1.11:9877/'
d = {
'partner' : '3',
'current_user' : '4',
'message' : 'khedmet?? ?'

    }
GET_IP_CMD ="hostname -I"
def run_cmd(cmd):
     return subprocess.check_output(cmd, shell=True).decode('utf-8')
ip = run_cmd(GET_IP_CMD)
print(ip)
"""for i in range(0,100):
        url = 'http://192.168.1.' + str(i)+ ':9877/'
        try:
            x = requests.post(url)
            if x.text == '98224148':
                print(url)
                break
        except:
            pass"""
