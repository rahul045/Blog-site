from flask import Flask,redirect, render_template,request,session
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.utils import secure_filename
import json
import os
import math
from flask_mail import Mail

with open('config.json','r') as c:
    params = json.load(c)["params"]

db = SQLAlchemy()
# create the app
app = Flask(__name__)

app.config['UPLOAD_FOLDER']=params['upload_location']
app.secret_key='super-secret-key'
if(params['local_server']):
    # configure the SQLite database, relative to the app instance folder
    app.config["SQLALCHEMY_DATABASE_URI"] = params['local_uri']
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = params['prod_uri']
# initialize the app with the extension
db.init_app(app)

class  Contact_us(db.Model):
    sno = db.Column(db.Integer, primary_key=True,  nullable=False)
    name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50),unique=True,nullable=False)
    phone = db.Column(db.Integer,unique=True, nullable=False)
    msg = db.Column(db.String(200), nullable=False)
    date = db.Column(db.String(50), nullable=True)

class  Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True,  nullable=False)
    title = db.Column(db.String(50), nullable=False)
    tagline= db.Column(db.String(50), nullable=False)
    slug = db.Column(db.String(50),unique=True,nullable=False)
    content = db.Column(db.String(100), nullable=False)
    img_file = db.Column(db.String(50), nullable=False)
    date = db.Column(db.String(50), nullable=True)

@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['no_of_posts']))

    #[0:params['no_of_posts']]
    page=request.args.get('page')
    if (not str(page).isnumeric()):
        page=1
    page=int(page)
    posts =posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]

    #pagination logic
    #first
    if(page==1):
      prev="#"
      next="/?page="+str(page+1)
    # last
    elif (page == last):
      prev = "/?page=" + str(page - 1)
      next = "#"
    #middle
    else:
      prev = "/?page=" + str(page - 1)
      next="/?page="+str(page+1)

    return render_template('index.html',params=params,posts=posts,prev=prev,next=next)

@app.route("/about")
def about():
    return render_template('about.html',params=params)


@app.route("/dashboard",methods=['GET','POST'])
def dashboard():
    if ('user' in session and session['user'] == params['admin_user']) :
        posts = Posts.query.all()
        return render_template('dashboard.html',params=params,posts=posts)

    if request.method=='POST':
        username=request.form.get('uname')
        password=request.form.get('pass')
        if(username==params['admin_user'] and password==params['admin_password']):
            #set the session variable
            session['user']=username
            posts=Posts.query.all()
        return render_template('dashboard.html', params=params,posts=posts)

    return render_template('sign_in.html',params=params)

@app.route("/logout", methods=['GET'])
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
           if(request.method=='POST'):
                 f=request.files['file1']
                 f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
                 return "Uploaded Successfully"




@app.route("/delete/<string:sno>", methods=['GET'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
              post=Posts.query.filter_by(sno=sno).first()
              db.session.delete(post)
              db.session.commit()
    return redirect('/dashboard')

@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        '''Add entry to database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        msg = request.form.get('msg')
        entry = Contact_us(name=name, phone=phone, email=email, msg=msg, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        # mail.send_message('New message from ' + name,
        #                   sender=email,
        #                   recipients=[params['gmail-user']],
        #                   body=msg + "\n" + phone
        #                   )
    return render_template('contact.html', params=params)

@app.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    post=Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=post)

@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
            if request.method=='POST':
                req_title=request.form.get('title')
                req_tag=request.form.get('tagline')
                req_slug=request.form.get('slug')
                req_content=request.form.get('content')
                req_img=request.form.get('img')
                date=datetime.now()
                if sno=='0':
                    post=Posts(title=req_title,tagline=req_tag,slug=req_slug,content=req_content,img_file=req_img,date=date)
                    db.session.add(post)
                    db.session.commit()
                else:
                    post=Posts.query.filter_by(sno=sno).first()
                    post.title=req_title
                    post.slug=req_slug
                    post.tagline=req_tag
                    post.content=req_content
                    post.img_file=req_img
                    post.date=date
                    db.session.commit()
                    return redirect('/edit/'+sno)
    post=Posts.query.filter_by(sno=sno).first()
    return render_template('edit.html',params=params,post=post,sno=sno)



app.run(debug=True)


