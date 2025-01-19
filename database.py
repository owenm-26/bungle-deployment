import mysql.connector as mdb
from bottle import FormsDict
from hashlib import md5

password_user = "a23e18e1ec8c0500c00fe45a4c37217e6a5cedd6008eb2b1"

# Read-write connection
def connect():
    return mdb.connect(host="localhost",
                       user="project2",
                       passwd=password_user,
                       db="project2")

def createUser(username, password):
    db_rw = connect()
    salt = 'a0'
    cur = db_rw.cursor()
    
    # Hash password with salt using md5
    password_hash = md5((salt + password).encode('utf-8')).digest()

    cur.execute("INSERT INTO users (username, password, passwordhash, salt) VALUES(%s, %s, %s, %s)",
                (username, password, password_hash, salt))
    db_rw.commit()

def validateUser(username, password):
    db_rw = connect()
    cur = db_rw.cursor()
    
    # Hash password with salt (it seems no salt is provided here in the function)
    salt = 'a0'  # Assuming same salt for validation
    password_hash = md5((salt + password).encode('utf-8')).digest()

    cur.execute("SELECT id FROM users WHERE username=%s AND passwordhash=%s", (username, password_hash))
    if cur.rowcount < 1:
        return False
    return True

def fetchUser(username):
    db_rw = connect()
    cur = db_rw.cursor(mdb.cursors.DictCursor)
    cur.execute("SELECT id, username FROM users WHERE username=%s", (username,))
    if cur.rowcount < 1:
        return None
    return FormsDict(cur.fetchone())

def addHistory(user_id, query):
    db_rw = connect()
    cur = db_rw.cursor()
    cur.execute("INSERT INTO history (user_id, query) VALUES(%s, %s)", (user_id, query))
    db_rw.commit()

def getHistory(user_id):
    db_rw = connect()
    cur = db_rw.cursor()
    cur.execute("SELECT DISTINCT query FROM history WHERE user_id = %s LIMIT 15", (user_id,))
    rows = cur.fetchall()
    return [row[0] for row in rows]
