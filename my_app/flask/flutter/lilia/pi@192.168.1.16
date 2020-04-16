from flask_sqlalchemy import SQLAlchemy
from flask import Flask , request , render_template , redirect
from flask_login import login_user, current_user, logout_user, login_required , UserMixin , LoginManager
from flask_bcrypt import Bcrypt
import time as t
import json
from sqlalchemy import or_ , and_
from datetime import datetime
#config :
app = Flask(__name__)
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
loginManager = LoginManager(app)

app.config['SECRET_KEY'] = '5791628bb0b13ce0c676dfde280ba245'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///lilia.db'

#models :
@loginManager.user_loader
def load_user(user_id):
 return User.query.get(int(user_id))

class Room(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    id1 = db.Column(db.Integer, nullable=False )
    id2 = db.Column(db.Integer, nullable=False )
    messages = db.relationship('Chats' , backref='Room' , lazy=True)

class User(db.Model , UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    image_file = db.Column(db.String(20), nullable=False, default='default.jpg')
    password = db.Column(db.String(60), nullable=False)


class Chats(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    message = db.Column(db.String(50), nullable=False)
    time = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    sender_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    reciever_id = db.Column(db.Integer , db.ForeignKey('user.id'), nullable=False)
    room_id = db.Column(db.Integer, db.ForeignKey('room.id'), nullable=False)

#routes :
@app.route('/', methods=['POST'])
def here():
    return '98224148'


@app.route('/lilia' , methods=['GET','POST'])
def lilia():
    data = {}
    data['q'] = str(request.form['q'])
    f = open("commands.txt" , "w")
    f.write(data['q'])
    f.close()
    t.sleep(1)
    res = open ("response.txt" , "r")
    ret = res.read()
    res.close()
    return ret

@app.route('/login', methods=['POST'])
def login():
    username = str(request.form['username'])
    password = str(request.form['password'])
    user = User.query.filter_by(username=username).first()
    if user and bcrypt.check_password_hash(user.password , password):
        return str(user.id)
    else:
        return '0'

@app.route('/admin', methods=['GET' , 'POST'])
def admin_func():
    if request.form['logged'] == 'true' :
        if request.form['id'] != '1':
            return request.form['id']
        elif str(request.form['adduser']) == 'add':
            if User.query.filter_by(username=request.form['username']).count() > 0:
                return 'old user'
            p = bcrypt.generate_password_hash(request.form['password']).decode('utf-8')
            user = User(username=request.form['username'] , password = p)
            db.session.add(user)
            db.session.commit()
            return 'successfully added'
    else:
         return 'notconnected'

@app.route('/test' , methods=['GET', 'POST'])
def test():
    if current_user.is_authenticated:
        return 'already'
    else:
        return '0'

@app.route('/getnum' , methods=['POST'])
def num():
    if request.form['n'] == '1':
        num = User.query.count()
        db.session.commit()
        return str(num)
    if request.form['username'] != 'none':
        user = User.query.filter_by(username=request.form['username']).first()
        return str(user.id)
    users = []
    n = User.query.count()
    db.session.commit()
    for i in range(1,n+1):
        u = User.query.filter_by(id=i).first()
        user = {
        'username' : u.username ,
        'id' : str(u.id),
        'image' : u.image_file   }
        users.append(user)
    return json.dumps(users)


@app.route('/send_message' , methods=['POST'])
def send_message():
    user_id = request.form['partner']
    if request.form['message'] != 'voidmessagevoidmessagevoidmessage':
        conversation_exists = Room.query.filter(or_(and_(Room.id1 == user_id ,
            Room.id2 == request.form['current_user']) ,
             and_(Room.id1 == request.form['current_user'],
          Room.id2 == user_id) )).count() > 0
        if conversation_exists:
            room = Room.query.filter(or_(and_(Room.id1 == user_id ,
                Room.id2 == request.form['current_user']) ,
                 and_(Room.id1 == request.form['current_user'],
              Room.id2 == user_id) )).first()
        if not conversation_exists:
            room = Room(id1 = request.form['current_user'] , id2 = request.form['partner'] )
            db.session.add(room)
            db.session.commit()
        chat_ = Chats(message=request.form['message'] , sender_id=request.form['current_user'] ,
         reciever_id=request.form['partner'] , Room=room)
        db.session.add(chat_)
        db.session.commit()
    messages = Chats.query.filter(or_(and_(Chats.sender_id == user_id ,
        Chats.reciever_id == request.form['current_user']) , and_(Chats.sender_id == request.form['current_user'],
      Chats.reciever_id == user_id) )).order_by(Chats.time.desc()).all()
    messages_data = []
    for message in messages:
        message_data = {
        'message' : message.message,
        'sender' : message.sender_id,
        'reciever' : message.reciever_id,
        'day' : str(message.time.date()),
        'time' : message.time.strftime("%H:%M")
        }
        messages_data.append(message_data)
        print(message_data)
    return json.dumps(messages_data)


@app.route('/chatsdata' , methods=['POST'])
def chatsdata():
    conversations_data = Room.query.filter(or_(
        Room.id2 == request.form['current_user'] ,
         Room.id1 == request.form['current_user']) ).all()
    print(conversations_data)
    conversations = []
    lastmessages = []
    for data in conversations_data:
        if str(data.id1) == request.form['current_user']:
            u = User.query.filter_by(id=data.id2).first()
            lastmsg = findlastmsg(data.id1 , data.id2)
            data = {'username' : u.username
            , 'id' : str(u.id),
            'lastmsg' : lastmsg,
            'image' : u.image_file}
            lastmessages.append(lastmsg)
            conversations.append(data)
        else:
            u = User.query.filter_by(id=data.id1).first()
            lastmsg = findlastmsg(data.id1 , data.id2)
            data = {'username' : u.username ,
            'id' : str(u.id),
            'lastmsg' : lastmsg,
            'image' : u.image_file }
            print(u.image_file)
            lastmessages.append(lastmsg)
            conversations.append(data)
    return json.dumps(conversations)


def findlastmsg(me , friend):
    msg = Chats.query.filter(or_(and_(Chats.sender_id == me ,
        Chats.reciever_id == friend) , and_(Chats.sender_id == friend,
      Chats.reciever_id == me) )).order_by(Chats.time.desc()).first()
    lastmsgdata = {
    'message' : msg.message,
    'time' : msg.time.strftime("%H:%M"),
    'datetime' : str(msg.time)
    }
    return json.dumps(lastmsgdata)

def save_picture(user):
    url = user.id
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = url + f_ext
    picture_path = os.path.join(app.root_path, 'static/'+ picture_fn)

@app.route('/live', methods=['GET'])
def getLiveVideo():
    videoId = request.args['vid']
    return redirect('http://127.0.0.1:1234')


if __name__ == '__main__':
    app.run(debug=True , host='0.0.0.0',port=9877)
