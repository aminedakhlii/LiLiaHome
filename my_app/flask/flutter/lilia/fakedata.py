"""from __init__ import db , User , bcrypt , Chats , Room

user = User(username='amine',password=bcrypt.generate_password_hash('emino').decode('utf-8'))
db.session.add(user)
db.session.commit

user2 = User(username='rafik',password=bcrypt.generate_password_hash('raf1968').decode('utf-8'))
db.session.add(user2)
db.session.commit()

user3 = User(username='lamia',password=bcrypt.generate_password_hash('1971').decode('utf-8'))
db.session.add(user3)
db.session.commit()

user4 = User(username='wajdi',password=bcrypt.generate_password_hash('2011').decode('utf-8'))
db.session.add(user4)
db.session.commit()"""
import base64
"""image = open('pdp.jpg' , 'rb')
str = base64.b64encode(image.read())
saved = open('image.bin' , 'wb')
saved.write(str)"""
fh = open('image.jpg','wb')
f = open('image.bin','rb')
fh.write(f.read().decode('base64'))
